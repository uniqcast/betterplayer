import 'dart:async';
import 'dart:html' as html;

import 'package:better_player_platform_interface/better_player_platform_interface.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:video_js/video_js.dart';

const playerId = 'uniqtv_player';

/// This is an implementation of the `import_js_library` plugin that is used
/// until that plugin is migrated to null safety.
/// See https://github.com/florent37/flutter_web_import_js_library/pull/6#issuecomment-735349208.

/// Imports a JS script file from the given [url] given the relative
/// [flutterPluginName].
void importJsLibrary({required String url, String? flutterPluginName}) {
  if (flutterPluginName == null) {
    _importJSLibraries([url]);
  } else {
    _importJSLibraries([_libraryUrl(url, flutterPluginName)]);
  }
}

String _libraryUrl(String url, String pluginName) {
  if (url.startsWith('./')) {
    url = url.replaceFirst('./', '');
    return './assets/packages/$pluginName/$url';
  }
  if (url.startsWith('assets/')) {
    return './assets/packages/$pluginName/$url';
  } else {
    return url;
  }
}

html.ScriptElement _createScriptTag(String library) {
  final script = html.ScriptElement()
    ..type = 'text/javascript'
    ..charset = 'utf-8'
    ..async = true
    ..src = library;
  return script;
}

/// Injects a bunch of libraries in the <head> and returns a
/// Future that resolves when all load.
Future<void> _importJSLibraries(List<String> libraries) {
  final loading = <Future<void>>[];
  final head = html.querySelector('head');

  for (final library in libraries) {
    if (!_isImported(library)) {
      final scriptTag = _createScriptTag(library);
      head!.children.add(scriptTag);
      loading.add(scriptTag.onLoad.first);
    }
  }

  return Future.wait(loading);
}

bool _isImported(String url) {
  final head = html.querySelector('head')!;
  return _isLoaded(head, url);
}

bool _isLoaded(html.Element head, String url) {
  if (url.startsWith('./')) {
    url = url.replaceFirst('./', '');
  }
  for (var element in head.children) {
    if (element is html.ScriptElement) {
      if (element.src.endsWith(url)) {
        return true;
      }
    }
  }
  return false;
}

/// An implementation of [BetterPlayerPlatform] that uses method channels.
class BetterPlayerWeb extends BetterPlayerPlatform {
  /// Registers this class as the default instance of [BetterPlayerPlatform].
  static void registerWith(Registrar registrar) {
    VideoJsResults().init();
    _importJSLibraries([
      'https://unpkg.com/video.js/dist/video.js',
      'https://unpkg.com/videojs-contrib-hls/dist/videojs-contrib-hls.js'
    ]);

    BetterPlayerPlatform.instance = BetterPlayerWeb();
  }

  late VideoJsController controller;
  late VideoJsWidget videoJsWidget;

  @override
  Future<void> init() async {
    controller = VideoJsController(
      playerId,
      videoJsOptions: VideoJsOptions(
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
    videoJsWidget = VideoJsWidget(videoJsController: controller);
  }

  @override
  Future<void> dispose(int? textureId) async {
    controller.dispose();
  }

  @override
  Future<int?> create({
    BufferingConfiguration? bufferingConfiguration,
  }) async {
    return 123;
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
    controller.setSRC(
      dataSource.uri ?? '',
      type: dataSource.videoExtension ?? 'application/x-mpegURL',
      keySystems: keySystems,
      emeHeaders: dataSource.drmHeaders,
    );
    VideoJsResults()
        .onVolumeFromJsStream
        .add(ResultFromVideoJs(playerId, 'onReady', 'true'));
    return;
  }

  @override
  Future<void> setLooping(int? textureId, bool looping) async {
    //TODO:
  }

  @override
  Future<void> play(int? textureId) async {
    controller.play();
    controller.onEnd((p0) => null);
  }

  @override
  Future<void> pause(int? textureId) async {
    controller.pause();
  }

  @override
  Future<void> setVolume(int? textureId, double volume) async {
    controller.setVolume(volume.toString());
  }

  @override
  Future<void> setSpeed(int? textureId, double speed) async {}

  @override
  Future<void> setTrackParameters(
      int? textureId, int? width, int? height, int? bitrate) async {}

  @override
  Future<void> seekTo(int? textureId, Duration? position) async {
    controller.setCurrentTime(position?.inSeconds.toString() ?? '');
  }

  @override
  Future<Duration> getPosition(int? textureId) async {
    final completer = Completer<Duration>();
    controller.currentTime((timeValue) {
      final time = double.tryParse(timeValue) ?? 0;
      final seconds = time.truncate();
      final miliseconds = ((time - seconds) * 1000).truncate();
      return completer
          .complete(Duration(seconds: seconds, milliseconds: miliseconds));
    });

    return completer.future;
  }

  @override
  Future<DateTime?> getAbsolutePosition(int? textureId) async {
    return DateTime.now();
  }

  @override
  Future<void> enablePictureInPicture(int? textureId, double? top, double? left,
      double? width, double? height) async {}

  @override
  Future<bool?> isPictureInPictureEnabled(int? textureId) async {
    return false;
  }

  @override
  Future<void> disablePictureInPicture(int? textureId) async {}

  @override
  Future<void> setAudioTrack(int? textureId, String? name, int? index) async {}

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
    return VideoJsResults()
        .onVolumeFromJsStream
        .stream
        .map((ResultFromVideoJs event) {
      if (playerId != event.videoId) {
        return VideoEvent(eventType: VideoEventType.unknown, key: null);
      }
      final key = event.videoId;
      switch (event.type) {
        case 'onReady':
          final Size size = Size(800, 600);
          return VideoEvent(
            eventType: VideoEventType.initialized,
            key: key,
            duration: Duration(milliseconds: 1000),
            size: size,
          );
        // TODO:
        case 'onEnd':
          return VideoEvent(
            eventType: VideoEventType.completed,
            key: key,
          );
        // case 'bufferingUpdate':
        //   final List<dynamic> values = map['values'] as List;
        //
        //   return VideoEvent(
        //     eventType: VideoEventType.bufferingUpdate,
        //     key: key,
        //     buffered: values.map<DurationRange>(_toDurationRange).toList(),
        //   );
        // case 'bufferingStart':
        //   return VideoEvent(
        //     eventType: VideoEventType.bufferingStart,
        //     key: key,
        //   );
        // case 'bufferingEnd':
        //   return VideoEvent(
        //     eventType: VideoEventType.bufferingEnd,
        //     key: key,
        //   );
        //
        case 'isPaused':
          final playing = !(event.result as bool);
          return VideoEvent(
            eventType: playing ? VideoEventType.play : VideoEventType.pause,
            key: key,
          );
        //
        // case 'pause':
        //   return VideoEvent(
        //     eventType: VideoEventType.pause,
        //     key: key,
        //   );
        //
        // case 'seek':
        //   return VideoEvent(
        //     eventType: VideoEventType.seek,
        //     key: key,
        //     position: Duration(milliseconds: map['position'] as int),
        //   );
        //
        // case 'pipStart':
        //   return VideoEvent(
        //     eventType: VideoEventType.pipStart,
        //     key: key,
        //   );
        //
        // case 'pipStop':
        //   return VideoEvent(
        //     eventType: VideoEventType.pipStop,
        //     key: key,
        //   );

        default:
          return VideoEvent(
            eventType: VideoEventType.unknown,
            key: key,
          );
      }
    });
  }

  @override
  Widget buildView(int? textureId) {
    return videoJsWidget;
  }
}
