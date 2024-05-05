import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_video_player/application/home_screen_bloc/home_screen_videos_bloc.dart';
import 'package:go_video_player/presentation/screens/home_screen.dart';



class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // BlocProvider.of<HomeScreenVideosBloc>(context).add(GetVideos());
    goto(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const CupertinoPageScaffold(
        child: Center(
      child: CircleAvatar(
        radius: 60,
        child: Icon(
          Icons.play_arrow_rounded,
          size: 50,
        ),
      ),
    ));
  }
}

List<FileSystemEntity> theFiles = [];

Future<void> goto(BuildContext context) async {
  await Future.delayed(const Duration(seconds: 5));
  if (context.mounted) {
    Navigator.pushReplacement(
        context,
        CupertinoPageRoute(
          builder: (context) => const HomeScreen(),
        ));
  }
}