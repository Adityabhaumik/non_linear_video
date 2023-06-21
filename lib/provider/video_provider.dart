import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:non_linear/constants.dart';
import 'package:video_player/video_player.dart';

enum ButtonDisplayOptions { show, dontShow, end }

class VideoProvider extends ChangeNotifier {
  late int root;
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  late ButtonDisplayOptions showOptions;
  late Map<int, String> vidId;
  late Map<int, String> options;
  late String videoUrl;
  late List<List<int>> graph;
  late List<int> path;

  void _checkVideoStatus(ButtonDisplayOptions last) {
    if (videoPlayerController.value.position ==
        videoPlayerController.value.duration) {
      if (last == ButtonDisplayOptions.end) {
        showOptions = ButtonDisplayOptions.end;
      } else {
        showOptions = ButtonDisplayOptions.show;
      }
      notifyListeners();
    }
  }

  void initialize() {
    showOptions = ButtonDisplayOptions.dontShow;
    vidId = videosLinks;
    options = optionsLabels;
    videoUrl = baseUrl;
    graph = decisionTree;
    root = 0;
    path = [root];
    videoPlayerController = VideoPlayerController.network(videoUrl);
    chewieController = ChewieController(
      aspectRatio: 0.5,
      videoPlayerController: videoPlayerController,
      autoPlay: true,
      looping: false,
      allowFullScreen: false,
      showControls: true,
      draggableProgressBar: true,
      showControlsOnInitialize: false,
      materialProgressColors: ChewieProgressColors(
        playedColor: Colors.redAccent,
        backgroundColor: Colors.white60,
        bufferedColor: Colors.grey,
      ),
      placeholder: const Center(
        child: CircularProgressIndicator(),
      ),
    );
    videoPlayerController.addListener(() {
      if (graph[root].isNotEmpty) {
        _checkVideoStatus(ButtonDisplayOptions.show);
      } else {
        _checkVideoStatus(ButtonDisplayOptions.end);
      }
    });
  }

  void changeRootToSelectedOption(int selected) {
    videoPlayerController.dispose();
    chewieController.dispose();
    root = selected;
    path.add(root);
    videoUrl = vidId[root]!;
    videoPlayerController = VideoPlayerController.network(videoUrl);
    chewieController = ChewieController(
        aspectRatio: 0.5,
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        allowFullScreen: false,
        showControls: true,
        draggableProgressBar: true,
        showControlsOnInitialize: false,
        materialProgressColors: ChewieProgressColors(
          playedColor: Colors.redAccent,
          backgroundColor: Colors.white60,
          bufferedColor: Colors.grey,
        ),
        placeholder: const Center(
          child: CircularProgressIndicator(),
        ));
    videoPlayerController.addListener(() {
      if (graph[root].isNotEmpty) {
        _checkVideoStatus(ButtonDisplayOptions.show);
      } else {
        _checkVideoStatus(ButtonDisplayOptions.end);
      }
    });
    showOptions = ButtonDisplayOptions.dontShow;

    notifyListeners();
  }
}
