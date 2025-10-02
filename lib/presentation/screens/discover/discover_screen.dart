import 'package:flutter/material.dart';
import 'package:flutter_e103_toktik/presentation/provider/discover_provider.dart';
import 'package:flutter_e103_toktik/widget/shared/video_scrollable_view.dart';
import 'package:provider/provider.dart';

class DiscoverScreen extends StatelessWidget {
  const DiscoverScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final discoverProvider = context.watch<DiscoverProvider>();

    return Scaffold(
      body: discoverProvider.initialLoading
      ? Center(child: CircularProgressIndicator(strokeWidth: 2,))
      : VideoScrollableView(videos: discoverProvider.videos)
    );
  }
}