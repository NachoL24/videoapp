import 'package:flutter/material.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:provider/provider.dart';
import 'package:video_app/providers/countdown_provider.dart';
import 'package:video_app/providers/countup_provider.dart';
import 'package:video_app/providers/tabata_provider.dart';
import 'package:video_app/screens/finished_workout.dart';
//import 'package:video_app/providers/theme.dart';

enum TimerType {countdown , countup , tabata}

class Timer extends StatelessWidget {
  const Timer({super.key, required this.timerType});
  final TimerType timerType;

  @override
  Widget build(BuildContext context) {
    final countdownProvider = Provider.of<CountDownProvider>(context);
    final countupProvider = Provider.of<CountupProvider>(context);
    final tabataProvider = Provider.of<TabataProvider>(context);
    //final provider = Provider.of<ThemeProvider>(context);
    final colorTheme = Theme.of(context).colorScheme;
    final deviceWidth = MediaQuery.of(context).size.width;
    //final deviceHeight = MediaQuery.of(context).size.height;
    if(countdownProvider.isFinished || countupProvider.isFinished || tabataProvider.isFinished) {
       return const FinishedWorkout();
    }
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorTheme.background,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_outlined), onPressed: () => Navigator.pop(context),),
        centerTitle: false,
        title: const Text('Timer'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Column(
              children: [
                CircularPercentIndicator(
                  animation: true,
                  animationDuration: 1000,
                  animateFromLastPercent: true,
                  radius: deviceWidth / 2.5,
                  lineWidth: 20,
                  percent: 
                    timerType != TimerType.tabata 
                      ? (timerType == TimerType.countdown
                        ? 1 - context.select((CountDownProvider count) => count.progress)
                        : context.select((CountupProvider count) => count.progress)) 
                      : 1 - context.select((TabataProvider count) => count.progress),
                  progressColor: colorTheme.primary,
                  backgroundColor: colorTheme.primary.withOpacity(0.4),
                  circularStrokeCap: CircularStrokeCap.round,
                  center: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    
                    children: [
                      Text( timerType != TimerType.tabata 
                        ? (timerType == TimerType.countdown
                          ? context.select((CountDownProvider count) => count.timeLeftString)
                          : context.select((CountupProvider count) => count.timeLeftString)) 
                        : context.select((TabataProvider count) => count.timeLeftString), 
                      style: const TextStyle(fontSize: 70, fontWeight: FontWeight.bold),),
                      ],
                    ),                
                ),
                if(timerType == TimerType.tabata)
                  Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Row(              
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        CircularPercentIndicator(
                          animation: true,
                          animationDuration: 900,
                          animateFromLastPercent: true,
                          radius: 50,
                          lineWidth: 10,
                          percent: context.select((TabataProvider count) => count.roundsProgress),
                          progressColor: colorTheme.primary,
                          backgroundColor: colorTheme.primary.withOpacity(0.4),
                          circularStrokeCap: CircularStrokeCap.round,          
                          center: Text(context.select((TabataProvider count) => count.roundsLeftString))
                        ),
                      ],
                    ),
                  ),
              ],
            ),
            
            ElevatedButton(
              onPressed: (){
                switch (timerType){
                  case TimerType.countdown:
                    countdownProvider.startStopTimer();
                    break;
                  case TimerType.countup:
                    countupProvider.startStopTimer();
                    break;
                  case TimerType.tabata:
                    tabataProvider.startStopTimer();
                    break;
                }
              }, 
              child: Icon((countdownProvider.isRunning || countupProvider.isRunning) ? Icons.pause : Icons.play_arrow_rounded)
            ),

           
            ElevatedButton(
              onPressed: (){
                switch (timerType){
                  case TimerType.countdown:
                  if(countdownProvider.isRunning){
                    countdownProvider.finishTimer();
                  }else{
                    null;
                  }
                    break;
                  case TimerType.countup:
                    if(countupProvider.isRunning){
                      countupProvider.finishTimer();
                    }else{
                      null;
                    }
                    break;
                  case TimerType.tabata:
                    if(tabataProvider.isRunning){
                      tabataProvider.finishTimer();
                    }else{
                      null;
                    }
                    break;
                }
              }, 
              child: const Icon(Icons.square)
            ),
          ],
          ),
        ),
        
    );
  }
}
