import 'package:better_player/better_player.dart'
    show BetterPlayerSubtitleTypesEnum;

class BetterPlayerPlatformSubtitleModel {
  final int index;
  final String language;
  final BetterPlayerSubtitleTypesEnum type;

  BetterPlayerPlatformSubtitleModel({
    required this.index,
    required this.language,
    required this.type,
  });
}
