import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:premios_celo/FbObjects/FbChat.dart';
import 'package:premios_celo/FbObjects/FbPost.dart';

import '../FbObjects/FbPerfil.dart';

class DataHolder{

  static final DataHolder _instance = DataHolder._internal();

  String sRutaChats="/chats";
  FbPerfil? miPerfil;
  FbPost? fbPostSeleccionado;
  List<FbPost> arPosts=[];

  FbChat? fbChatSelected;

  DataHolder._internal();

  factory DataHolder(){
    return _instance;
  }


  Future<List<FbPost>> descargarTodosPosts(bool blDescargaUnica) async{
    if(blDescargaUnica==true && arPosts.isNotEmpty) return arPosts;
    arPosts.clear();
    var db = FirebaseFirestore.instance;

    final ref = db.collection("Posts").withConverter(
      fromFirestore: FbPost.fromFirestore,
      toFirestore: (FbPost post, _) => post.toFirestore(),
    );
    final querySnap = await ref.get();
    //for(int i=0;i<querySnap.docs.length;i++){

    //}

    for(QueryDocumentSnapshot<FbPost> doc in querySnap.docs){
      arPosts.add(doc.data());
    }

    return arPosts;
  }

  Future<List<FbChat>> descargarTodosChats() async{
    List<FbChat> arTemp=[];
    var db = FirebaseFirestore.instance;

    final ref = db.collection(sRutaChats).withConverter(
      fromFirestore: FbChat.fromFirestore,
      toFirestore: (FbChat post, _) => post.toFirestore(),
    );
    final querySnap = await ref.get();

    for(QueryDocumentSnapshot<FbChat> doc in querySnap.docs){
      arTemp.add(doc.data());
    }

    return arTemp;
  }

}