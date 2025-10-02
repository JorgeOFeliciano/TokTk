import 'package:flutter/material.dart';
import 'package:flutter_e103_toktik/config/theme/app_theme.dart';
import 'package:flutter_e103_toktik/infrastrcture/datasource/localvideo_datasource_impl.dart';
import 'package:flutter_e103_toktik/infrastrcture/repositories/videopost_repository_impl.dart';
import 'package:flutter_e103_toktik/presentation/provider/discover_provider.dart';
import 'package:flutter_e103_toktik/presentation/screens/discover/discover_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    final videoPostRepository = VideopostRepositoryImpl(
      videoPostsDataSource: LocalvideoDatasourceImpl()
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          lazy: false,
          create: (_) => DiscoverProvider(
            videosRepository: videoPostRepository)..loadNextPage(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme().getTheme(),
        home: DiscoverScreen(),
      ),
    );
  }
}