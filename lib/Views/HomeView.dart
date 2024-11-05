import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomeView extends StatefulWidget{
  const HomeView({super.key});


  /*@override
  State<HomeView> createState() => _HomeViewPageState();*/

  @override
  State<HomeView> createState(){
    return _HomeViewPageState();
  }

}

class _HomeViewPageState extends State<HomeView>{

  int iContador=0;
  bool blVisible=true;

  void clickDelBotonDeIcono(){
    setState(() {
      iContador++;
      blVisible=!blVisible;
    });
    print("VALOR DEL CONTADOR $iContador");

  }

  Widget pitadoComoJava(){
    Text miTexto=const Text("HOLA MUNDO");
    Text miTexto1=const Text("SOY YONY");
    Text miTexto2=const Text("BIENVENIDO");

    TextButton btn1=TextButton(onPressed: (){}, child: const Text("Btn1"));
    TextButton btn2=TextButton(onPressed: (){}, child: const Text("Btn2"));

    Row fila=Row(mainAxisAlignment: MainAxisAlignment.center, children: [btn1,btn2]);

    Column columna=Column(children: [miTexto,miTexto1,miTexto2,fila],);

    return columna;
  }

  Widget pintadoComoFlutter(BuildContext context){


    return Scaffold(
      appBar: AppBar(title: const Text("MI PRIMERA APP"),backgroundColor: Colors.amber,),
      body: Column(
        children: [
          blVisible ? const Text("Hola Mundo"):const Text("Hastaluego Mundo"),
          if(blVisible)const Text("Soy Yony"),
          if(blVisible)const Text("Bienvenido"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: (){

              }, child: const Text("Btn1")),
              TextButton(onPressed: (){}, child: const Text("Btn2")),
              IconButton(
                  icon: const FaIcon(FontAwesomeIcons.gamepad),
                  onPressed: clickDelBotonDeIcono
              ),
            ],
          ),
          const Text("CONTADOR DE CLICKS",style: TextStyle(fontSize: 30,color: Colors.pink),),
          Text("C:$iContador",style: const TextStyle(fontSize: 30,color: Colors.pink),),
        ],
      ),
      floatingActionButton: IconButton(onPressed: (){
        //Navigator.of(context).popAndPushNamed("/mainview");
        Navigator.of(context).pushNamed("/mainview");
      }, icon: const FaIcon(FontAwesomeIcons.airbnb)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pintadoComoFlutter(context);
  }


}