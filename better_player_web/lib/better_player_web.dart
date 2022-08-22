import 'dart:async';

import 'package:better_player_platform_interface/better_player_platform_interface.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:video_js/video_js.dart' as vjs;

const playerId = 'uniqtv_player';

/// An implementation of [BetterPlayerPlatform] that uses method channels.
class BetterPlayerWeb extends BetterPlayerPlatform {
  /// Registers this class as the default instance of [BetterPlayerPlatform].
  static void registerWith(Registrar registrar) {
    BetterPlayerPlatform.instance = BetterPlayerWeb();
  }

  late vjs.VideoJsController controller;

  @override
  Future<void> init() async {
    //TODO: resolve after refactoring player functions
    // try {
    //   await importJSLibraries([
    //     './assets/video.min.js',
    //     './assets/videojs-contrib-eme.min.js',
    //   ]).then((value) => print('loaded JS'));
    //
    //   await importCSSLibraries(['./assets/video-js.css'])
    //       .then((value) => print('loaded CSS'));
    //
    //   print('loaded js');
    // } catch (e) {
    //   print('------e $e');
    // }
    controller = vjs.VideoJsController(
      playerId,
      videoJsOptions: vjs.VideoJsOptions(
        controls: false,
        loop: false,
        muted: false,
        aspectRatio: '16:9',
        fluid: false,
        language: 'en',
        liveui: false,
        preferFullWindow: false,
        suppressNotSupportedError: false,
      ),
    );
  }

  @override
  Future<void> dispose(int? textureId) async {
    controller.dispose();
  }

  @override
  Future<int?> create({
    BufferingConfiguration? bufferingConfiguration,
  }) async {
    return 1;
  }

  @override
  Future<void> setDataSource(int? textureId, DataSource dataSource) async {
    Map<String, dynamic>? keySystems;
    switch (dataSource.drmType) {
      case DrmType.widevine:
        keySystems = {'com.widevine.alpha': dataSource.licenseUrl};
        break;
      case DrmType.fairplay:
        keySystems = {
          'com.apple.fps.1_0': {
            'certificateUri': dataSource.certificateUrl,
            'licenseUri': dataSource.licenseUrl
          }
        };
        break;
      case DrmType.clearKey:
        keySystems = {'org.w3.clearkey': dataSource.licenseUrl};
        break;
      case DrmType.token:
      case null:
        // don't need to do anything
        break;
    }
    await controller.setSRC(
      dataSource.uri ?? '',
      type: dataSource.videoExtension ?? 'application/x-mpegURL',
      keySystems: keySystems,
      emeHeaders: dataSource.drmHeaders,
    );
    return;
  }

  @override
  Future<void> setLooping(int? textureId, bool looping) async {
    //TODO:
  }

  @override
  Future<void> play(int? textureId) async {
    return controller.play();
  }

  @override
  Future<void> pause(int? textureId) async {
    return controller.pause();
  }

  @override
  Future<void> setVolume(int? textureId, double volume) async {
    return controller.setVolume(volume);
  }

  @override
  Future<void> setSpeed(int? textureId, double speed) async {}

  @override
  Future<void> setTrackParameters(
    int? textureId,
    int? width,
    int? height,
    int? bitrate,
  ) async {}

  @override
  Future<void> seekTo(int? textureId, Duration? position) async {
    return controller.setCurrentTime(position ?? Duration.zero);
  }

  @override
  Future<Duration> getPosition(int? textureId) {
    return controller.currentTime();
  }

  @override
  Future<DateTime?> getAbsolutePosition(int? textureId) async {
    return DateTime.now();
  }

  @override
  Future<void> enablePictureInPicture(
    int? textureId,
    double? top,
    double? left,
    double? width,
    double? height,
  ) async {}

  @override
  Future<bool?> isPictureInPictureEnabled(int? textureId) async {
    return false;
  }

  @override
  Future<void> disablePictureInPicture(int? textureId) async {}

  @override
  Future<void> setAudioTrack(int? textureId, String? name, int? index) async {
    if (index != null && name != null) {
      return controller.setAudioTrack(index, name);
    }
  }

  @override
  Future<void> setMixWithOthers(int? textureId, bool mixWithOthers) async {}

  @override
  Future<void> clearCache() async {}

  @override
  Future<void> preCache(DataSource dataSource, int preCacheSize) async {}

  @override
  Future<void> stopPreCache(String url, String? cacheKey) async {}

  @override
  Stream<VideoEvent> videoEventsFor(int? textureId) {
    return vjs.VideoJsResults()
        .onVolumeFromJsStream
        .stream
        .map((vjs.VideoEvent event) {
      if (playerId != event.key) {
        return VideoEvent(eventType: VideoEventType.unknown, key: null);
      }
      return VideoEvent(
        eventType: VideoEventType.values[event.eventType.index],
        key: event.key,
        duration: event.duration,
        size: event.size,
        position: event.position,
        buffered:
            event.buffered?.map((e) => DurationRange(e.start, e.end)).toList(),
      );
    });
  }

  @override
  Widget buildView(int? textureId) {
    return vjs.VideoJsWidget(videoJsController: controller);
  }
}
