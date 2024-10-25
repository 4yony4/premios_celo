
import 'package:premios_celo/Views/SplashView.dart';
import 'package:flutter/material.dart';

import '../Views/HomeView.dart';
import '../Views/MainView.dart';

class MyApp extends StatelessWidget{
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {


    Map<String,Widget Function(BuildContext)> rutas = {
      '/splashview':(context) => SplashView(),
      '/homeview':(context) => const HomeView(),
      '/mainview':(context) => const MainView(),
    };


    MaterialApp app=MaterialApp(
      title: "MI Primera App",
      routes: rutas,
      initialRoute: "/splashview",
      debugShowCheckedModeBanner: true,
    );



    return app;

  }



}