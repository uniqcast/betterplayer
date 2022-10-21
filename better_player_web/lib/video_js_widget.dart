import 'package:flutter/cupertino.dart';

class VideoWidget extends StatefulWidget {
  final VoidCallback onShow;
  final String textureId;

  const VideoWidget({Key? key, required this.onShow, required this.textureId})
      : super(key: key);

  @override
  VideoWidgetState createState() => VideoWidgetState();
}

class VideoWidgetState extends State<VideoWidget> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      widget.onShow();
    });
  }

  @override
  Widget build(BuildContext context) {
    return HtmlElementView(viewType: widget.textureId);
  }
}
