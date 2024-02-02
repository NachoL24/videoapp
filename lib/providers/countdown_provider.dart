import 'dart:async';

import 'package:flutter/material.dart';

class CountDownProvider extends ChangeNotifier {
  Duration duration = const Duration(seconds: 0);
  Duration maxDuration = const Duration();
  bool isRunning = false;
  bool finished = false;
  bool pre = true;
  bool image = false;
  Timer? timer;
  Duration preTimer = const Duration(seconds: 10);

  //suscription
  void startStopTimer()  {
    finished = false;
    if (isRunning) {
      timer?.cancel();
    } else {
      _startPreTimer();
      
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

  void _startPreTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) async {
      preTimer = Duration(seconds: preTimer.inSeconds - 1);

      if (preTimer.inMilliseconds < 0) {
        timer?.cancel();
        pre = false;
        image = true;
        notifyListeners();
        await Future.delayed(const Duration(seconds: 1));
        image = false;
        notifyListeners();
        _startTimer();
      }
      notifyListeners();
    });
  }

  void _startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (_) => substractTime());
  }

  void substractTime() {
    duration = Duration(seconds: duration.inSeconds - 1);
    if(duration.inMilliseconds < 0) {
      finishTimer();
    }
    notifyListeners();
  }

  void setDuration(Duration newDuration){
    preTimer = const Duration(seconds: 10);
    duration = newDuration;
    maxDuration = newDuration;
    isRunning = false;
    finished = false;
    notifyListeners();
    pre = true;
  }

  bool get isFinished => finished;

  String get timeLeftString{
    if(image == false){
      if(pre == false){
        if(duration.inSeconds > 0){
        final minutes = ((duration.inSeconds / 60) % 60).floor().toString().padLeft(2,'0');
        final seconds = (duration.inSeconds % 60).floor().toString().padLeft(2, '0');
        return '$minutes:$seconds';
        } else{
          return '00:00';
        }
      }else{
        final premin = ((preTimer.inSeconds / 60) % 60).floor().toString().padLeft(2,'0');
        final presecs = (preTimer.inSeconds % 60).floor().toString().padLeft(2, '0');
        return '$premin:$presecs';
      }
    }else{
      return 'GO!';
    }
  }

 double get progress{
  return isRunning ? (pre ? (preTimer.inSeconds / 10) : (duration.inSeconds / maxDuration.inSeconds)) : 1;
 }
}