
import 'package:flutter/material.dart';

class AudioPlayerModel with ChangeNotifier {
  
  bool _isPlaying = false;
  Duration _songDuration = const Duration(milliseconds: 0);
  Duration _current = const Duration(milliseconds: 0);

  late AnimationController _animationController;

  bool get isPlaying => _isPlaying;
  Duration get songDuration => _songDuration;
  Duration get current => _current;

  double get percent => _songDuration.inSeconds > 0 ? _current.inSeconds / _songDuration.inSeconds : 0;
  String get songTotalDuration => printDuration( _songDuration );
  String get currentSecond     => printDuration( _current );

  AnimationController get animationController => _animationController;

  set isPlaying( bool value ) {
    _isPlaying = value;
    notifyListeners();
  }

  set songDuration( Duration value ) {
    _songDuration = value;
    notifyListeners();
  }

  set current( Duration value ) {
    _current = value;
    notifyListeners();
  }

  set animationController( AnimationController value ) {
    _animationController = value;
  }

  String printDuration(Duration duration) {
  
    String twoDigits(int n) {
      if (n >= 10) return "$n";
      return "0$n";
    }

    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    // return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
    return "$twoDigitMinutes:$twoDigitSeconds";
  }




}