import 'dart:collection';

import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:non_linear/constants.dart';
import 'package:non_linear/models/graph_model.dart';
import 'package:video_player/video_player.dart';

enum ButtonDisplayOptions { show, dontShow, end }

class VideoProvider extends ChangeNotifier {
  late GraphNode<int> root;
  late ChewieController chewieController;
  late VideoPlayerController videoPlayerController;
  ButtonDisplayOptions showOptions = ButtonDisplayOptions.dontShow;
  Map<int, String> vidId = videosLinks;
  Map<int, String> options = optionsLabels;
  String videoUrl = baseUrl;

  void checkVideo(ButtonDisplayOptions last) {
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
    List<List<int>> graph = decisionTree;
    root = GraphNode<int>(0);
    createGraph(root, graph);
    videoPlayerController = VideoPlayerController.network(videoUrl);
    chewieController = ChewieController(
        aspectRatio: 0.5,
        videoPlayerController: videoPlayerController,
        autoPlay: true,
        looping: false,
        showControls: false,
        showOptions: false);
    videoPlayerController.addListener(() {
      if (root.children.isNotEmpty) {
        checkVideo(ButtonDisplayOptions.show);
      } else {
        checkVideo(ButtonDisplayOptions.end);
      }
    });
  }

  void createGraph(GraphNode<int> root, List<List<int>> adjList) {
    Queue<GraphNode<int>> queue = Queue();
    queue.add(root);
    while (queue.isNotEmpty) {
      GraphNode front = queue.first;
      queue.removeFirst();
      int node = front.value;
      for (int childNode in adjList[node]) {
        GraphNode<int> child = GraphNode(childNode);
        front.children.add(child);
        queue.add(child);
      }
    }
  }

  void changeRootToSelectedOption(GraphNode<int> selected) {
    root = selected;
    videoUrl = vidId[root.value]!;
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
      if (root.children.isNotEmpty) {
        checkVideo(ButtonDisplayOptions.show);
      } else {
        checkVideo(ButtonDisplayOptions.end);
      }
    });
    if (root.children.isNotEmpty) {
      showOptions = ButtonDisplayOptions.dontShow;
    }
    notifyListeners();
  }

  // void visitAllNodes(GraphNode<int> node) {
  //   //print(node.value);
  //   for (var child in node.children) {
  //     visitAllNodes(child);
  //   }
  // }
}
