import 'package:flutter/material.dart';
import 'package:premios_celo/FbObjects/FbChat.dart';
import 'package:premios_celo/Singletone/DataHolder.dart';

class SelectForosView extends StatefulWidget{

  @override
  State<SelectForosView> createState() => _SelectForosViewState();
}

class _SelectForosViewState extends State<SelectForosView> {
  List<FbChat> arChats=[];



  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    loadData();


  }

  void loadData() async{
    List<FbChat> arTemp=await DataHolder().descargarTodosChats();
    setState(() {
      arChats.clear();
      arChats.addAll(arTemp);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("LISTA DE FOROS"),),

        body:
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 100),
          child:
              SizedBox(
                height: 450,
                child: ListView.builder(itemBuilder: chatItemBuilder,itemCount: arChats.length,),
              ),
        )
    );

  }

  Widget? chatItemBuilder(BuildContext contexto, int indice){
    return
    GestureDetector(
      onTap: (){
       DataHolder().fbChatSelected= arChats[indice];
       Navigator.of(contexto).pushNamed('/foroview');
      },
      child:Container(
        width: 250,
        child: Row(
          children: [
            Text("${arChats[indice].sTitulo}",maxLines: 3,),
          ],
        ),
      ),
    );
    //return Text("${arFbMensajes[indice].sCuerpo}");
  }
}