import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:video_app/providers/countdown_provider.dart';
import 'package:video_app/providers/countup_provider.dart';
import 'package:video_app/providers/tabata_provider.dart';
import 'package:video_app/providers/theme.dart';
import 'package:video_app/screens/home_screen.dart';

main() {
  runApp(const MyApp());

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CountDownProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => CountupProvider()),
        ChangeNotifierProvider(create: (_) => TabataProvider()),
      ],
        builder: (context, child) {
          final provider = Provider.of<ThemeProvider>(context);
          return MaterialApp(
            theme: provider.theme,
            debugShowCheckedModeBanner: false,
            home: const MyHomePage(),
          );
        },
    );
  }
}