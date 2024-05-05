import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayingScreen extends StatefulWidget {
  final String anVideoId;
  const VideoPlayingScreen({super.key, required this.anVideoId});

  @override
  State<VideoPlayingScreen> createState() => _VideoPlayingScreenState();
}

class _VideoPlayingScreenState extends State<VideoPlayingScreen> {
  bool isLoading = true;
  late YoutubePlayerController anController;
  String youtubeLink = "https://www.youtube.com/watch?v=";
  @override
  void initState() {
    isLoading = true;
    anController = YoutubePlayerController(
      initialVideoId: widget.anVideoId,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            YoutubePlayer(
              controller: anController,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    anController.dispose();
    super.dispose();
  }
}
