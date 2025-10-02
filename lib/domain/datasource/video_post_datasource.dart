import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';

abstract class VideoPostsDataSource {
  Future<List<VideosPost>> getFavoriteVideosByUser(String userID);

  Future<List<VideosPost>> getTrendingVideoByPage(int page);
}