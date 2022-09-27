// Copyright 2017 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

// Dart imports:
import 'dart:async';
import 'dart:io';

import 'package:better_player/src/configuration/better_player_buffering_configuration.dart';
import 'package:better_player_platform_interface/better_player_platform_interface.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

final BetterPlayerPlatform _videoPlayerPlatform = BetterPlayerPlatform.instance
// This will clear all open videos on the platform when a full restart is
// performed.
  ..init();

/// The duration, current position, buffering state, error state and settings
/// of a [VideoPlayerController].
class VideoPlayerValue {
  /// Constructs a video with the given values. Only [duration] is required. The
  /// rest will initialize with default values when unset.
  VideoPlayerValue({
    required this.duration,
    this.size,
    this.position = const Duration(),
    this.absolutePosition,
    this.buffered = const <DurationRange>[],
    this.isPlaying = false,
    this.isLooping = false,
    this.isBuffering = false,
    this.volume = 1.0,
    this.speed = 1.0,
    this.errorDescription,
    this.isPip = false,
  });

  /// Returns an instance with a `null` [Duration].
  VideoPlayerValue.uninitialized() : this(duration: null);

  /// Returns an instance with a `null` [Duration] and the given
  /// [errorDescription].
  VideoPlayerValue.erroneous(String errorDescription)
      : this(duration: null, errorDescription: errorDescription);

  /// The total duration of the video.
  ///
  /// Is null when [initialized] is false.
  final Duration? duration;

  /// The current playback position.
  final Duration position;

  /// The current absolute playback position.
  ///
  /// Is null when is not available.
  final DateTime? absolutePosition;

  /// The currently buffered ranges.
  final List<DurationRange> buffered;

  /// True if the video is playing. False if it's paused.
  final bool isPlaying;

  /// True if the video is looping.
  final bool isLooping;

  /// True if the video is currently buffering.
  final bool isBuffering;

  /// The current volume of the playback.
  final double volume;

  /// The current speed of the playback
  final double speed;

  /// A description of the error if present.
  ///
  /// If [hasError] is false this is [null].
  final String? errorDescription;

  /// The [size] of the currently loaded video.
  ///
  /// Is null when [initialized] is false.
  final Size? size;

  ///Is in Picture in Picture Mode
  final bool isPip;

  /// Indicates whether or not the video has been loaded and is ready to play.
  bool get initialized => duration != null;

  /// Indicates whether or not the video is in an error state. If this is true
  /// [errorDescription] should have information about the problem.
  bool get hasError => errorDescription != null;

  /// Returns [size.width] / [size.height] when size is non-null, or `1.0.` when
  /// size is null or the aspect ratio would be less than or equal to 0.0.
  double get aspectRatio {
    if (size == null) {
      return 1.0;
    }
    final double aspectRatio = size!.width / size!.height;
    if (aspectRatio <= 0) {
      return 1.0;
    }
    return aspectRatio;
  }

  /// Returns a new instance that has the same values as this current instance,
  /// except for any overrides passed in as arguments to [copyWidth].
  VideoPlayerValue copyWith({
    Duration? duration,
    Size? size,
    Duration? position,
    DateTime? absolutePosition,
    List<DurationRange>? buffered,
    bool? isPlaying,
    bool? isLooping,
    bool? isBuffering,
    double? volume,
    String? errorDescription,
    double? speed,
    bool? isPip,
  }) {
    return VideoPlayerValue(
      duration: duration ?? this.duration,
      size: size ?? this.size,
      position: position ?? this.position,
      absolutePosition: absolutePosition ?? this.absolutePosition,
      buffered: buffered ?? this.buffered,
      isPlaying: isPlaying ?? this.isPlaying,
      isLooping: isLooping ?? this.isLooping,
      isBuffering: isBuffering ?? this.isBuffering,
      volume: volume ?? this.volume,
      speed: speed ?? this.speed,
      errorDescription: errorDescription ?? this.errorDescription,
      isPip: isPip ?? this.isPip,
    );
  }

