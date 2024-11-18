import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:premios_celo/Singletone/DataHolder.dart';
import 'package:premios_celo/Views/LoginView.dart';
import 'package:premios_celo/Views/PostDetails.dart';

import '../CustomViews/IGButton.dart';
import 'MiDrawer1.dart';
import 'PostsView.dart';

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
  bool blListaPostsVisible=true;

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

  void onPostItem_MasDatosClicked(int indicePost){
    DataHolder().fbPostSeleccionado=DataHolder().arPosts[indicePost];
    setState(() {
      blListaPostsVisible=false;
    });
  }

  void onPostDetails_Close(){
    setState(() {
      blListaPostsVisible=true;
    });
  }

  Widget pintadoComoFlutter(BuildContext context){
    return Scaffold(
      appBar: AppBar(title: const Text("PREMIOS CELO"),
        backgroundColor: Colors.amber,
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ],
      ),
      drawer: Drawer(
        child: MiDrawer1(),
      ),
      body:
      Column(
        children: [
          blVisible ? const Text("Hola Mundo"):const Text("Hastaluego Mundo"),
          if(blVisible)Text("Soy"),
          if(blVisible)const Text("Bienvenido"),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IGButton(onIGPressed: (){},),
              TextButton(onPressed: (){}, child: const Text("Btn2")),
              IconButton(
                  icon: const FaIcon(FontAwesomeIcons.gamepad),
                  onPressed: clickDelBotonDeIcono
              ),
            ],
          ),
          const Text("CONTADOR DE CLICKS",style: TextStyle(fontSize: 30,color: Colors.pink),),
          Text("C:$iContador",style: const TextStyle(fontSize: 30,color: Colors.pink),),
          blListaPostsVisible?
            PostsView(onMasDatosClicked: onPostItem_MasDatosClicked,):
            PostDetails(onClose: onPostDetails_Close,),
        ],
      ),
      floatingActionButton: IconButton(onPressed: (){
        //Navigator.of(context).popAndPushNamed("/mainview");
        Navigator.of(context).pushNamed("/mainview");
      }, icon: const FaIcon(FontAwesomeIcons.airbnb)),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: (){}, icon: Icon(Icons.home)),
            IconButton(onPressed: (){}, icon: Icon(Icons.search)),
            IconButton(onPressed: (){}, icon: Icon(Icons.ondemand_video_sharp)),
            IconButton(onPressed: (){}, icon: Icon(Icons.shopping_basket)),
            IconButton(onPressed: (){}, icon: Icon(Icons.settings))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return pintadoComoFlutter(context);
  }


}