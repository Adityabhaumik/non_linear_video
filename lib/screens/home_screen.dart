import 'package:flutter/material.dart';
import 'package:non_linear/provider/video_provider.dart';
import 'package:non_linear/screens/video_screen/video_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const id = "HomeScreen";

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    VideoProvider videoProvider =
        Provider.of<VideoProvider>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Adya.Care"),
      ),
      body: Center(
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 10),
          child: Text(
            'Non - Linear Video Playback',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          videoProvider.initialize();
          Navigator.pushNamed(context, VideoPlaybackScreen.id);
        },
        tooltip: 'Increment',
        label: Text(
          'Start',
          style: Theme.of(context).textTheme.headlineMedium!.copyWith(fontSize: 20),
        ),
      ),
    );
  }
}
