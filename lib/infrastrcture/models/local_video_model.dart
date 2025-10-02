import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';

class LocalVideoModel {
  final String name;
  final String videoUrl;
  final int likes;
  final int views;

LocalVideoModel({
  required this.name,
  required this.videoUrl, 
  this.likes = 0, 
  this.views = 0,
});

factory LocalVideoModel.fromJson(Map<String,dynamic> json) => 
  LocalVideoModel(
    name: json['name'] ?? 'No name', 
    videoUrl: json['videoURL'],
    likes: json['likes'] ?? 0,
    views: json['views'] ?? 0,
    );

    VideosPost toVideoPostEntity() => VideosPost(
      caption: name,
      videoUrl: videoUrl,
      likes: likes,
      views: views,
      isFavorite: false,
    );
}