  @override
  String toString() {
    // ignore: no_runtimetype_tostring
    return '$runtimeType('
        'duration: $duration, '
        'size: $size, '
        'position: $position, '
        'absolutePosition: $absolutePosition, '
        'buffered: [${buffered.join(', ')}], '
        'isPlaying: $isPlaying, '
        'isLooping: $isLooping, '
        'isBuffering: $isBuffering, '
        'volume: $volume, '
        'errorDescription: $errorDescription)';
  }
}

/// Controls a platform video player, and provides updates when the state is
/// changing.
///
/// Instances must be initialized with initialize.
///
/// The video is displayed in a Flutter app by creating a [VideoPlayer] widget.
///
/// To reclaim the resources used by the player call [dispose].
///
/// After [dispose] all further calls are ignored.
class VideoPlayerController extends ValueNotifier<VideoPlayerValue> {
  final BetterPlayerBufferingConfiguration bufferingConfiguration;

  /// Constructs a [VideoPlayerController] and creates video controller on platform side.
  VideoPlayerController({
    this.bufferingConfiguration = const BetterPlayerBufferingConfiguration(),
    bool autoCreate = true,
  }) : super(VideoPlayerValue(duration: null)) {
    if (autoCreate) {
      _create();
    }
  }

  final StreamController<VideoEvent> videoEventStreamController =
      StreamController.broadcast();
  final Completer<void> _creatingCompleter = Completer<void>();
  int? _textureId;

  bool _isDisposed = false;
  late Completer<void> _initializingCompleter;
  StreamSubscription<dynamic>? _eventSubscription;

  bool get _created => _creatingCompleter.isCompleted;
  Duration? _seekPosition;

  /// This is just exposed for testing. It shouldn't be used by anyone depending
  /// on the plugin.
  @visibleForTesting
  int? get textureId => _textureId;

  /// Attempts to open the given [dataSource] and load metadata about the video.
  Future<void> _create() async {
    var configuration = BufferingConfiguration(
      bufferForPlaybackAfterRebufferMs:
          bufferingConfiguration.bufferForPlaybackAfterRebufferMs,
      bufferForPlaybackMs: bufferingConfiguration.bufferForPlaybackMs,
      maxBufferMs: bufferingConfiguration.maxBufferMs,
      minBufferMs: bufferingConfiguration.minBufferMs,
    );
    _textureId = await _videoPlayerPlatform.create(
        bufferingConfiguration: configuration);
    _creatingCompleter.complete(null);

    unawaited(_applyLooping());

    void eventListener(VideoEvent event) {
      if (_isDisposed) {
        return;
      }
      videoEventStreamController.add(event);
      switch (event.eventType) {
        case VideoEventType.initialized:
          value = value.copyWith(
            duration: event.duration,
            size: event.size,
          );
          _initializingCompleter.complete(null);
          break;
        case VideoEventType.completed:
          value = value.copyWith(isPlaying: false, position: value.duration);
          break;
        case VideoEventType.bufferingUpdate:
          value = value.copyWith(
              buffered: event.buffered, duration: event.duration);
          break;
        case VideoEventType.bufferingStart:
          value = value.copyWith(isBuffering: true);
          break;
        case VideoEventType.bufferingEnd:
          if (value.isBuffering) {
            value = value.copyWith(isBuffering: false);
          }
          break;

        case VideoEventType.play:
          value = value.copyWith(isPlaying: true);
          break;
        case VideoEventType.pause:
          value = value.copyWith(isPlaying: false);
          break;
        case VideoEventType.seek:
          value = value.copyWith(position: event.position);
          break;
        case VideoEventType.pipStart:
          value = value.copyWith(isPip: true);
          break;
        case VideoEventType.pipStop:
          value = value.copyWith(isPip: false);
          break;
        case VideoEventType.unknown:
          break;
      }
    }

    void errorListener(Object object) {
      if (object is PlatformException) {
        final PlatformException e = object;
        value = value.copyWith(errorDescription: e.message);
      } else {
        value.copyWith(errorDescription: object.toString());
      }
      if (!_initializingCompleter.isCompleted) {
        _initializingCompleter.completeError(object);
      }
    }

    _eventSubscription = _videoPlayerPlatform
        .videoEventsFor(_textureId)
        .listen(eventListener, onError: errorListener);

    value = VideoPlayerValue.uninitialized();
  }

