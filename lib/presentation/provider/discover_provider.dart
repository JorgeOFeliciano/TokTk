//import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';
import 'package:flutter_e103_toktik/domain/repositories/videopost_repository_impl.dart';
import 'package:flutter_e103_toktik/shared/data/local_video_post.dart';

class DiscoverProvider extends ChangeNotifier{
  final VideoPostsRepository videosRepository;


  bool initialLoading = true;
  List<VideosPost> videos = [];
  // In-memory comments storage keyed by videoUrl
  final Map<String, List<String>> _comments = {};

  List<String> getCommentsFor(VideosPost video) {
    return _comments[video.videoUrl] ?? [];
  }

  void addComment(VideosPost video, String comment) {
    final list = _comments.putIfAbsent(video.videoUrl, () => []);
    list.add(comment);
    notifyListeners();
  }

  void incrementLikes(VideosPost video) {
    final index = videos.indexWhere((v) => v.videoUrl == video.videoUrl);
    if (index != -1) {
      final current = videos[index];
      videos[index] = current.copyWith(likes: current.likes + 1);
      notifyListeners();
    }
  }

  void decrementLikes(VideosPost video) {
    final index = videos.indexWhere((v) => v.videoUrl == video.videoUrl);
    if (index != -1) {
      final current = videos[index];
      videos[index] = current.copyWith(likes: current.likes - 1);
      notifyListeners();
    }
  }


  void incrementViews(VideosPost video) {
    final index = videos.indexWhere((v) => v.videoUrl == video.videoUrl);
    if (index != -1) {
      final current = videos[index];
      videos[index] = current.copyWith(views: current.views + 1);
      notifyListeners();
    }
  }

  void toggleFavorite(VideosPost video) {
    final index = videos.indexWhere((v) => v.videoUrl == video.videoUrl);
    if (index != -1) {
      final current = videos[index];

      if (current.isFavorite) {
        // Quita de favoritos ➝ resta like
        videos[index] = current.copyWith(
          isFavorite: false,
          likes: current.likes > 0 ? current.likes - 1 : 0,
        );
      } else {
        // Agrega a favoritos ➝ suma like
        videos[index] = current.copyWith(
          isFavorite: true,
          likes: current.likes + 1,
        );
      }

      notifyListeners();
    }
  }



  DiscoverProvider({required this.videosRepository});


  Future<void> loadNextPage() async {
    // Obtén los videos desde tu repo
    final newVideos = await videosRepository.getTrendingVideoByPage(1);

    // Guarda los videos
    videos.addAll(newVideos);

    // ⚡ Aquí llenamos los comentarios iniciales
    for (var video in videoPosts) {
      final url = video['videoURL'] as String;
      final comments = (video['comments'] ?? []).cast<String>();
      if (comments.isNotEmpty) {
        _comments[url] = comments;
      }
    }

    initialLoading = false;
    notifyListeners();
  }
}