// To parse this JSON data, do
//
//     final videos = videosFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Videos videosFromJson(String str) => Videos.fromJson(json.decode(str));

String videosToJson(Videos data) => json.encode(data.toJson());

class Videos {
    final Video video;

    Videos({
        required this.video,
    });

    factory Videos.fromJson(Map<String, dynamic> json) => Videos(
        video: Video.fromJson(json["video"]),
    );

    Map<String, dynamic> toJson() => {
        "video": video.toJson(),
    };
}

class Video {
    final Author author;
    final List<String> badges;
    final String descriptionSnippet;
    final bool isLiveNow;
    final int lengthSeconds;
    final List<MovingThumbnail> movingThumbnails;
    final String publishedTimeText;
    final Stats stats;
    final List<MovingThumbnail> thumbnails;
    final String title;
    final String videoId;

    Video({
        required this.author,
        required this.badges,
        required this.descriptionSnippet,
        required this.isLiveNow,
        required this.lengthSeconds,
        required this.movingThumbnails,
        required this.publishedTimeText,
        required this.stats,
        required this.thumbnails,
        required this.title,
        required this.videoId,
    });

    factory Video.fromJson(Map<String, dynamic> json) => Video(
        author: Author.fromJson(json["author"]),
        badges: List<String>.from(json["badges"].map((x) => x)),
        descriptionSnippet: json["descriptionSnippet"],
        isLiveNow: json["isLiveNow"],
        lengthSeconds: json["lengthSeconds"],
        movingThumbnails: List<MovingThumbnail>.from(json["movingThumbnails"].map((x) => MovingThumbnail.fromJson(x))),
        publishedTimeText: json["publishedTimeText"],
        stats: Stats.fromJson(json["stats"]),
        thumbnails: List<MovingThumbnail>.from(json["thumbnails"].map((x) => MovingThumbnail.fromJson(x))),
        title: json["title"],
        videoId: json["videoId"],
    );

    Map<String, dynamic> toJson() => {
        "author": author.toJson(),
        "badges": List<dynamic>.from(badges.map((x) => x)),
        "descriptionSnippet": descriptionSnippet,
        "isLiveNow": isLiveNow,
        "lengthSeconds": lengthSeconds,
        "movingThumbnails": List<dynamic>.from(movingThumbnails.map((x) => x.toJson())),
        "publishedTimeText": publishedTimeText,
        "stats": stats.toJson(),
        "thumbnails": List<dynamic>.from(thumbnails.map((x) => x.toJson())),
        "title": title,
        "videoId": videoId,
    };
}

class Author {
    final List<MovingThumbnail> avatar;
    final List<Badge> badges;
    final String canonicalBaseUrl;
    final String channelId;
    final String title;

    Author({
        required this.avatar,
        required this.badges,
        required this.canonicalBaseUrl,
        required this.channelId,
        required this.title,
    });

    factory Author.fromJson(Map<String, dynamic> json) => Author(
        avatar: List<MovingThumbnail>.from(json["avatar"].map((x) => MovingThumbnail.fromJson(x))),
        badges: List<Badge>.from(json["badges"].map((x) => Badge.fromJson(x))),
        canonicalBaseUrl: json["canonicalBaseUrl"],
        channelId: json["channelId"],
        title: json["title"],
    );

    Map<String, dynamic> toJson() => {
        "avatar": List<dynamic>.from(avatar.map((x) => x.toJson())),
        "badges": List<dynamic>.from(badges.map((x) => x.toJson())),
        "canonicalBaseUrl": canonicalBaseUrl,
        "channelId": channelId,
        "title": title,
    };
}

class MovingThumbnail {
    final int height;
    final String url;
    final int width;

    MovingThumbnail({
        required this.height,
        required this.url,
        required this.width,
    });

    factory MovingThumbnail.fromJson(Map<String, dynamic> json) => MovingThumbnail(
        height: json["height"],
        url: json["url"],
        width: json["width"],
    );

    Map<String, dynamic> toJson() => {
        "height": height,
        "url": url,
        "width": width,
    };
}

class Badge {
    final String text;
    final String type;

    Badge({
        required this.text,
        required this.type,
    });

    factory Badge.fromJson(Map<String, dynamic> json) => Badge(
        text: json["text"],
        type: json["type"],
    );

    Map<String, dynamic> toJson() => {
        "text": text,
        "type": type,
    };
}

class Stats {
    final int views;

    Stats({
        required this.views,
    });

    factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        views: json["views"],
    );

    Map<String, dynamic> toJson() => {
        "views": views,
    };
}
