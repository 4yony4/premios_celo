import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:premios_celo/Singletone/DataHolder.dart';

import '../FbObjects/FbMensaje.dart';

class ForoView extends StatefulWidget{

  @override
  State<ForoView> createState() => _ForoViewState();
}

class _ForoViewState extends State<ForoView> {
  List<FbMensaje> arFbMensajes=[];
  TextEditingController controller = TextEditingController();
  TextEditingController imgcontroller = TextEditingController();
  var db = FirebaseFirestore.instance;
  String sRutaChatMensajes="/chats/ugfAOewB7MHzgmLPyNPY/mensajes";

  @override
  void initState() {
    // TODO: implement initState
    sRutaChatMensajes="/chats/"+DataHolder().fbChatSelected!.uid+"/mensajes";
    descargarTodosMensajes();
  }


  Future<void> descargarTodosMensajes() async{
    List<FbMensaje> arTemp=[];
    arTemp.clear();


    final ref = db.collection(sRutaChatMensajes)
        .orderBy("tmCreacion",descending: true)
        //.limit(30)
        .withConverter(
      fromFirestore: FbMensaje.fromFirestore,
      toFirestore: (FbMensaje post, _) => post.toFirestore(),
    );
    //final querySnap = await ref.get();

    ref.snapshots().listen((event) {
      arTemp.clear();
      for (var doc in event.docs) {
        arTemp.add(doc.data());
      }

      arTemp.sort(compararArray);

      setState(() {
        arFbMensajes.clear();
        arFbMensajes.addAll(arTemp);
      });
    });


  }

  int compararArray(FbMensaje a, FbMensaje b){
    return b.tmCreacion.compareTo(a.tmCreacion);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("FORO PREMIOS CELO"),),

      body:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                SizedBox(
                  height: 450,
                  child: ListView.builder(itemBuilder: mensajeBuilder,itemCount: arFbMensajes.length,),
                ),
                Container(
                  width: 200,
                  color: Colors.cyanAccent,
                  child: TextField(controller: imgcontroller,),
                ),
                Row(children: [
                  Container(
                    width: 200,
                    color: Colors.tealAccent,
                    child: TextField(controller: controller,),
                  ),
                  IconButton(onPressed: presionarEnvio, icon: Icon(Icons.send))
                ],),
              ],
            ),
          )


    );
  }

  Widget? mensajeBuilder(BuildContext contexto, int indice){
    return
    Container(
      width: 250,
      child: Row(
        children: [
          Text("${arFbMensajes[indice].sCuerpo}",maxLines: 3,),
          if(arFbMensajes[indice].sImgUrl.isNotEmpty)Image.network(arFbMensajes[indice].sImgUrl)
        ],
      ),
    );
    //return Text("${arFbMensajes[indice].sCuerpo}");
  }

  void presionarEnvio() async{
    FbMensaje nuevoMensaje=FbMensaje(
        sCuerpo: controller.text,
        tmCreacion:Timestamp.now(),
        sImgUrl: imgcontroller.text
        //sUidAutor: FirebaseAuth.instance.currentUser!.uid
    );
    var nuevoDoc=await db.collection(sRutaChatMensajes).add(nuevoMensaje.toFirestore());

  }
}