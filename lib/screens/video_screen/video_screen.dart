import 'package:flutter/material.dart';
import 'package:non_linear/provider/video_provider.dart';
import 'package:non_linear/screens/video_screen/options_button_builder.dart';
import 'package:non_linear/screens/video_screen/video_playback_widget.dart';
import 'package:provider/provider.dart';

class VideoPlaybackScreen extends StatefulWidget {
  static const id = "VideoPlaybackScreen";

  const VideoPlaybackScreen({Key? key}) : super(key: key);

  @override
  VideoPlaybackScreenState createState() => VideoPlaybackScreenState();
}

class VideoPlaybackScreenState extends State<VideoPlaybackScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    VideoProvider videoProvider =
        Provider.of<VideoProvider>(context, listen: true);
    return Builder(
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 10),
            height: screenSize.height,
            width: screenSize.width,
            child: Stack(
              children: [
                VideoPlayerWidget(
                  videoUrl: videoProvider.videoUrl,
                  chewieController: videoProvider.chewieController,
                  videoPlayerController: videoProvider.videoPlayerController,
                ),
                if (videoProvider.showOptions == ButtonDisplayOptions.show)
                  Center(
                    child: SizedBox(
                        height: screenSize.height * 0.2,
                        width: screenSize.width,
                        child: buildOptionsCollumn(
                            context, videoProvider.root.children)),
                  ),
                if (videoProvider.showOptions == ButtonDisplayOptions.end)
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      constraints:
                          const BoxConstraints(minWidth: 100, minHeight: 40),
                      color: Colors.white,
                      margin: const EdgeInsets.all(2.0),
                      padding: const EdgeInsets.all(2.0),
                      child: const Center(
                        child: Text(
                          "END",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
