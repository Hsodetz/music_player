import 'package:animate_do/animate_do.dart';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:music_player/src/helpers/helpers.dart';
import 'package:music_player/src/models/audio_player_model.dart';
import 'package:music_player/src/widgets/custom_appbar.dart';
import 'package:provider/provider.dart';

class MusicPlayerPage extends StatelessWidget {
  const MusicPlayerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Stack(
        children: [

          Background(),


          Column(
            children: [
              CustomAppbar(),
              ImageDiscDuration(),
              TitlePlay(),
              Expanded(child: Lyrics()),

            ],
          ),
        ],
      ),
    );
  }
}

class ImageDiscDuration extends StatelessWidget {
  const ImageDiscDuration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 30),
      margin: const EdgeInsets.only(top: 70),
      child: const Row(
        children: [
          
          ImageDisc(),
          SizedBox(width: 20,),
          ProgressBar(),
          SizedBox(width: 20,),
        ],
      ),
    );
  }
}

class ImageDisc extends StatelessWidget {
  const ImageDisc({super.key});

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);

    return Container(
      padding: const EdgeInsets.all(20),
      width: 250,
      height: 250,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(200)),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          colors: [
            Color(0xff484750),
            Color(0xff1E1C24),
          ],
        ),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(200),
        child: Stack(
          alignment: Alignment.center,
          children: [
            SpinPerfect(
              duration: const Duration(seconds: 10),
              controller: (p0) => audioPlayerModel.animationController = p0,
              infinite: true,
              manualTrigger: true,
              child: const Image(image: AssetImage('assets/images/aurora.jpg')),
            ),

            Container(
              width: 25,
              height: 25,
              decoration: BoxDecoration(
                color: Colors.black38,
                borderRadius: BorderRadius.circular(100)
              ),
            ),

            Container(
              width: 18,
              height: 18,
              decoration: BoxDecoration(
                color: const Color(0xff1C1C25),
                borderRadius: BorderRadius.circular(100)
              ),
            ),

          ]
        ),
      ),
    );
  }
}

class ProgressBar extends StatelessWidget {
  const ProgressBar({super.key});

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(color: Colors.white.withOpacity(0.4));
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context);
    final porcentaje = audioPlayerModel.percent;

    return Container(
      child: Column(
        children: [
          Text(audioPlayerModel.songTotalDuration, style: style,),

          const SizedBox(height: 10,),

          Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                width: 3,
                height: 230,
                color: Colors.grey.shade800,
              ),

              Container(
                width: 3,
                height: 230 * porcentaje,
                color: Colors.grey,
              ),
            ],
          ),

          const SizedBox(height: 10,),

          Text(audioPlayerModel.currentSecond, style: style,),

        ],
      ),
    );
  }
}

class TitlePlay extends StatefulWidget {
  const TitlePlay({super.key});

  @override
  State<TitlePlay> createState() => _TitlePlayState();
}

class _TitlePlayState extends State<TitlePlay> with SingleTickerProviderStateMixin {
  bool isPlaying = false;
  bool firstTime = true;
  late AnimationController animationController;
  final assetAudioPlayer = AssetsAudioPlayer();

  @override
  void initState() {
    animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    super.initState();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  void open() {
    final audioPlayermodel = Provider.of<AudioPlayerModel>(context, listen: false);

    assetAudioPlayer.open(
      //Audio("assets/music/Breaking-Benjamin-Far-Away.mp3"),
      Audio("assets/music/TheMamas&ThePapasCaliforniaDreamin.mp3"),
      autoStart: true,
      showNotification: true,
    );

    assetAudioPlayer.currentPosition.listen((duration) {
      audioPlayermodel.current = duration;
    });

    assetAudioPlayer.current.listen((playingAudio) {
      audioPlayermodel.songDuration = playingAudio?.audio.duration ?? const Duration(seconds: 0);
    });


  }

  @override
  Widget build(BuildContext context) {
    final audioPlayerModel = Provider.of<AudioPlayerModel>(context, listen: false);

    return Container(
      padding: const EdgeInsets.all(40),
      margin: const EdgeInsets.only(top: 40),
      child: Row(
        children: [

          Column(
            children: [
              const Text('Far Away', style: TextStyle(fontSize: 30),),
              Text('-Breaking Benjamin-', style: TextStyle(color: Colors.white.withOpacity(0.5)),)
            ],
          ),

          const Spacer(),


          FloatingActionButton(
            
            onPressed: () {
              if(isPlaying) {
                animationController.reverse();
                isPlaying = false;
                audioPlayerModel.animationController.stop();
              } else {
                animationController.forward();
                isPlaying = true;
                audioPlayerModel.animationController.repeat();
              }

              if(firstTime){
                open();
                firstTime = false;
              } else {
                assetAudioPlayer.playOrPause();
              }
              
            },
            backgroundColor: Colors.yellow.shade600,
            child: AnimatedIcon(
              icon: AnimatedIcons.play_pause, 
              progress: animationController
            ),
          ),

          // GestureDetector(
          //   onTap: () {
              
          //   },
          //   child: Container(
          //     width: 40,
          //     height: 40,
          //     decoration: BoxDecoration(
          //       color: Colors.yellow.shade600,
          //       borderRadius: BorderRadius.circular(100)
          //     ),
          //     child: const Icon(FontAwesomeIcons.play, size: 10, color: Colors.black,),
          //   ),
          // ),

        ],
      ),
    );
  }
}

class Lyrics extends StatelessWidget {
  const Lyrics({super.key});

  @override
  Widget build(BuildContext context) {
    final lyrics = getLyrics();

    return ListWheelScrollView(
      physics: const BouncingScrollPhysics(),
      itemExtent: 45,
      diameterRatio: 1.5,
      children: lyrics.map((e) => Text(e, style: TextStyle(fontSize: 20, color: Colors.white.withOpacity(0.4)),)).toList(),
    );
  }
}

class Background extends StatelessWidget {
  const Background({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      height: size.height * 0.8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(bottomLeft: Radius.circular(60)),
        gradient: LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.center,
          colors: [
            Color(0xff33333E),
            Color(0xff201E28),
          ],
        ),
      ),
    );
  }
}
