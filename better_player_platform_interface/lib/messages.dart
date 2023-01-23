// Autogenerated from Pigeon (v3.2.0), do not edit directly.
// See also: https://pub.dev/packages/pigeon
// ignore_for_file: public_member_api_docs, non_constant_identifier_names, avoid_as, unused_import, unnecessary_parenthesis, prefer_null_aware_operators, omit_local_variable_types, unused_shown_name
// @dart = 2.12
import 'dart:async';
import 'dart:typed_data' show Uint8List, Int32List, Int64List, Float64List;

import 'package:flutter/foundation.dart' show WriteBuffer, ReadBuffer;
import 'package:flutter/services.dart';

class TextureMessage {
  TextureMessage({
    this.textureId,
  });

  int? textureId;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    return pigeonMap;
  }

  static TextureMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return TextureMessage(
      textureId: pigeonMap['textureId'] as int?,
    );
  }
}

class VolumeMessage {
  VolumeMessage({
    this.textureId,
    this.volume,
  });

  int? textureId;
  double? volume;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['volume'] = volume;
    return pigeonMap;
  }

  static VolumeMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return VolumeMessage(
      textureId: pigeonMap['textureId'] as int?,
      volume: pigeonMap['volume'] as double?,
    );
  }
}

class SetSpeedMessage {
  SetSpeedMessage({
    this.textureId,
    this.speed,
  });

  int? textureId;
  double? speed;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['speed'] = speed;
    return pigeonMap;
  }

  static SetSpeedMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return SetSpeedMessage(
      textureId: pigeonMap['textureId'] as int?,
      speed: pigeonMap['speed'] as double?,
    );
  }
}

class CreateMessage {
  CreateMessage({
    this.minBufferMs,
    this.maxBufferMs,
    this.bufferForPlaybackMs,
    this.bufferForPlaybackAfterRebufferMs,
  });

  int? minBufferMs;
  int? maxBufferMs;
  int? bufferForPlaybackMs;
  int? bufferForPlaybackAfterRebufferMs;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['minBufferMs'] = minBufferMs;
    pigeonMap['maxBufferMs'] = maxBufferMs;
    pigeonMap['bufferForPlaybackMs'] = bufferForPlaybackMs;
    pigeonMap['bufferForPlaybackAfterRebufferMs'] =
        bufferForPlaybackAfterRebufferMs;
    return pigeonMap;
  }

  static CreateMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return CreateMessage(
      minBufferMs: pigeonMap['minBufferMs'] as int?,
      maxBufferMs: pigeonMap['maxBufferMs'] as int?,
      bufferForPlaybackMs: pigeonMap['bufferForPlaybackMs'] as int?,
      bufferForPlaybackAfterRebufferMs:
          pigeonMap['bufferForPlaybackAfterRebufferMs'] as int?,
    );
  }
}

class DataSourceMessage {
  DataSourceMessage({
    this.textureId,
    this.key,
    this.asset,
    this.package,
    this.uri,
    this.formatHint,
    this.headers,
    this.useCache,
    this.maxCacheSize,
    this.maxCacheFileSize,
    this.cacheKey,
    this.showNotification,
    this.title,
    this.author,
    this.imageUrl,
    this.notificationChannelName,
    this.overriddenDuration,
    this.licenseUrl,
    this.certificateUrl,
    this.drmHeaders,
    this.activityName,
    this.clearKey,
    this.videoExtension,
  });

