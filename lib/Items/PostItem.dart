import 'package:flutter/cupertino.dart';

class PostItem extends StatelessWidget{

  final String sTitulo;
  final String sBody;
  final String sUrlImg;

  const PostItem({super.key, required this.sTitulo, required this.sBody, required this.sUrlImg});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFD2A621),
      child: Row(
        children: [
          Image.network(sUrlImg,width: 100,height: 100,),
          Column(
            children: [
              Text(sTitulo),
              Text(sBody),
            ],
          )
        ],
      ),
    );
  }
}