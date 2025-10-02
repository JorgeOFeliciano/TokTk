class VideosPost {
  final String caption;
  final String videoUrl;
  final int likes;
  final int views;
  final bool isFavorite;

  VideosPost({
    required this.caption, 
    required this.videoUrl, 
    this.likes = 0, 
    this.views = 0,
    this.isFavorite = false,
  });

  VideosPost copyWith({
    String? caption,
    String? videoUrl,
    int? likes,
    int? views,
    bool? isFavorite,
  }) {
    return VideosPost(
      caption: caption ?? this.caption,
      videoUrl: videoUrl ?? this.videoUrl,
      likes: likes ?? this.likes,
      views: views ?? this.views,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }
}
