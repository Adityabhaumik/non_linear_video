import 'package:flutter/material.dart';
import 'package:non_linear/provider/video_provider.dart';
import 'package:provider/provider.dart';

Widget buildOptionsCollumn(BuildContext context, List<int> options) {
  VideoProvider videoProvider =
      Provider.of<VideoProvider>(context, listen: true);
  final screenSize = MediaQuery.of(context).size;
  List<Widget> buttonWidgets = [];
  for (int node in options) {
    buttonWidgets.add(
      GestureDetector(
        onTap: () {
          videoProvider.changeRootToSelectedOption(node);
        },
        child: Container(
          constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
          color: Colors.white.withOpacity(0.8),
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              "${videoProvider.options[node]}",
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
  buttonWidgets.add(
    GestureDetector(
      onTap: () {
        if (videoProvider.root == 0) {
          videoProvider.videoPlayerController.dispose();
          videoProvider.chewieController.dispose();
          Navigator.pop(context);
        } else {
          ///TODO:
          videoProvider.path.removeLast();
          int parent = videoProvider.path.last;
          videoProvider.path.removeLast();
          videoProvider.changeRootToSelectedOption(parent);
        }
      },
      child: Container(
        constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
        color: Colors.white.withOpacity(0.8),
        margin: const EdgeInsets.all(2.0),
        padding: const EdgeInsets.all(2.0),
        child: const Center(
          child: Text(
            "Go back",
            style: const TextStyle(color: Colors.black),
          ),
        ),
      ),
    ),
  );
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttonWidgets,
    ),
  );
}
