import 'package:flutter_e103_toktik/domain/datasource/video_post_datasource.dart';
import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';
import 'package:flutter_e103_toktik/infrastrcture/models/local_video_model.dart';
import 'package:flutter_e103_toktik/shared/data/local_video_post.dart';

class LocalvideoDatasourceImpl implements VideoPostsDataSource {
  @override
  Future<List<VideosPost>> getFavoriteVideosByUser(String userID) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideosPost>> getTrendingVideoByPage(int page) async{
    await Future.delayed(const Duration(seconds: 2));

    final List<VideosPost> newVideos = videoPosts
        .map((video)=> LocalVideoModel.fromJson(video).toVideoPostEntity())
        .toList();

    return newVideos;
  }
}