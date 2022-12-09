import 'package:flutter/material.dart';

import 'package:twin_apps/models/constants.dart';
import 'package:appinio_video_player/appinio_video_player.dart';

class VideoWidget extends StatefulWidget {
  const VideoWidget({super.key});

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 20, bottom: 20, right: 20, left: 20),
      child: CustomVideoPlayerWeb(
        customVideoPlayerWebController: Constants.customVideoPlayerController,
      ),
    );
  }
}
