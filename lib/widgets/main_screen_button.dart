// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:video_app/screens/amrap_screen.dart';
import 'package:video_app/screens/emom_screen.dart';
import 'package:video_app/screens/for_time_screen.dart';
import 'package:video_app/screens/mix_screen.dart';

enum Pages { amrap , forTime , emom , mix}

class MainScreenButton extends StatelessWidget {
  final text;
  final deviceHeight;
  final deviceWidth;
  final colorTheme;
  final Pages page;
  const MainScreenButton({super.key, this.text, this.deviceHeight, this.deviceWidth, this.colorTheme, required this.page});

  @override
  Widget build(BuildContext context) {
    return FilledButton(
              style: ButtonStyle(backgroundColor: MaterialStateColor.resolveWith((states) => colorTheme.primary), elevation: MaterialStateProperty.resolveWith((states) => 20)),
              child: SizedBox(
                width: deviceWidth / 1.6,
                height: deviceHeight / 16,
                child: Center(child: Text(text, style: TextStyle(fontSize: 20 , color: colorTheme.background),)),
              ),
              onPressed: () {
                switch (page) {
                  case Pages.amrap:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => AmrapScreen(colorTheme: colorTheme, deviceHeight: deviceHeight, deviceWidth: deviceWidth,)));
                  case Pages.forTime:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ForTimeScreen(colorTheme: colorTheme, deviceHeight: deviceHeight, deviceWidth: deviceWidth,)));
                  case Pages.emom:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => EmomScreen(colorTheme: colorTheme, deviceHeight: deviceHeight, deviceWidth: deviceWidth,)));
                  case Pages.mix:
                    Navigator.push(context, MaterialPageRoute(builder: (context) => MixScreen(colorTheme: colorTheme, deviceHeight: deviceHeight, deviceWidth: deviceWidth,)));
                }
              },
            );
  }
}