  /// Set data source for playing a video from an asset.
  ///
  /// The name of the asset is given by the [dataSource] argument and must not be
  /// null. The [package] argument must be non-null when the asset comes from a
  /// package and null otherwise.
  Future<void> setAssetDataSource(
    String dataSource, {
    String? package,
    bool? showNotification,
    String? title,
    String? author,
    String? imageUrl,
    String? notificationChannelName,
    Duration? overriddenDuration,
    String? activityName,
  }) {
    return _setDataSource(
      DataSource(
        sourceType: DataSourceType.asset,
        asset: dataSource,
        package: package,
        showNotification: showNotification,
        title: title,
        author: author,
        imageUrl: imageUrl,
        notificationChannelName: notificationChannelName,
        overriddenDuration: overriddenDuration,
        activityName: activityName,
      ),
    );
  }

  /// Set data source for playing a video from obtained from
  /// the network.
  ///
  /// The URI for the video is given by the [dataSource] argument and must not be
  /// null.
  /// **Android only**: The [formatHint] option allows the caller to override
  /// the video format detection code.
  /// ClearKey DRM only supported on Android.
  Future<void> setNetworkDataSource(
    String dataSource, {
    VideoFormat? formatHint,
    Map<String, String?>? headers,
    bool useCache = false,
    int? maxCacheSize,
    int? maxCacheFileSize,
    String? cacheKey,
    bool? showNotification,
    String? title,
    String? author,
    String? imageUrl,
    String? notificationChannelName,
    Duration? overriddenDuration,
    String? licenseUrl,
    String? certificateUrl,
    DrmType? drmType,
    Map<String, String>? drmHeaders,
    String? activityName,
    String? clearKey,
    String? videoExtension,
  }) {
    return _setDataSource(
      DataSource(
        sourceType: DataSourceType.network,
        uri: dataSource,
        formatHint: formatHint,
        headers: headers,
        useCache: useCache,
        maxCacheSize: maxCacheSize,
        maxCacheFileSize: maxCacheFileSize,
        cacheKey: cacheKey,
        showNotification: showNotification,
        title: title,
        author: author,
        imageUrl: imageUrl,
        notificationChannelName: notificationChannelName,
        overriddenDuration: overriddenDuration,
        licenseUrl: licenseUrl,
        certificateUrl: certificateUrl,
        drmType: drmType,
        drmHeaders: drmHeaders,
        activityName: activityName,
        clearKey: clearKey,
        videoExtension: videoExtension,
      ),
    );
  }

  /// Set data source for playing a video from a file.
  ///
  /// This will load the file from the file-URI given by:
  /// `'file://${file.path}'`.
  Future<void> setFileDataSource(File file,
      {bool? showNotification,
      String? title,
      String? author,
      String? imageUrl,
      String? notificationChannelName,
      Duration? overriddenDuration,
      String? activityName,
      String? clearKey}) {
    return _setDataSource(
      DataSource(
          sourceType: DataSourceType.file,
          uri: 'file://${file.path}',
          showNotification: showNotification,
          title: title,
          author: author,
          imageUrl: imageUrl,
          notificationChannelName: notificationChannelName,
          overriddenDuration: overriddenDuration,
          activityName: activityName,
          clearKey: clearKey),
    );
  }

