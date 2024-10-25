
import 'package:premios_celo/Views/LoginView.dart';
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
      '/loginview':(context) =>  LoginView(),
    };


    MaterialApp app=MaterialApp(
      title: "Premios Celo",
      routes: rutas,
      initialRoute: "/loginview",
      debugShowCheckedModeBanner: true,
    );



    return app;

  }



}