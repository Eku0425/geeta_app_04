import 'package:flutter/material.dart';
import 'package:geeta_app_04/provider/detail.dart';
import 'package:geeta_app_04/provider/geeta_provider.dart';
import 'package:geeta_app_04/screen/home_page.dart';
import 'package:geeta_app_04/screen/splash_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Geetaprovider()),
        ChangeNotifierProvider(create: (context) => DetailProvider()),
      ],
      builder: (context, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            brightness: Brightness.light,
            colorScheme: ColorScheme.light(
              primary: Colors.white,
            )),
        darkTheme: ThemeData(
            brightness: Brightness.dark,
            colorScheme: ColorScheme.dark(
              primary: Colors.white,
            )),
        themeMode: Provider.of<Geetaprovider>(context).isDark
            ? ThemeMode.dark
            : ThemeMode.light,
        home: SplashScreen(),
      ),
    );
  }
}
