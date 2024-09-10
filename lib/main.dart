import 'package:flutter/material.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:music_player/src/pages/music_player_page.dart';
import 'package:music_player/src/theme/theme.dart';
import 'package:provider/provider.dart';

void main() => runApp(
  MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => AudioPlayerModel(),)
    ],
    child: const MyApp(),
  )
);

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: miTema,
      title: 'Music Player',
      home: const Scaffold(
        // appBar: AppBar(
        //   title: const Text('Music Player'),
        // ),
        body: MusicPlayerPage(),
      ),
    );
  }
}