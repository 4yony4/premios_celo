import 'package:cloud_firestore/cloud_firestore.dart';

class FbPost {

  String sTitulo;
  String sCuerpo;
  String sImgUrl;

  FbPost({
    required this.sTitulo,
    required this.sCuerpo,
    required this.sImgUrl,
  });

  factory FbPost.fromFirestore(
      DocumentSnapshot<Map<String, dynamic>> snapshot,
      SnapshotOptions? options,
      ) {
    final data = snapshot.data();
    return FbPost(
      sTitulo: data?['sTitulo'] ,
      sCuerpo: data?['sCuerpo'],
      sImgUrl: data?['sImgUrl'],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      "sTitulo": sTitulo,
      "sCuerpo": sCuerpo,
      "sImgUrl": sImgUrl,
    };
  }
}