import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_e103_toktik/config/helpers/human_formats.dart';
import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';
import 'package:flutter_e103_toktik/presentation/provider/discover_provider.dart';
import 'package:provider/provider.dart';
import '../shared/comments_section.dart';

class VideoButtons extends StatelessWidget {
  final VideosPost video;

  const VideoButtons({
    super.key, 
    required this.video
    });

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscoverProvider>(context);
    // Get the most-up-to-date video instance from provider if available
    final current = provider.videos.firstWhere(
      (v) => v.videoUrl == video.videoUrl,
      orElse: () => video,
    );

    return Column(
      children: [
        _ButtonColumn(
          iconData: Icons.favorite,
          onPressed: () => provider.toggleFavorite(video),
          value: current.likes,
          color: current.isFavorite ? Colors.red : Colors.white, // 👈 cambia color
        ),
        const SizedBox(height: 16),
        _IconWithCounter(
          iconData: Icons.remove_red_eye,
          value: current.views,
        ),
        const SizedBox(height: 16),
        IconButton(
          onPressed: () {
            // open comments bottom sheet
            showModalBottomSheet(
              context: context,
              isScrollControlled: true,
              builder: (_) => Padding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
                child: CommentsSection(video: video),
              ),
            );
          },
          icon: Icon(Icons.comment),
          color: Colors.white,
          iconSize: 30,
        ),
        Consumer<DiscoverProvider>(
          builder: (_, provider, __) {
            final comments = provider.getCommentsFor(video);
            return Text(
              comments.isNotEmpty
                  ? HumanFormats.humanReadableNumber(comments.length.toDouble())
                  : '0',
              style: const TextStyle(color: Colors.white),
            );
          },
        ),
        const SizedBox(height: 16),
        IconButton(
          onPressed: () async {
            final link = 'https://example.com/video?u=' + Uri.encodeComponent(video.videoUrl);
            await Clipboard.setData(ClipboardData(text: link));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Enlace copiado al portapapeles')));
          },
          icon: Icon(Icons.link),
          color: Colors.white,
          iconSize: 28,
        ),
        SizedBox(height: 20),
        SpinPerfect(
          infinite: true,
          duration: Duration(seconds: 5),
          child: _CustomIconButton(
            value: 0,
            iconData: Icons.play_circle_outline
          ),
        ),
      ],
    );
  }
}

class _CustomIconButton extends StatelessWidget {
  final int value;
  final IconData iconData;
  final Color? color;

  const _CustomIconButton({
    required this.value,
    required this.iconData,
    iconColor,
  }) : color = iconColor ?? Colors.white;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(iconData),
          color: color,
          iconSize: 30,
        ),
        if(value>0)
          Text(HumanFormats.humanReadableNumber(value.toDouble())),
      ],
    );
  }
}

class _ButtonColumn extends StatelessWidget {
  final IconData iconData;
  final VoidCallback onPressed;
  final int value;
  final Color color;

  const _ButtonColumn({
    required this.iconData,
    required this.onPressed,
    required this.value,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: onPressed, 
          icon: Icon(iconData),
          color: color,
          iconSize:30,
          ),
          if(value>0)
            Text(HumanFormats.humanReadableNumber(value.toDouble()), style: TextStyle(color: Colors.white)),
      ],
    );
  }
}

class _IconWithCounter extends StatelessWidget {
  final IconData iconData;
  final int value;
  final Color color;

  const _IconWithCounter({
    required this.iconData,
    required this.value,
    this.color = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          iconData,
          color: color,
          size: 30,
        ),
        if (value > 0)
          Text(
            HumanFormats.humanReadableNumber(value.toDouble()),
            style: TextStyle(color: Colors.white),
          ),
      ],
    );
  }
}
