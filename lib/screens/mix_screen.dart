// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:video_app/screens/timer_screen.dart';
import 'package:video_app/widgets/select_time_dropdown.dart';
import 'package:video_app/screens/camera_screen.dart';
import 'package:video_app/widgets/wod_description_text_field.dart';

class MixScreen extends StatefulWidget {
  final colorTheme;
  final deviceHeight;
  final deviceWidth;

  const MixScreen({super.key, this.colorTheme, this.deviceHeight, this.deviceWidth});

  @override
  State<MixScreen> createState() => _MixScreenState();
}

class _MixScreenState extends State<MixScreen> {
  String minutesValue = "00";
  String secondsValue = "00";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: widget.colorTheme.background,
        leading: IconButton(icon: const Icon(Icons.arrow_back_ios_outlined), onPressed: () => Navigator.pop(context),),
        title: const Text('Mix', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Center(
          child: Column(
            children: [
              const Padding(padding: EdgeInsets.only(top: 100)),
        
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
                child: WodDescriptionTextField()
              ),
        
              SizedBox(height: widget.deviceHeight / 16,),
        
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  //SizedBox(width: widget.deviceWidth / 6,),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => widget.colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20)),
                    onPressed: () {
                      //todo: implementar el mix
                    },
                    child: SizedBox(width: widget.deviceWidth / 6, child: Icon(Icons.timer, color: widget.colorTheme.background,)),
                  ),
                  //SizedBox(width: widget.deviceWidth / 5,),
                  ElevatedButton(
                    style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => widget.colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20)),
                    onPressed: () {
                      //todo: implementar el mix
                      _cameraSetUp;
                    },
                    child: SizedBox(width: widget.deviceWidth / 6, child: Icon(Icons.videocam, color: widget.colorTheme.background,)),
                  ),
                ],
              ),
            ],
            ),
          ),
      ),
      
      

      

    );
  }

    Future<void> _cameraSetUp() async {
    setState(() {
      Navigator.push(context, MaterialPageRoute(builder: (context) => const CameraPage(timerType: TimerType.countdown)));
    });
  }
}