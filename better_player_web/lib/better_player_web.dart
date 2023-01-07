import 'dart:async';
import 'dart:js_util';
import 'dart:ui' as ui;

import 'package:better_player_platform_interface/better_player_platform_interface.dart';
import 'package:better_player_web/smart_web_player.dart';
import 'package:better_player_web/util.dart';
import 'package:better_player_web/video_js_widget.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';
import 'package:js/js.dart';

const playerId = 'uniqtv_player';

/// An implementation of [BetterPlayerPlatform] that uses method channels.
class BetterPlayerWeb extends BetterPlayerPlatform {
  /// Registers this class as the default instance of [BetterPlayerPlatform].
  static void registerWith(Registrar registrar) {
    BetterPlayerPlatform.instance = BetterPlayerWeb();
  }

  final BasePlayer player = getSmartPlayer();
  final String textureUid = 'better_player_web_view';
  final StreamController<VideoEvent> eventStream =
      StreamController<VideoEvent>.broadcast();

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
    final view = player.viewElement();
    // ignore: undefined_prefixed_name
    ui.platformViewRegistry.registerViewFactory(textureUid, (int id) => view);
  }

  @override
  Future<void> dispose(int? textureId) async {
    return promiseToFuture(player.destroy());
  }

  @override
  Future<int?> create({
    BufferingConfiguration? bufferingConfiguration,
  }) async {
    return 1;
  }

  @override
  Future<void> setDataSource(int? textureId, DataSource dataSource) async {
    await promiseToFuture(
      player.setSrc(
        dataSource.uri ?? '',
        dataSource.drmType != null
            ? Drm(
                type: dataSource.drmType!.name,
                data: DrmData(
                  licenseUrl: dataSource.licenseUrl!,
                  certificateUrl: dataSource.certificateUrl,
                ),
                headers: dataSource.drmHeaders != null
                    ? mapToJsObject(dataSource.drmHeaders!)
                    : null,
              )
            : null,
      ),
    );
    return;
  }

  @override
  Future<void> setLooping(int? textureId, bool looping) async {
    //TODO:
  }

  @override
  Future<void> play(int? textureId) async {
    return promiseToFuture(player.play());
  }

  @override
  Future<void> pause(int? textureId) async {
    return promiseToFuture(player.pause());
  }

  @override
  Future<void> setVolume(int? textureId, double volume) async {
    return promiseToFuture(player.setVolume(volume));
  }

  @override
  Future<void> setSpeed(int? textureId, double speed) async {}

  @override
  Future<void> setTrackParameters(
    int? textureId,
    int? width,
    int? height,
    int? bitrate,
  ) async {
    return promiseToFuture(player.setQuality(bitrate, width, height));
  }

  @override
  Future<void> seekTo(int? textureId, Duration? position) async {
    return promiseToFuture(player.seekTo(position?.inMilliseconds ?? 0));
  }

  @override
  Future<Duration> getPosition(int? textureId) async {
    final position = await promiseToFuture(player.position());
    return parseDuration(position);
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
      return promiseToFuture(player.setAudioTrack(index, name));
    }
  }

  @override
  Future<Map?> getSubtitleTracks(int? textureId) async {
    final subtitleObjects = await promiseToFuture(player.getSubtitleTracks());
    final Map subtitlesMap = {};
    if (subtitleObjects is List<dynamic> && subtitleObjects.isNotEmpty) {
      try {
        final subtitles =
            subtitleObjects.map((e) => e as SubtitleTrack).toList();
        subtitlesMap
            .addEntries(subtitles.map((e) => MapEntry(e.index, e.language)));
      } catch (e) {
        print('Can not parse subtitles $e');
      }
    }
    return subtitlesMap;
  }

  @override
  Future<void> setSubtitleTrack(int? textureId, String? name, int? index) {
    return promiseToFuture(player.setSubtitleTrack(index, name));
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
    return eventStream.stream;
  }

  @override
  Widget buildView(int? textureId) {
    return VideoWidget(
      onShow: () async {
        print("ON SHOW");
        if (player.isInitialized()) {
          print("already initialized");
          return;
        }
        await player.init();
        print("initialize events");
        player.onEvent(
          allowInterop((event) {
            eventStream.add(
              VideoEvent(
                key: event.key,
                eventType: VideoEventType.values.byName(event.type),
                duration: event.duration != null
                    ? parseDuration(event.duration)
                    : null,
                size: event.size != null
                    ? ui.Size(
                        event.size!.width.toDouble(),
                        event.size!.height.toDouble(),
                      )
                    : null,
                buffered: event.buffered != null
                    ? event.buffered!
                        .map(
                          (e) => DurationRange(
                            parseDuration(e.start),
                            parseDuration(e.end),
                          ),
                        )
                        .toList()
                    : null,
              ),
            );
          }),
        );
      },
      textureId: textureUid,
    );
  }
}
