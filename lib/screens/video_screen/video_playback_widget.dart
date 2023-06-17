import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final String videoUrl;
  final VideoPlayerController videoPlayerController;
  final ChewieController chewieController;

  const VideoPlayerWidget(
      {Key? key,
      required this.videoUrl,
      required this.chewieController,
      required this.videoPlayerController})
      : super(key: key);

  @override
  VideoPlayerWidgetState createState() => VideoPlayerWidgetState();
}

class VideoPlayerWidgetState extends State<VideoPlayerWidget> {

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return SizedBox(
      height: screenSize.height,
      child: Chewie(
        controller: widget.chewieController,
      ),
    );
  }
}
