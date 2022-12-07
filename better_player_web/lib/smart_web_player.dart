@JS('SmartWebPlayer')
library smart_web_player;

import 'dart:html' as html;

import 'package:js/js.dart';

@JS()
@anonymous
class DrmData {
  external factory DrmData({
    String? certificateUrl,
    String licenseUrl,
  });
}

@JS()
@anonymous
class Drm {
  external factory Drm({
    String type,
    DrmData data,
    Object? headers,
  });
}

@JS()
@anonymous
class Quality {
  external factory Quality({
    String id,
    num? width,
    num? height,
    num? bitrate,
  });
}

@JS()
@anonymous
class BufferedRange {
  external num get start;

  external num get end;

  external factory BufferedRange({
    num? start,
    num? end,
  });
}

@JS()
@anonymous
class Size {
  external num get width;

  external num get height;

  external factory Size({
    num? width,
    num? height,
  });
}

@JS()
@anonymous
class PlayerEvent {
  external String get key;

  external String get type;

  external List<BufferedRange>? get buffered;

  external num? get duration;

  external Size? get size;

  external factory PlayerEvent({
    String key,
    String type,
    List<BufferedRange>? buffered,
    num? duration,
    Size? size,
  });
}

typedef PlayerEventCallback = void Function(PlayerEvent event);
@JS()
class Promise<T>{
 external factory Promise(dynamic Function(dynamic Function(dynamic value) resolve, dynamic Function(dynamic error) reject) executor);
}
@JS()
class BasePlayer {
  external factory BasePlayer();

  external bool isInitialized();

  external html.Element viewElement();

  external Promise<void> init();

  external Promise<void> destroy();

  external Promise<void> setSrc(String url, Drm? drm);

  external Promise<void> play();

  external Promise<void> pause();

  external Promise<void> seekTo(num position);

  external Promise<num> position();

  external Promise<void> setVolume(num volume);

  external Promise<void> setAudioTrack(
    num index,
    String id,
  );

  external Promise<List<Quality>> getQualities();

  external Promise<void> setQuality(num? bitrate, num? width, num? height);

  external void onEvent(PlayerEventCallback listener);
}

external BasePlayer getSmartPlayer();
