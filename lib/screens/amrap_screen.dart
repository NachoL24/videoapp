// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/providers/countdown_provider.dart';
//import 'package:video_app/providers/countdown_provider.dart';
import 'package:video_app/widgets/select_time_dropdown.dart';
import 'package:video_app/screens/camera_screen.dart';
import 'package:video_app/widgets/wod_description_text_field.dart';

import 'timer_screen.dart';

class AmrapScreen extends StatefulWidget {
  final colorTheme;
  final deviceHeight;
  final deviceWidth;

  const AmrapScreen({super.key, this.colorTheme, this.deviceHeight, this.deviceWidth});

  @override
  State<AmrapScreen> createState() => _AmrapScreenState();
}

class _AmrapScreenState extends State<AmrapScreen> {
  String minutesValue = '00';
  String secondsValue = '00';
  @override
  Widget build(BuildContext context) {
    //final countdownProvider = Provider.of<CountDownProvider>(context);
    final countdownProvider = Provider.of<CountDownProvider>(context);
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: widget.colorTheme.background,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_outlined), onPressed: () => Navigator.pop(context),),
        title: const Text('Amrap', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [

            SizedBox(height: widget.deviceHeight / 16),

            const Text('Select Time Cap', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),

            SizedBox(height: widget.deviceHeight / 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectTimeDropDown(dropDownType: DropDownType.minutes, deviceHeight: widget.deviceHeight, deviceWidth: widget.deviceWidth, colorTheme: widget.colorTheme, onChanged: (value) {setState(() {minutesValue = value;});},),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(':', textAlign: TextAlign.center ,style: TextStyle(fontSize: 64, fontWeight: FontWeight.w600, color: widget.colorTheme.primary.withOpacity(0.5),),),
                ),
                SelectTimeDropDown(dropDownType: DropDownType.seconds, deviceHeight: widget.deviceHeight, deviceWidth: widget.deviceWidth, colorTheme: widget.colorTheme, onChanged: (value) {setState(() {secondsValue = value;});},),
              ],
            ),

            SizedBox(height: widget.deviceHeight / 32,),

            //IconButton.outlined(onPressed: () { }, icon: const Icon(Icons.add), color: colorTheme.primary,  ),
            IconButton.filledTonal(onPressed: null, icon: Icon(Icons.add, color: widget.colorTheme.primary,)),

            SizedBox(height: widget.deviceHeight / 8,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.deviceWidth / 10),
              child: WodDescriptionTextField(),
            ),

            SizedBox(height: widget.deviceHeight / 16,),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                //SizedBox(width: widget.deviceWidth / 6,),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => widget.colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20)),
                  onPressed: () {
                    countdownProvider.setDuration(Duration(seconds: (int.parse(minutesValue)*60 + int.parse(secondsValue))));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const Timer(timerType: TimerType.countdown,)));
                  },
                  child: SizedBox(width: widget.deviceWidth / 6, child: Icon(Icons.timer, color: widget.colorTheme.background,)),
                ),
                //SizedBox(width: widget.deviceWidth / 5,),
                ElevatedButton(
                  style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => widget.colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20)),
                  onPressed: () {
                    countdownProvider.setDuration(Duration(seconds: (int.parse(minutesValue)*60 + int.parse(secondsValue))));
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraPage(timerType: TimerType.countdown)));
                  },
                  child: SizedBox(width: widget.deviceWidth / 6, child: Icon(Icons.videocam, color: widget.colorTheme.background,)),
                ),
              ],
            ),
          ],
          ),
        ),
      
      

      

    );
  }

    // ignore: unused_element
    Future<void> _cameraSetUp() async {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraPage(timerType: TimerType.countdown)));
    });
  }
}
