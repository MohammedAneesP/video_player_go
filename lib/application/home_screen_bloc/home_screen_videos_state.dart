part of 'home_screen_videos_bloc.dart';

@immutable
sealed class HomeScreenVideosState {}

class HomeScreenVideosInitial extends HomeScreenVideosState {}

class FetchedVideos extends HomeScreenVideosState {
  final List<dynamic> videos;
  FetchedVideos({required this.videos});
}

class LoadingState extends HomeScreenVideosState {}
