import 'package:flutter/material.dart';
import 'package:flutter_e103_toktik/domain/entities/videos_post.dart';
import 'package:flutter_e103_toktik/presentation/provider/discover_provider.dart';
import 'package:provider/provider.dart';

class CommentsSection extends StatefulWidget {
  final VideosPost video;
  const CommentsSection({super.key, required this.video});

  @override
  State<CommentsSection> createState() => _CommentsSectionState();
}

class _CommentsSectionState extends State<CommentsSection> {
  final TextEditingController _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DiscoverProvider>(context);
    final comments = provider.getCommentsFor(widget.video);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            children: [
              Container(
                height: 6,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.grey[700],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              const SizedBox(height: 12),
              Text('Comentarios', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              Expanded(
                child: comments.isEmpty
                    ? Center(child: Text('Sé el primero en comentar'))
                    : ListView.separated(
                        itemBuilder: (_, i) => ListTile(
                          leading: CircleAvatar(child: Text(comments[i][0].toUpperCase())),
                          title: Text(comments[i]),
                        ),
                        separatorBuilder: (_, __) => Divider(),
                        itemCount: comments.length,
                      ),
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _ctrl,
                      decoration: InputDecoration(
                        hintText: 'Escribe un comentario',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                        contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      final text = _ctrl.text.trim();
                      if (text.isEmpty) return;
                      provider.addComment(widget.video, text);
                      _ctrl.clear();
                      // keep the sheet open and update UI via provider
                    },
                    child: Text('Enviar'),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
