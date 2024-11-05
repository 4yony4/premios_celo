
import 'package:premios_celo/Singletone/DataHolderV1.dart';
import 'package:premios_celo/Views/LoginView.dart';
import 'package:premios_celo/Views/RegisterView.dart';
import 'package:premios_celo/Views/SplashView.dart';
import 'package:flutter/material.dart';
import 'package:premios_celo/Views/UserForm.dart';

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
      '/registerview':(context) =>  RegisterView(),
      '/userform':(context) =>  UserForm(),
    };


/*
    Map<String,Widget Function(BuildContext)> rutas = {
      '/splashview':(context) {
          DataHolder().authView.setBody(SplashView());
          return DataHolder().authView;
        } ,
      '/homeview':(context) {
        DataHolder().authView.setBody(HomeView());
        return DataHolder().authView;
      },
      '/mainview':(context) => const MainView(),
      '/loginview':(context) =>  LoginView(),
    };
*/

    MaterialApp app=MaterialApp(
      title: "Premios Celo",
      routes: rutas,
      initialRoute: "/userform",
      debugShowCheckedModeBanner: true,
    );



    return app;

  }



}