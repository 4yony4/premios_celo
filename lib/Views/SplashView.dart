import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {

  double dbPorcentaje=0.0;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    loading();
  }

  void loading() async{



    while (dbPorcentaje <= 1.0) {
      //print('Valor actual: $dbPorcentaje');
      setState(() {
        dbPorcentaje += 0.05;
      });
      await Future.delayed(Duration(seconds: 1));  // Pausa entre incrementos
    }
    Navigator.of(context).pushNamed("/homeview");
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("PREMIOS CELOS 2024-2025"),
        LinearProgressIndicator(value: dbPorcentaje,),
        Text("${(dbPorcentaje*100).toInt()}%"),
        const CircularProgressIndicator()
      ],
    );
  }
}

