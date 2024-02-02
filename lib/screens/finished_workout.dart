import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/providers/countdown_provider.dart';
import 'package:video_app/providers/countup_provider.dart';
import 'package:video_app/providers/tabata_provider.dart';
import 'package:video_app/screens/home_screen.dart';

class FinishedWorkout extends StatefulWidget {
  const FinishedWorkout({super.key});

  @override
  State<FinishedWorkout> createState() => _FinishedWorkoutState();
}

class _FinishedWorkoutState extends State<FinishedWorkout> {
  @override
  Widget build(BuildContext context) {
    final countdownProvider = Provider.of<CountDownProvider>(context);
    final countupProvider = Provider.of<CountupProvider>(context);
    final tabataProvider = Provider.of<TabataProvider>(context);
    final colorTheme = Theme.of(context).colorScheme;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    return  Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ElasticIn(
              duration: const Duration(seconds: 3),
              child: Container(
                width: deviceWidth / 1.5,
                height: 500,
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  shape: BoxShape.circle,
                  border: Border.all(
                    width: 15,
                    color: colorTheme.primary,
                  )
        
                ),
                child: Icon(Icons.done_rounded, size: 200, color: colorTheme.primary,)
                )
              ),
            const Text("You crushed it!", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            SizedBox(height: deviceHeight / 8,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: deviceWidth/4),
              child: FilledButton.icon(
                icon: const Icon(Icons.arrow_back_ios_new),
                style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20), minimumSize: MaterialStateProperty.resolveWith((states) => Size(0/*deviceWidth / 1.6*/, deviceHeight / 16))),
                label: Text("Go back", style: TextStyle(fontSize: 20 , color: colorTheme.background),),
                onPressed: () {
                  countdownProvider.finished = false;
                  countupProvider.finished = false;
                  tabataProvider.finished = false;
                  Navigator.push(context, MaterialPageRoute(builder: (context) => const MyHomePage()));
                },
                ),
            )
        ],),
      )
    );
  }
}