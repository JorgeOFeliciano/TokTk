import 'package:flutter/material.dart';
import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';
import 'package:flutter_e103_toktik/widget/shared/video_buttons.dart';
import 'package:flutter_e103_toktik/widget/video/fullscreen_player.dart';

class VideoScrollableView extends StatelessWidget {
  final List<VideosPost> videos;

  const VideoScrollableView({super.key, required this.videos});

  @override
  Widget build(BuildContext context) {
    return PageView.builder(
      scrollDirection: Axis.vertical,
      physics: BouncingScrollPhysics(),
      itemCount: videos.length,
      itemBuilder: (context, index) {
        final VideosPost videoPost = videos[index];
        
        return Stack(
          children: [
            //video + gradientes
            SizedBox.expand(
              child: FullScreenPlayer(
              video: videoPost,
              ),
            ),
            //Botones a usar
            Positioned(
              bottom: 40,
              right: 20,
              child: VideoButtons(video: videoPost),)
      ],
        );
      },
    );
  }
}
