
import 'package:cloud_firestore/cloud_firestore.dart';

class FbChat {
  String uid;
  String sTitulo;
  String sDescripcion;
  String sImgUrl;
  String sUidAutor;
  Timestamp tmCreacion;

  FbChat({
    this.uid="",
    this.sTitulo="",
    this.sDescripcion="",
    this.sImgUrl="",
    this.sUidAutor="",
    required this.tmCreacion
  });

  factory FbChat.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,) {
    final data = snapshot.data();
    return FbChat(
      sTitulo: data?['sTitulo'] != null ? data!['sTitulo']:"",
      sDescripcion: data?['sDescripcion']!= null ? data!['sDescripcion']:"",
      sImgUrl: data?['sImgUrl']!= null ? data!['sImgUrl']:"",
      sUidAutor: data?['sUidAutor']!= null ? data!['sUidAutor']:"",
      tmCreacion:data?['tmCreacion']!= null ? data!['tmCreacion']:Timestamp.now(),
      uid: snapshot.id
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sTitulo": sTitulo,
      "sDescripcion": sDescripcion,
      "sImgUrl": sImgUrl,
      "sUidAutor":sUidAutor,
      "tmCreacion":tmCreacion,
    };
  }
}
