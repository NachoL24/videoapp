import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/providers/theme.dart';
import 'package:video_app/widgets/main_screen_button.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ThemeProvider>(context);
    final colorTheme = Theme.of(context).colorScheme;
    final deviceWidth = MediaQuery.of(context).size.width;
    final deviceHeight = MediaQuery.of(context).size.height;
    
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: colorTheme.background,
        leading: const Icon(Icons.menu_outlined),
        actions: [
          IconButton(
            onPressed: () {
              provider.toogleTheme();
            }, 
            icon:
              Icon(provider.theme == ThemeData.dark() ? Icons.dark_mode : Icons.light_mode))
        ],
        centerTitle: false,
      ),
      body: Center(
        child: Column(
          children: [

            SizedBox(height: deviceHeight / 16),
            const Text('Wod Timer', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
            const Text('Recorder', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),

            SizedBox(height: deviceHeight / 8,),

            MainScreenButton(text: 'Amrap', deviceHeight: deviceHeight, deviceWidth: deviceWidth, colorTheme: colorTheme, page: Pages.amrap,),

            SizedBox(height: deviceHeight / 32,),
            
            MainScreenButton(text: 'For Time', deviceHeight: deviceHeight, deviceWidth: deviceWidth, colorTheme: colorTheme, page: Pages.forTime,),

            SizedBox(height: deviceHeight / 32,),
            
            MainScreenButton(text: 'Emom / Tabata', deviceHeight: deviceHeight, deviceWidth: deviceWidth, colorTheme: colorTheme, page: Pages.emom,),

            SizedBox(height: deviceHeight / 32,),
            
            MainScreenButton(text: 'Mix', deviceHeight: deviceHeight, deviceWidth: deviceWidth, colorTheme: colorTheme, page: Pages.mix,),

            //SizedBox(height: deviceHeight / 32,),

          ],
          ),
        ),
      //todo: que empiece seleccionada el navigator de wod timer
      bottomNavigationBar: BottomNavigationBar(
        items: const[
          BottomNavigationBarItem(
              icon: Icon(Icons.history),
              label: 'Registros',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.timer),
              label: 'Wod Timer',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Usuario',
            ),
        ]
      ),

    );
  }
}
