import 'package:flutter/material.dart';
import 'package:non_linear/models/graph_model.dart';
import 'package:non_linear/provider/video_provider.dart';
import 'package:provider/provider.dart';

Widget buildOptionsCollumn(BuildContext context, List<GraphNode<int>> options) {
  VideoProvider appBaseProvider =
      Provider.of<VideoProvider>(context, listen: true);
  final screenSize = MediaQuery.of(context).size;
  List<Widget> buttonWidgets = [];
  for (GraphNode<int> node in options) {
    buttonWidgets.add(
      GestureDetector(
        onTap: () {
          appBaseProvider.changeRootToSelectedOption(node);
        },
        child: Container(
          constraints: const BoxConstraints(minWidth: 100, minHeight: 40),
          color: Colors.white.withOpacity(0.8),
          margin: const EdgeInsets.all(2.0),
          padding: const EdgeInsets.all(2.0),
          child: Center(
            child: Text(
              "${appBaseProvider.options[node.value]}",
              style: const TextStyle(color: Colors.black),
            ),
          ),
        ),
      ),
    );
  }
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 15),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttonWidgets,
    ),
  );
}