  int? textureId;
  String? key;
  String? asset;
  String? package;
  String? uri;
  String? formatHint;
  Map<Object?, Object?>? headers;
  bool? useCache;
  int? maxCacheSize;
  int? maxCacheFileSize;
  String? cacheKey;
  bool? showNotification;
  String? title;
  String? author;
  String? imageUrl;
  String? notificationChannelName;
  int? overriddenDuration;
  String? licenseUrl;
  String? certificateUrl;
  Map<String?, String?>? drmHeaders;
  String? activityName;
  String? clearKey;
  String? videoExtension;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['key'] = key;
    pigeonMap['asset'] = asset;
    pigeonMap['package'] = package;
    pigeonMap['uri'] = uri;
    pigeonMap['formatHint'] = formatHint;
    pigeonMap['headers'] = headers;
    pigeonMap['useCache'] = useCache;
    pigeonMap['maxCacheSize'] = maxCacheSize;
    pigeonMap['maxCacheFileSize'] = maxCacheFileSize;
    pigeonMap['cacheKey'] = cacheKey;
    pigeonMap['showNotification'] = showNotification;
    pigeonMap['title'] = title;
    pigeonMap['author'] = author;
    pigeonMap['imageUrl'] = imageUrl;
    pigeonMap['notificationChannelName'] = notificationChannelName;
    pigeonMap['overriddenDuration'] = overriddenDuration;
    pigeonMap['licenseUrl'] = licenseUrl;
    pigeonMap['certificateUrl'] = certificateUrl;
    pigeonMap['drmHeaders'] = drmHeaders;
    pigeonMap['activityName'] = activityName;
    pigeonMap['clearKey'] = clearKey;
    pigeonMap['videoExtension'] = videoExtension;
    return pigeonMap;
  }

  static DataSourceMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return DataSourceMessage(
      textureId: pigeonMap['textureId'] as int?,
      key: pigeonMap['key'] as String?,
      asset: pigeonMap['asset'] as String?,
      package: pigeonMap['package'] as String?,
      uri: pigeonMap['uri'] as String?,
      formatHint: pigeonMap['formatHint'] as String?,
      headers: pigeonMap['headers'] as Map<Object?, Object?>?,
      useCache: pigeonMap['useCache'] as bool?,
      maxCacheSize: pigeonMap['maxCacheSize'] as int?,
      maxCacheFileSize: pigeonMap['maxCacheFileSize'] as int?,
      cacheKey: pigeonMap['cacheKey'] as String?,
      showNotification: pigeonMap['showNotification'] as bool?,
      title: pigeonMap['title'] as String?,
      author: pigeonMap['author'] as String?,
      imageUrl: pigeonMap['imageUrl'] as String?,
      notificationChannelName: pigeonMap['notificationChannelName'] as String?,
      overriddenDuration: pigeonMap['overriddenDuration'] as int?,
      licenseUrl: pigeonMap['licenseUrl'] as String?,
      certificateUrl: pigeonMap['certificateUrl'] as String?,
      drmHeaders: (pigeonMap['drmHeaders'] as Map<Object?, Object?>?)
          ?.cast<String?, String?>(),
      activityName: pigeonMap['activityName'] as String?,
      clearKey: pigeonMap['clearKey'] as String?,
      videoExtension: pigeonMap['videoExtension'] as String?,
    );
  }
}

class SetLoopingMessage {
  SetLoopingMessage({
    this.textureId,
    this.looping,
  });

  int? textureId;
  bool? looping;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['looping'] = looping;
    return pigeonMap;
  }

  static SetLoopingMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return SetLoopingMessage(
      textureId: pigeonMap['textureId'] as int?,
      looping: pigeonMap['looping'] as bool?,
    );
  }
}

class SetTrackParametersMessage {
  SetTrackParametersMessage({
    this.textureId,
    this.width,
    this.height,
    this.bitrate,
  });

  int? textureId;
  int? width;
  int? height;
  int? bitrate;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['width'] = width;
    pigeonMap['height'] = height;
    pigeonMap['bitrate'] = bitrate;
    return pigeonMap;
  }

  static SetTrackParametersMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return SetTrackParametersMessage(
      textureId: pigeonMap['textureId'] as int?,
      width: pigeonMap['width'] as int?,
      height: pigeonMap['height'] as int?,
      bitrate: pigeonMap['bitrate'] as int?,
    );
  }
}

