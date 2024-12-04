
import 'package:cloud_firestore/cloud_firestore.dart';

class FbMensaje {

  String sTitulo;
  String sCuerpo;
  String sImgUrl;
  String sUidAutor;
  Timestamp tmCreacion;
  bool blRTL=false;

  FbMensaje({
     this.sTitulo="",
     this.sCuerpo="",
     this.sImgUrl="",
    this.sUidAutor="",
    required this.tmCreacion
  });

  factory FbMensaje.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();
    return FbMensaje(
      sTitulo: data?['sTitulo'] != null ? data!['sTitulo']:"",
      sCuerpo: data?['sCuerpo']!= null ? data!['sCuerpo']:"",
      sImgUrl: data?['sImgUrl']!= null ? data!['sImgUrl']:"",
      sUidAutor: data?['sUidAutor']!= null ? data!['sUidAutor']:"",
      tmCreacion:data?['tmCreacion']!= null ? data!['tmCreacion']:Timestamp.now(),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sTitulo": sTitulo,
      "sCuerpo": sCuerpo,
      "sImgUrl": sImgUrl,
      "sUidAutor":sUidAutor,
      "tmCreacion":tmCreacion,

    };
  }
}
