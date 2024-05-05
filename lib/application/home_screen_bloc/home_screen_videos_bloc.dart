import 'dart:developer';

import 'package:go_video_player/services/api/home_video.dart';
import 'package:meta/meta.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_screen_videos_event.dart';
part 'home_screen_videos_state.dart';

List<dynamic> videosToPaginate = [];

class HomeScreenVideosBloc
    extends Bloc<HomeScreenVideosEvent, HomeScreenVideosState> {
  HomeScreenVideosBloc() : super(HomeScreenVideosInitial()) {
    on<HomeScreenVideosEvent>((event, emit) async {
      emit(LoadingState());
      try {
        final theValues = await fetchSomeVideos();
        if (theValues.isEmpty) {
          return emit(FetchedVideos(videos: const []));
        } else {
          final toEmitVideos = List.generate(10, (index) {
            if (theValues[index]["videoId"] != null) {
              videosToPaginate.add(theValues[index]);
              return theValues[index];
            }
          });
          return emit(FetchedVideos(videos: toEmitVideos));
        }
      } catch (e) {
        log("error in bloc emitting $e");
      }
    });
  }
}