class SeekToMessage {
  SeekToMessage({
    this.textureId,
    this.position,
  });

  int? textureId;
  int? position;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['position'] = position;
    return pigeonMap;
  }

  static SeekToMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return SeekToMessage(
      textureId: pigeonMap['textureId'] as int?,
      position: pigeonMap['position'] as int?,
    );
  }
}

class PositionMessage {
  PositionMessage({
    this.textureId,
    this.position,
  });

  int? textureId;
  int? position;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['position'] = position;
    return pigeonMap;
  }

  static PositionMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PositionMessage(
      textureId: pigeonMap['textureId'] as int?,
      position: pigeonMap['position'] as int?,
    );
  }
}

class EnablePictureInPictureMessage {
  EnablePictureInPictureMessage({
    this.textureId,
    this.top,
    this.left,
    this.width,
    this.height,
  });

  int? textureId;
  double? top;
  double? left;
  double? width;
  double? height;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['top'] = top;
    pigeonMap['left'] = left;
    pigeonMap['width'] = width;
    pigeonMap['height'] = height;
    return pigeonMap;
  }

  static EnablePictureInPictureMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return EnablePictureInPictureMessage(
      textureId: pigeonMap['textureId'] as int?,
      top: pigeonMap['top'] as double?,
      left: pigeonMap['left'] as double?,
      width: pigeonMap['width'] as double?,
      height: pigeonMap['height'] as double?,
    );
  }
}

class SetAudioTrack {
  SetAudioTrack({
    this.textureId,
    this.name,
    this.index,
  });

  int? textureId;
  String? name;
  int? index;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['name'] = name;
    pigeonMap['index'] = index;
    return pigeonMap;
  }

  static SetAudioTrack decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return SetAudioTrack(
      textureId: pigeonMap['textureId'] as int?,
      name: pigeonMap['name'] as String?,
      index: pigeonMap['index'] as int?,
    );
  }
}

class SetMixWithOthersMessage {
  SetMixWithOthersMessage({
    this.textureId,
    this.mixWithOthers,
  });

  int? textureId;
  bool? mixWithOthers;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['textureId'] = textureId;
    pigeonMap['mixWithOthers'] = mixWithOthers;
    return pigeonMap;
  }

  static SetMixWithOthersMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return SetMixWithOthersMessage(
      textureId: pigeonMap['textureId'] as int?,
      mixWithOthers: pigeonMap['mixWithOthers'] as bool?,
    );
  }
}

class InnerPreCacheMessage {
  InnerPreCacheMessage({
    this.key,
    this.uri,
    this.certificateUrl,
    this.headers,
    this.maxCacheSize,
    this.maxCacheFileSize,
    this.preCacheSize,
    this.cacheKey,
    this.videoExtension,
  });

  String? key;
  String? uri;
  String? certificateUrl;
  Map<Object?, Object?>? headers;
  int? maxCacheSize;
  int? maxCacheFileSize;
  int? preCacheSize;
  String? cacheKey;
  String? videoExtension;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['key'] = key;
    pigeonMap['uri'] = uri;
    pigeonMap['certificateUrl'] = certificateUrl;
    pigeonMap['headers'] = headers;
    pigeonMap['maxCacheSize'] = maxCacheSize;
    pigeonMap['maxCacheFileSize'] = maxCacheFileSize;
    pigeonMap['preCacheSize'] = preCacheSize;
    pigeonMap['cacheKey'] = cacheKey;
    pigeonMap['videoExtension'] = videoExtension;
    return pigeonMap;
  }

  static InnerPreCacheMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return InnerPreCacheMessage(
      key: pigeonMap['key'] as String?,
      uri: pigeonMap['uri'] as String?,
      certificateUrl: pigeonMap['certificateUrl'] as String?,
      headers: pigeonMap['headers'] as Map<Object?, Object?>?,
      maxCacheSize: pigeonMap['maxCacheSize'] as int?,
      maxCacheFileSize: pigeonMap['maxCacheFileSize'] as int?,
      preCacheSize: pigeonMap['preCacheSize'] as int?,
      cacheKey: pigeonMap['cacheKey'] as String?,
      videoExtension: pigeonMap['videoExtension'] as String?,
    );
  }
}

