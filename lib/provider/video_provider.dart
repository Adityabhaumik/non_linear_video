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

  void checkVideoStatus(ButtonDisplayOptions last) {
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
    videoPlayerController = VideoPlayerController.network(videoUrl);
    chewieController = ChewieController(
        aspectRatio: 0.5,
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        showControls: false,
        showOptions: false);
    videoPlayerController.addListener(() {
      if (graph[root].isNotEmpty) {
        checkVideoStatus(ButtonDisplayOptions.show);
      } else {
        checkVideoStatus(ButtonDisplayOptions.end);
      }
    });
  }

  void changeRootToSelectedOption(int selected) {
    root = selected;
    videoUrl = vidId[root]!;
    videoPlayerController.dispose();
    chewieController.dispose();
    videoPlayerController = VideoPlayerController.network(videoUrl);
    chewieController = ChewieController(
        aspectRatio: 0.5,
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        showControls: false,
        showOptions: false);
    videoPlayerController.addListener(() {
      if (graph[root].isNotEmpty) {
        checkVideoStatus(ButtonDisplayOptions.show);
      } else {
        checkVideoStatus(ButtonDisplayOptions.end);
      }
    });
    if (graph[root].isNotEmpty) {
      showOptions = ButtonDisplayOptions.dontShow;
    }
    notifyListeners();
  }
}
