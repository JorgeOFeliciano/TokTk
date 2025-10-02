import 'package:flutter_e103_toktik/domain/datasource/video_post_datasource.dart';
import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';
import 'package:flutter_e103_toktik/domain/repositories/videopost_repository_impl.dart';

class VideopostRepositoryImpl implements VideoPostsRepository {
  final VideoPostsDataSource videoPostsDataSource;

  VideopostRepositoryImpl({required this.videoPostsDataSource});

  @override
  Future<List<VideosPost>> getFavoriteVideosByUser(String userID) {
    throw UnimplementedError();
  }

  @override
  Future<List<VideosPost>> getTrendingVideoByPage(int page) {
    return videoPostsDataSource.getTrendingVideoByPage(page);
  }
}