class PreCacheMessage {
  PreCacheMessage({
    this.dataSource,
  });

  InnerPreCacheMessage? dataSource;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['dataSource'] = dataSource?.encode();
    return pigeonMap;
  }

  static PreCacheMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return PreCacheMessage(
      dataSource: pigeonMap['dataSource'] != null
          ? InnerPreCacheMessage.decode(pigeonMap['dataSource']!)
          : null,
    );
  }
}

class StopPreCacheMessage {
  StopPreCacheMessage({
    this.url,
    this.cacheKey,
  });

  String? url;
  String? cacheKey;

  Object encode() {
    final Map<Object?, Object?> pigeonMap = <Object?, Object?>{};
    pigeonMap['url'] = url;
    pigeonMap['cacheKey'] = cacheKey;
    return pigeonMap;
  }

  static StopPreCacheMessage decode(Object message) {
    final Map<Object?, Object?> pigeonMap = message as Map<Object?, Object?>;
    return StopPreCacheMessage(
      url: pigeonMap['url'] as String?,
      cacheKey: pigeonMap['cacheKey'] as String?,
    );
  }
}

class _BetterPlayerApiCodec extends StandardMessageCodec {
  const _BetterPlayerApiCodec();
  @override
  void writeValue(WriteBuffer buffer, Object? value) {
    if (value is CreateMessage) {
      buffer.putUint8(128);
      writeValue(buffer, value.encode());
    } else if (value is DataSourceMessage) {
      buffer.putUint8(129);
      writeValue(buffer, value.encode());
    } else if (value is EnablePictureInPictureMessage) {
      buffer.putUint8(130);
      writeValue(buffer, value.encode());
    } else if (value is InnerPreCacheMessage) {
      buffer.putUint8(131);
      writeValue(buffer, value.encode());
    } else if (value is PositionMessage) {
      buffer.putUint8(132);
      writeValue(buffer, value.encode());
    } else if (value is PreCacheMessage) {
      buffer.putUint8(133);
      writeValue(buffer, value.encode());
    } else if (value is SeekToMessage) {
      buffer.putUint8(134);
      writeValue(buffer, value.encode());
    } else if (value is SetAudioTrack) {
      buffer.putUint8(135);
      writeValue(buffer, value.encode());
    } else if (value is SetLoopingMessage) {
      buffer.putUint8(136);
      writeValue(buffer, value.encode());
    } else if (value is SetMixWithOthersMessage) {
      buffer.putUint8(137);
      writeValue(buffer, value.encode());
    } else if (value is SetSpeedMessage) {
      buffer.putUint8(138);
      writeValue(buffer, value.encode());
    } else if (value is SetTrackParametersMessage) {
      buffer.putUint8(139);
      writeValue(buffer, value.encode());
    } else if (value is StopPreCacheMessage) {
      buffer.putUint8(140);
      writeValue(buffer, value.encode());
    } else if (value is TextureMessage) {
      buffer.putUint8(141);
      writeValue(buffer, value.encode());
    } else if (value is VolumeMessage) {
      buffer.putUint8(142);
      writeValue(buffer, value.encode());
    } else {
      super.writeValue(buffer, value);
    }
  }

