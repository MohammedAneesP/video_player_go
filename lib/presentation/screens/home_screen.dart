import 'dart:developer';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_video_player/application/home_screen_bloc/home_screen_videos_bloc.dart';
import 'package:go_video_player/presentation/screens/video_playing_screen/playing_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<HomeScreenVideosBloc>(context).add(GetVideos());
    return Scaffold(
      body: BlocBuilder<HomeScreenVideosBloc, HomeScreenVideosState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case const (LoadingState):
              return const Center(child: CircularProgressIndicator());
            case const (FetchedVideos):
              final videos = state as FetchedVideos;
              return ListView.separated(
                itemBuilder: (context, index) {
                  List<dynamic> imageUrlList =
                      videos.videos[index]["author"]["avatar"];

                  String imageUrl = imageUrlList[0]["url"].toString();
                  return ListTile(
                    onTap: () {
                      
                      Navigator.push(
                          context,
                          CupertinoPageRoute(
                            builder: (context) => VideoPlayingScreen(
                              anVideoId: videos.videos[index]["videoId"],
                            ),
                          ));
                    },
                    leading: CachedNetworkImage(
                      imageUrl: imageUrl,
                      imageBuilder: (context, imageProvider) => CircleAvatar(
                        backgroundImage: imageProvider,
                      ),
                      placeholder: (context, url) =>
                          const CircularProgressIndicator(),
                      errorWidget: (context, url, error) =>
                          const Icon(Icons.error),
                    ),
                    title: Text(videos.videos[index]["title"]),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: videos.videos.length,
              );

            default:
              return const Center(
                  child: Text(
                "Something went wrong",
                style: TextStyle(fontSize: 25),
              ));
          }
        },
      ),
    );
  }
}