  Future<void> _setDataSource(DataSource dataSourceDescription) async {
    if (_isDisposed) {
      return;
    }

    value = VideoPlayerValue(
      duration: null,
      isLooping: value.isLooping,
      volume: value.volume,
    );

    if (!_creatingCompleter.isCompleted) await _creatingCompleter.future;

    _initializingCompleter = Completer<void>();

    await BetterPlayerPlatform.instance
        .setDataSource(_textureId, dataSourceDescription);
    return _initializingCompleter.future;
  }

  @override
  Future<void> dispose() async {
    await _creatingCompleter.future;
    if (!_isDisposed) {
      _isDisposed = true;
      value = VideoPlayerValue.uninitialized();
      await _eventSubscription?.cancel();
      await _videoPlayerPlatform.dispose(_textureId);
      videoEventStreamController.close();
    }
    _isDisposed = true;
    super.dispose();
  }

  /// Starts playing the video.
  ///
  /// This method returns a future that completes as soon as the "play" command
  /// has been sent to the platform, not when playback itself is totally
  /// finished.
  Future<void> play() async {
    value = value.copyWith(isPlaying: true);
    await _applyPlayPause();
  }

  /// Sets whether or not the video should loop after playing once. See also
  /// [VideoPlayerValue.isLooping].
  Future<void> setLooping(bool looping) async {
    value = value.copyWith(isLooping: looping);
    await _applyLooping();
  }

  /// Pauses the video.
  Future<void> pause() async {
    value = value.copyWith(isPlaying: false);
    await _applyPlayPause();
  }

  Future<void> _applyLooping() async {
    if (!_created || _isDisposed) {
      return;
    }
    await _videoPlayerPlatform.setLooping(_textureId, value.isLooping);
  }

  //update player position
  Future<void> updatePosition() async {
    final Duration? newPosition = await position;
    final DateTime? newAbsolutePosition = await absolutePosition;
    _updatePosition(newPosition, absolutePosition: newAbsolutePosition);
  }

  Future<void> _applyPlayPause() async {
    if (!_created || _isDisposed) {
      return;
    }
    if (value.isPlaying) {
      await _videoPlayerPlatform.play(_textureId);
    } else {
      await _videoPlayerPlatform.pause(_textureId);
    }
  }

  Future<void> _applyVolume() async {
    if (!_created || _isDisposed) {
      return;
    }
    await _videoPlayerPlatform.setVolume(_textureId, value.volume);
  }

  Future<void> _applySpeed() async {
    if (!_created || _isDisposed) {
      return;
    }
    await _videoPlayerPlatform.setSpeed(_textureId, value.speed);
  }

  /// The position in the current video.
  Future<Duration?> get position async {
    if (!value.initialized && _isDisposed) {
      return null;
    }
    return _videoPlayerPlatform.getPosition(_textureId);
  }

  /// The absolute position in the current video stream
  /// (i.e. EXT-X-PROGRAM-DATE-TIME in HLS).
  Future<DateTime?> get absolutePosition async {
    if (!value.initialized && _isDisposed) {
      return null;
    }
    return _videoPlayerPlatform.getAbsolutePosition(_textureId);
  }

  /// Sets the video's current timestamp to be at [moment]. The next
  /// time the video is played it will resume from the given [moment].
  ///
  /// If [moment] is outside of the video's full range it will be automatically
  /// and silently clamped.
  Future<void> seekTo(Duration? position) async {
    if (_isDisposed) {
      return;
    }

    Duration? positionToSeek = position;
    if (position! > value.duration!) {
      positionToSeek = value.duration;
    } else if (position < Duration.zero) {
      positionToSeek = Duration.zero;
    }
    _seekPosition = positionToSeek;

    await _videoPlayerPlatform.seekTo(_textureId, positionToSeek);
    _updatePosition(position);
  }