  @override
  Object? readValueOfType(int type, ReadBuffer buffer) {
    switch (type) {
      case 128:
        return CreateMessage.decode(readValue(buffer)!);

      case 129:
        return DataSourceMessage.decode(readValue(buffer)!);

      case 130:
        return EnablePictureInPictureMessage.decode(readValue(buffer)!);

      case 131:
        return InnerPreCacheMessage.decode(readValue(buffer)!);

      case 132:
        return PositionMessage.decode(readValue(buffer)!);

      case 133:
        return PreCacheMessage.decode(readValue(buffer)!);

      case 134:
        return SeekToMessage.decode(readValue(buffer)!);

      case 135:
        return SetAudioTrack.decode(readValue(buffer)!);

      case 136:
        return SetLoopingMessage.decode(readValue(buffer)!);

      case 137:
        return SetMixWithOthersMessage.decode(readValue(buffer)!);

      case 138:
        return SetSpeedMessage.decode(readValue(buffer)!);

      case 139:
        return SetTrackParametersMessage.decode(readValue(buffer)!);

      case 140:
        return StopPreCacheMessage.decode(readValue(buffer)!);

      case 141:
        return TextureMessage.decode(readValue(buffer)!);

      case 142:
        return VolumeMessage.decode(readValue(buffer)!);

      default:
        return super.readValueOfType(type, buffer);
    }
  }
}

class BetterPlayerApi {
  /// Constructor for [BetterPlayerApi].  The [binaryMessenger] named argument is
  /// available for dependency injection.  If it is left null, the default
  /// BinaryMessenger will be used which routes to the host platform.
  BetterPlayerApi({BinaryMessenger? binaryMessenger})
      : _binaryMessenger = binaryMessenger;

  final BinaryMessenger? _binaryMessenger;

  static const MessageCodec<Object?> codec = _BetterPlayerApiCodec();

  Future<void> initialize() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.initialize', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<TextureMessage> create(CreateMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.create', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as TextureMessage?)!;
    }
  }

  Future<void> dispose(TextureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.dispose', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setDataSource(DataSourceMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.setDataSource', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setLooping(SetLoopingMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.setLooping', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setVolume(VolumeMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.setVolume', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setSpeed(SetSpeedMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.setSpeed', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> play(TextureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.play', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> pause(TextureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.pause', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> stop(TextureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.stop', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setTrackParameters(SetTrackParametersMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.setTrackParameters', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> seekTo(SeekToMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.seekTo', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<PositionMessage> position(TextureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.position', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as PositionMessage?)!;
    }
  }

  Future<PositionMessage> absolutePosition(TextureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.absolutePosition', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as PositionMessage?)!;
    }
  }

  Future<void> enablePictureInPicture(
      EnablePictureInPictureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.enablePictureInPicture', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<bool> isPictureInPictureEnabled(TextureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.isPictureInPictureEnabled', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else if (replyMap['result'] == null) {
      throw PlatformException(
        code: 'null-error',
        message: 'Host platform returned null value for non-null return value.',
      );
    } else {
      return (replyMap['result'] as bool?)!;
    }
  }

  Future<void> disablePictureInPicture(TextureMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.disablePictureInPicture', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setAudioTrack(SetAudioTrack arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.setAudioTrack', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> setMixWithOthers(SetMixWithOthersMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.setMixWithOthers', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> clearCache() async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.clearCache', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(null) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> preCache(PreCacheMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.preCache', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }

  Future<void> stopPreCache(StopPreCacheMessage arg_msg) async {
    final BasicMessageChannel<Object?> channel = BasicMessageChannel<Object?>(
        'dev.flutter.pigeon.BetterPlayerApi.stopPreCache', codec,
        binaryMessenger: _binaryMessenger);
    final Map<Object?, Object?>? replyMap =
        await channel.send(<Object?>[arg_msg]) as Map<Object?, Object?>?;
    if (replyMap == null) {
      throw PlatformException(
        code: 'channel-error',
        message: 'Unable to establish connection on channel.',
      );
    } else if (replyMap['error'] != null) {
      final Map<Object?, Object?> error =
          (replyMap['error'] as Map<Object?, Object?>?)!;
      throw PlatformException(
        code: (error['code'] as String?)!,
        message: error['message'] as String?,
        details: error['details'],
      );
    } else {
      return;
    }
  }
}
