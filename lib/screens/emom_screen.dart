// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/providers/tabata_provider.dart';
import 'package:video_app/screens/timer_screen.dart';
import 'package:video_app/widgets/select_time_dropdown.dart';
import 'package:video_app/screens/camera_screen.dart';
import 'package:video_app/widgets/wod_description_text_field.dart';

class EmomScreen extends StatefulWidget {
  final colorTheme;
  final deviceHeight;
  final deviceWidth;

  const EmomScreen({super.key, this.colorTheme, this.deviceHeight, this.deviceWidth});

  @override
  State<EmomScreen> createState() => _EmomScreenState();
}

class _EmomScreenState extends State<EmomScreen> {
  String workMinutesValue = "00";
  String breakMinutesValue = "00";
  String workSecondsValue = "00";
  String breakSecondsValue = "00";
  String roundsValue = "00";
  @override
  Widget build(BuildContext context) {
    //final ScrollController chatScrollController = ScrollController();
    final tabataProvider = Provider.of<TabataProvider>(context);
    return Scaffold(
      resizeToAvoidBottomInset: false,

      appBar: AppBar(
        backgroundColor: widget.colorTheme.background,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_outlined), onPressed: () => Navigator.pop(context),),
        title: const Text('Emom / Tabata', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: Column(children: [
          SizedBox(height: widget.deviceHeight / 32),
            
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    const Text('Work Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                    
                    SizedBox(height: widget.deviceHeight / 64),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SelectTimeDropDown(dropDownType: DropDownType.minutes, deviceHeight: widget.deviceHeight, deviceWidth: widget.deviceWidth, colorTheme: widget.colorTheme, onChanged: (value) {setState(() {workMinutesValue = value;});},),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: Text(':', textAlign: TextAlign.center ,style: TextStyle(fontSize: 64, fontWeight: FontWeight.w600, color: widget.colorTheme.primary.withOpacity(0.5),),),
                        ),
                        SelectTimeDropDown(dropDownType: DropDownType.seconds, deviceHeight: widget.deviceHeight, deviceWidth: widget.deviceWidth, colorTheme: widget.colorTheme, onChanged: (value) {setState(() {workSecondsValue = value;});},),
                      ],
                    ),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                    const Text('Rounds', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
                                
                    SizedBox(height: widget.deviceHeight / 64),
                    
                    SelectTimeDropDown(dropDownType: DropDownType.rounds, deviceHeight: widget.deviceHeight, deviceWidth: widget.deviceWidth, colorTheme: widget.colorTheme, onChanged: (value) {setState(() {roundsValue = value;});},),
                  ],
                ),
            
              ],
            ),
            
            SizedBox(height: widget.deviceHeight / 32,),
            //rest time selection
            const Text('Rest Time', style: TextStyle(fontSize: 20, fontWeight: FontWeight.normal),),
            
            SizedBox(height: widget.deviceHeight / 64),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SelectTimeDropDown(dropDownType: DropDownType.minutes, deviceHeight: widget.deviceHeight, deviceWidth: widget.deviceWidth, colorTheme: widget.colorTheme, onChanged: (value) {setState(() {breakMinutesValue = value;});},),
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Text(':', textAlign: TextAlign.center ,style: TextStyle(fontSize: 64, fontWeight: FontWeight.w600, color: widget.colorTheme.primary.withOpacity(0.5),),),
                ),
                SelectTimeDropDown(dropDownType: DropDownType.seconds, deviceHeight: widget.deviceHeight, deviceWidth: widget.deviceWidth, colorTheme: widget.colorTheme, onChanged: (value) {setState(() {breakSecondsValue = value;});},),
              ],
            ),
            
            SizedBox(height: widget.deviceHeight / 32,),
        
            
            Padding(
              padding: EdgeInsets.symmetric(horizontal: widget.deviceWidth / 10),
              child: WodDescriptionTextField()
            ),
            
            SizedBox(height: widget.deviceHeight / 32,),
            
            Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        //SizedBox(width: widget.deviceWidth / 6,),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => widget.colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20)),
          onPressed: () {
            tabataProvider.setDuration(Duration(seconds: (int.parse(workMinutesValue)*60 + int.parse(workSecondsValue))));
            tabataProvider.setRestDuration(Duration(seconds: (int.parse(breakMinutesValue)*60 + int.parse(breakSecondsValue))));
            tabataProvider.setRounds(int.parse(roundsValue));
            Navigator.push(context, MaterialPageRoute(builder: (context) => const Timer(timerType: TimerType.tabata,)));
          },
          child: SizedBox(width: widget.deviceWidth / 6, child: Icon(Icons.timer, color: widget.colorTheme.background,)),
        ),
        //SizedBox(width: widget.deviceWidth / 5,),
        ElevatedButton(
          style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => widget.colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20)),
          onPressed: () {
            tabataProvider.setDuration(Duration(seconds: (int.parse(workMinutesValue)*60 + int.parse(workSecondsValue))));
            tabataProvider.setRestDuration(Duration(seconds: (int.parse(breakMinutesValue)*60 + int.parse(breakSecondsValue))));
            tabataProvider.setRounds(int.parse(roundsValue));
            Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraPage(timerType: TimerType.tabata)));
          },
          child: SizedBox(width: widget.deviceWidth / 6, child: Icon(Icons.videocam, color: widget.colorTheme.background,)),
        ),
      ],
            ),
            ],
        )
 
    );
  }

    // ignore: unused_element
    Future<void> _cameraSetUp() async {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraPage(timerType: TimerType.tabata)));
    });
  }
}