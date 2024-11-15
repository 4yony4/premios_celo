import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostItem extends StatelessWidget{

  final String sTitulo;
  final String sBody;
  final String sUrlImg;
  final int iIndice;
  final Function(int i) onMasDatosClicked;

  const PostItem({super.key,
    required this.sTitulo,
    required this.sBody,
    required this.sUrlImg,
    required this.iIndice,
    required this.onMasDatosClicked
  });

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        child: Container(
          color: const Color(0xFFD2A621),
          child: Row(
            children: [
              Image.network(sUrlImg,width: 100,height: 100,),
              Column(
                children: [
                  Text(sTitulo),
                  Text(sBody),
                ],
              ),
              IconButton(onPressed: (){
                onMasDatosClicked(iIndice);
              }, icon: Icon(Icons.read_more))
            ],
          ),
        ),
        onTap: (){
          onMasDatosClicked(iIndice);
        },
      );
  }
}