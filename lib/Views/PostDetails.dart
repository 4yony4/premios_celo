import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:premios_celo/Singletone/DataHolder.dart';
import 'package:premios_celo/Views/HomeView.dart';

class PostDetails extends StatelessWidget{

  final Function() onClose;

  PostDetails({super.key,required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        child: Center(
          child: Column(
            children: [
              IconButton(onPressed: (){
                //homeView.onPostDetails_Close();
                onClose();

              }, icon: Icon(Icons.close)),
              Image.network(DataHolder().fbPostSeleccionado!.sImgUrl),
              Text(DataHolder().fbPostSeleccionado!.sTitulo)
            ],
          ),
        ),
      )
    );
  }
}