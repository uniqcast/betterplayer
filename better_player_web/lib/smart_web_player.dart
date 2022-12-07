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
class BasePlayer {
  external factory BasePlayer();

  external bool isInitialized();

  external html.Element viewElement();

  external dynamic init();

  external dynamic destroy();

  external dynamic setSrc(String url, Drm? drm);

  external dynamic play();

  external dynamic pause();

  external dynamic seekTo(num position);

  external dynamic position();

  external dynamic setVolume(num volume);

  external dynamic setAudioTrack(
    num index,
    String id,
  );

  external dynamic getQualities();

  external dynamic setQuality(num? bitrate, num? width, num? height);

  external void onEvent(PlayerEventCallback listener);
}

external BasePlayer getSmartPlayer();
