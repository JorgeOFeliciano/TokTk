import 'package:flutter/material.dart';
import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';
import 'package:flutter_e103_toktik/presentation/provider/discover_provider.dart';
import 'package:flutter_e103_toktik/widget/video/video_background.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class FullScreenPlayer extends StatefulWidget {
  final VideosPost video;

  const FullScreenPlayer({super.key, required this.video});

  @override
  State<FullScreenPlayer> createState() => _FullScreenPlayerState();
}


class _FullScreenPlayerState extends State<FullScreenPlayer> {
  late VideoPlayerController controller;

  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.asset(widget.video.videoUrl)
      ..setVolume(0)
      ..setLooping(true)
      ..initialize().then((_) {
        if (mounted) {
          controller.play();

          // 👇 Incrementar vistas cuando el video empieza
          final provider = Provider.of<DiscoverProvider>(context, listen: false);
          provider.incrementViews(widget.video);
        }
      });
  }


  @override
  void dispose(){
    controller.dispose();
    super.dispose();
  }
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: controller.initialize(), 
      builder: (context, snapshot){
        if(snapshot.connectionState != ConnectionState.done){
          CircularProgressIndicator(strokeWidth: 2);
        }
        return GestureDetector(
          onTap: (){
            if(controller.value.isPlaying){
              controller.pause();
            } else {
              controller.play();
            }
          },
          child: AspectRatio(aspectRatio: controller.value.aspectRatio,
            child: Stack(
              children: [
              VideoPlayer(controller),
          
              //Gradiente
              VideoBackground(stops: [0.8,1.0],),
              Positioned(
                bottom: 50,
                left: 20,
                child: _VideoCaption(caption: widget.video.caption),
              )
              ]
            ),
          ),
        );
      },
    );
  }
}

class _VideoCaption extends StatelessWidget{

  final String caption;

  const _VideoCaption({required this.caption});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final tittleStyle = Theme.of(context).textTheme.titleLarge;

    return SizedBox(
      width: size.width * 0.6,
      
      child: Text(
        caption,
        maxLines: 5,
        style: tittleStyle,
      )
    );
  }
}