  /// Sets the audio volume of [this].
  ///
  /// [volume] indicates a value between 0.0 (silent) and 1.0 (full volume) on a
  /// linear scale.
  Future<void> setVolume(double volume) async {
    value = value.copyWith(volume: volume.clamp(0.0, 1.0));
    await _applyVolume();
  }

  /// Sets the speed of [this].
  ///
  /// [speed] indicates a value between 0.0 and 2.0 on a linear scale.
  Future<void> setSpeed(double speed) async {
    final double previousSpeed = value.speed;
    try {
      value = value.copyWith(speed: speed);
      await _applySpeed();
    } catch (exception) {
      value = value.copyWith(speed: previousSpeed);
      rethrow;
    }
  }

  /// Sets the video track parameters of [this]
  ///
  /// [width] specifies width of the selected track
  /// [height] specifies height of the selected track
  /// [bitrate] specifies bitrate of the selected track
  Future<void> setTrackParameters(int? width, int? height, int? bitrate) async {
    await _videoPlayerPlatform.setTrackParameters(
        _textureId, width, height, bitrate);
  }

  Future<void> enablePictureInPicture(
      {double? top, double? left, double? width, double? height}) async {
    await _videoPlayerPlatform.enablePictureInPicture(
        textureId, top, left, width, height);
  }

  Future<void> disablePictureInPicture() async {
    await _videoPlayerPlatform.disablePictureInPicture(textureId);
  }

  void _updatePosition(Duration? position, {DateTime? absolutePosition}) {
    value = value.copyWith(position: position);
    if (_seekPosition == null) {
      value = value.copyWith(absolutePosition: absolutePosition);
    }
  }

  Future<bool?> isPictureInPictureSupported() async {
    if (_textureId == null) {
      return false;
    }
    return _videoPlayerPlatform.isPictureInPictureEnabled(_textureId);
  }

  void refresh() {
    value = value.copyWith();
  }

  void setAudioTrack(String? name, int? index) {
    _videoPlayerPlatform.setAudioTrack(_textureId, name, index);
  }

  void setMixWithOthers(bool mixWithOthers) {
    _videoPlayerPlatform.setMixWithOthers(_textureId, mixWithOthers);
  }

  static Future clearCache() async {
    return _videoPlayerPlatform.clearCache();
  }

  static Future preCache(DataSource dataSource, int preCacheSize) async {
    return _videoPlayerPlatform.preCache(dataSource, preCacheSize);
  }

  static Future stopPreCache(String url, String? cacheKey) async {
    return _videoPlayerPlatform.stopPreCache(url, cacheKey);
  }
}

/// Widget that displays the video controlled by [controller].
class VideoPlayer extends StatefulWidget {
  /// Uses the given [controller] for all video rendered in this widget.
  const VideoPlayer(this.controller, {Key? key}) : super(key: key);

  /// The [VideoPlayerController] responsible for the video being rendered in
  /// this widget.
  final VideoPlayerController controller;

  @override
  VideoPlayerState createState() => VideoPlayerState();
}

class VideoPlayerState extends State<VideoPlayer> {
  VideoPlayerState() {
    _listener = () {
      final newTextureId = widget.controller.textureId;
      if (newTextureId != _textureId) {
        setState(() {
          _textureId = newTextureId;
        });
      }
    };
  }

  late VoidCallback _listener;
  int? _textureId;

  @override
  void initState() {
    super.initState();
    _textureId = widget.controller.textureId;
    // Need to listen for initialization events since the actual texture ID
    // becomes available after asynchronous initialization finishes.
    widget.controller.addListener(_listener);
  }

  @override
  void didUpdateWidget(VideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.controller.removeListener(_listener);
    _textureId = widget.controller.textureId;
    widget.controller.addListener(_listener);
  }

  @override
  void deactivate() {
    super.deactivate();
    widget.controller.removeListener(_listener);
  }

  @override
  Widget build(BuildContext context) {
    return _textureId == null
        ? Container()
        : _videoPlayerPlatform.buildView(_textureId);
  }
}
