import 'dart:developer';

import 'package:go_video_player/provider/video_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_video_player/presentation/screens/video_playing_screen/playing_screen.dart';
import 'package:provider/provider.dart';

class NewhomeScreen extends StatefulWidget {
  const NewhomeScreen({super.key});

  @override
  State<NewhomeScreen> createState() => _NewhomeScreenState();
}

class _NewhomeScreenState extends State<NewhomeScreen> {
  ValueNotifier<bool> anBool = ValueNotifier(false);

  late ScrollController anScrollController;
  anScrollListener() {
    if (anScrollController.position.pixels >=
        anScrollController.position.maxScrollExtent) {
      if (anBool.value == false) {
        Provider.of<VideoProvider>(context, listen: false).toPaginate();
        anBool.value = true;
      }
    }
  }

  @override
  void initState() {
    Provider.of<VideoProvider>(context, listen: false).toFetch();
    anScrollController = ScrollController();
    anScrollController.addListener(anScrollListener);
    super.initState();
  }

  @override
  void dispose() {
    anScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log("rebuilding all over");
    final height = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Consumer<VideoProvider>(
        builder: (context, value, child) {
          return value.videosToPaginate.isEmpty
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : ListView.separated(
                  controller: anScrollController,
                  itemBuilder: (context, index) {
                    List<dynamic> imageUrlList =
                        value.videosToPaginate[index]["thumbnails"];
                    String imageUrl = imageUrlList[1]["url"].toString();
                    String channelName =
                        value.videosToPaginate[index]["channelName"];
                    String subStringedd = "";

                    String videoTitle = value.videosToPaginate[index]["title"];
                    String videoTitleSubString = "";
                    if (channelName.length <= 13) {
                      videoTitleSubString = videoTitle;
                    } else {
                      videoTitleSubString = videoTitle.substring(0, 13);
                    }

                    if (channelName.length <= 7) {
                      subStringedd = channelName;
                    } else {
                      subStringedd = channelName.substring(0, 8);
                    }

                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            CupertinoPageRoute(
                              builder: (context) => VideoPlayingScreen(
                                  anVideoId: value.videosToPaginate[index]
                                      ["videoId"]),
                            ));
                      },
                      child: SizedBox(
                        height: height.height * 0.36,
                        child: Column(
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageUrl,
                              imageBuilder: (context, imageProvider) => Stack(
                                children: [
                                  Container(
                                    height: height.height * .25,
                                    decoration: BoxDecoration(
                                      image: DecorationImage(
                                          image: imageProvider,
                                          fit: BoxFit.cover),
                                    ),
                                  ),
                                  Positioned(
                                    top: 220,
                                    left: 410,
                                    child: Container(
                                      width: height.width * 0.08,
                                      decoration: const BoxDecoration(
                                          color: Colors.black54,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(5))),
                                      child: Center(
                                        child: Text(
                                          value.videosToPaginate[index]
                                              ["lengthText"],
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              placeholder: (context, url) =>
                                  const CircularProgressIndicator(),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.error),
                            ),
                            ListTile(
                              leading: CachedNetworkImage(
                                imageUrl: imageUrl,
                                imageBuilder: (context, imageProvider) =>
                                    CircleAvatar(
                                  backgroundImage: imageProvider,
                                ),
                                placeholder: (context, url) =>
                                    const CircularProgressIndicator(),
                                errorWidget: (context, url, error) =>
                                    const Icon(Icons.error),
                              ),
                              title: Text(
                                videoTitleSubString,
                                overflow: TextOverflow.ellipsis,
                              ),
                              subtitle: Row(
                                children: [
                                  Text("$subStringedd - "),
                                  Text(
                                    maxLines: 2,
                                    "${value.videosToPaginate[index]["viewCountText"]} - ",
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Text(
                                    value.videosToPaginate[index]
                                        ["publishedTimeText"],
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(
                    color: Colors.transparent,
                  ),
                  itemCount: value.videosToPaginate.length,
                );
        },
      ),
    );
  }
}
