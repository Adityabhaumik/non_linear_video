import 'package:flutter/material.dart';
import 'package:non_linear/provider/video_provider.dart';
import 'package:non_linear/screens/video_screen/video_screen.dart';
import 'package:non_linear/screens/home_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<VideoProvider>(
          create: (BuildContext context) => VideoProvider(),
        ),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Non - Linear',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
          routes: {
            HomeScreen.id: (context) => const HomeScreen(),
            VideoPlaybackScreen.id: (context) => const VideoPlaybackScreen(),
          }),
    );
  }
}
