import 'dart:async';

import 'package:flutter/material.dart';


class TabataProvider extends ChangeNotifier {
 Timer? timer;
 Duration duration = const Duration(seconds: 75);
 Duration maxDuration = const Duration(seconds: 75);
 bool isRunning = false;
 bool isRest = false;
 int roundCounter = 8;
 int maxRounds = 8;
 Duration maxRestDuration = const Duration(seconds: 0);
 Duration restDuration = const Duration(seconds: 0);
 StreamSubscription<int>? _tickSubscription;
 bool finished = false;

 //suscription
 void startStopTimer() {
  finished = false;
  isRest = false;
    if (isRunning) {
      timer?.cancel();
    } else {
      _startWorkTimer();
    }
    isRunning = !isRunning;
    notifyListeners();
 }

  void finishTimer(){
    finished=true;
    timer?.cancel();
    isRunning=false;
    notifyListeners();
  }

  void _startWorkTimer() {
    duration = maxDuration;
    isRest = false;
    timer = Timer.periodic(const Duration(seconds: 1), (_) => subtractWorkTime());
  }

  void subtractWorkTime() {
    duration = Duration(seconds: duration.inSeconds - 1);
    if( duration.inSeconds < 0 ) {
      timer?.cancel();
      roundCounter--;
      if(roundCounter > 0) {
        if(maxRestDuration.inSeconds > 0){
          _startRestTimer();
        }else{
          _startWorkTimer();
        }
      } else{
        finishTimer();
      }
    }
    notifyListeners();
  }

  void _startRestTimer(){
    restDuration = maxRestDuration;
    isRest = true;
    timer = Timer.periodic(const Duration(seconds: 1), (_) => subtractRestTime());
  }

  void subtractRestTime() {
    restDuration = Duration(seconds: restDuration.inSeconds - 1);
    if( restDuration.inSeconds < 0 ) {
      timer?.cancel();
      _startWorkTimer();
    }
    notifyListeners();
  }

  void setDuration(Duration newDuration){
    duration = newDuration;
    maxDuration = newDuration;
    isRunning = false;
    finished == false;
    _tickSubscription?.cancel();
    notifyListeners();
  }

  void setRestDuration(Duration newDuration){
    restDuration = newDuration;
    maxRestDuration = newDuration;
    isRunning = false;
    finished == false;
    _tickSubscription?.cancel();
    notifyListeners();
  }

  void setRounds(int newRoundCounter){
    roundCounter = newRoundCounter;
    maxRounds = newRoundCounter;
    isRunning = false;
    finished = false;
    _tickSubscription?.cancel();
    notifyListeners();
  }

  String get timeLeftString{
  if(isRunning == true){
    final minutes = (isRest == false ? ((duration.inSeconds / 60) % 60) : ((restDuration.inSeconds / 60) % 60)).floor().toString().padLeft(2,'0');
    final seconds = (isRest == false ? (duration.inSeconds % 60) : (restDuration.inSeconds % 60)).floor().toString().padLeft(2, '0');
    if(finished == true){
      return '00:00';
    }
    return '$minutes:$seconds';
  }else{
    final minutes = (isRest == false ? ((maxDuration.inSeconds / 60) % 60) : ((maxRestDuration.inSeconds / 60) % 60)).floor().toString().padLeft(2,'0');
    final seconds = (isRest == false ? (maxDuration.inSeconds % 60) : (maxRestDuration.inSeconds % 60)).floor().toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }
  }

  String get roundsLeftString{
    return roundCounter.toString();
  }

  double get roundsProgress{
    return roundCounter / maxRounds;
  }

  double get progress{
    if(finished == false){
      if(isRest == true) {
        return restDuration.inSeconds / maxRestDuration.inSeconds;
      }else{
        return duration.inSeconds / maxDuration.inSeconds;
      }
    }else{
      return 1;
    }
  }

  bool get isFinished => finished;

}