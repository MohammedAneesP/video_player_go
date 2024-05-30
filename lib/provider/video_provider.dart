import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_video_player/services/api/home_video.dart';
import 'package:http/http.dart' as http;

class VideoProvider extends ChangeNotifier {
  List<dynamic> videosToPaginate = [];
  List<dynamic> forEveryHomeVids = [];
  Set<String> uniqueVideoIds = {};
  Future<void> toFetch() async {
    try {
      forEveryHomeVids = await fetchSomeVideos();
      log(forEveryHomeVids.length.toString());
      if (forEveryHomeVids.isEmpty) {
        return;
      } else {
        log("Provider function is calling");
        int count = 0;
        final toEmitVideos = [];
        for (var element in forEveryHomeVids) {
          final thumbnailUrl = element["thumbnails"][1]["url"];
          if (thumbnailUrl != null) {
            Uri? url = Uri.tryParse(thumbnailUrl);
            if (url != null && url.isAbsolute) {
              try {
                var response = await http.head(Uri.parse(thumbnailUrl));
                if (response.statusCode == 200) {
                  if (count >= 5) {
                    break;
                  } else {
                    uniqueVideoIds.add(element["videoId"].toString());

                    toEmitVideos.add(element);
                    count++;
                  }
                }
              } catch (e) {
                log(e.toString());
              }
            }
          }
        }

        videosToPaginate.addAll(toEmitVideos);
        notifyListeners();
        log(uniqueVideoIds.toString());
      }
    } catch (e) {
      log("error in provider  $e");
    }
  }

  Future<void> toPaginate() async {
    log("calling paginating Provider");
    List<dynamic> anlist = [];
    int count = 0;

    for (var i = 0; i < forEveryHomeVids.length; i++) {
      final thumbnailUrl = forEveryHomeVids[i]["thumbnails"][1]["url"];
      if (count < 5) {
        if (thumbnailUrl != null) {
          Uri? url = Uri.tryParse(thumbnailUrl);
          if (url != null && url.isAbsolute) {
            try {
              var response = await http.head(Uri.parse(thumbnailUrl));
              if (response.statusCode == 200) {
                // Check if the video is not already in videosToPaginate
                if (!uniqueVideoIds
                    .contains(forEveryHomeVids[i]["videoId"].toString())) {
                  log(forEveryHomeVids[i]["videoId"]);

                  anlist.add(forEveryHomeVids[i]);
                  uniqueVideoIds.add(forEveryHomeVids[i]["videoId"].toString());
                  log(count.toString());
                  count++;
                }
              }
            } catch (e) {
              log(e.toString());
            }
          }
        }
      } else {
        break;
      }
    }

    videosToPaginate.addAll(anlist);
    notifyListeners();
    log("from Paginate provider - ${videosToPaginate.length.toString()}");
  }
}
