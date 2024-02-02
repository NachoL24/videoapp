import 'dart:async';

import 'package:flutter/material.dart';

class CountupProvider extends ChangeNotifier {
  Duration duration = const Duration(seconds: 0);
  Duration maxDuration = const Duration();
  bool isRunning = false;
  bool finished = false;
  Timer? timer;

  //suscription
  void startStopTimer() {
    finished = false;
    if (isRunning) {
      timer?.cancel();
    } else {
      _startTimer();
    }
    isRunning = !isRunning;
    notifyListeners();
  }

  void finishTimer(){
    timer?.cancel();
    isRunning=false;
    finished=true;
    notifyListeners();
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => addTime());
  }

  void addTime() {
    duration = Duration(seconds: duration.inSeconds + 1);
    if( maxDuration.inSeconds!=0 && duration.inSeconds >= maxDuration.inSeconds) {
      finishTimer();
    }
    notifyListeners();
  }

  void setDuration(Duration newDuration){
    duration = const Duration(seconds: 0);
    maxDuration = newDuration;
    isRunning = false;
    finished = false;
    notifyListeners();
  }

  bool get isFinished => finished;

  String get timeLeftString{
    final minutes = ((duration.inSeconds / 60) % 60).floor().toString().padLeft(2,'0');
    final seconds = (duration.inSeconds % 60).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

 double get progress{
  return isRunning ? (maxDuration.inSeconds == 0 ?(1) :( duration.inSeconds == 0 ? (0) : ((duration.inSeconds + 1)/ maxDuration.inSeconds))) : 0;
 }
}