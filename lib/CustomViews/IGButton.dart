import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IGButton extends StatelessWidget{

  String sTexto;
  String sUrlImg;
  double dWidth;
  double dHeight;
  Function() onIGPressed;

  IGButton({super.key,this.sTexto="Boton",this.dWidth=120,
    this.dHeight=40, required this.onIGPressed,
    this.sUrlImg="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT1HMr_znxlBHJXzENZfRS7dXMlQgVVzhzJQ&s"});

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: (){onIGPressed();},
        child:Container(

          color: Colors.amber,
          //width: dWidth,
          height: dHeight,
          child: Row(
            children: [
              Image.network(sUrlImg),
              Text(sTexto)
              //TextButton(onPressed: (){  }, child: Text(sTexto))
              //ElevatedButton(onPressed: (){ onIGPressed(); }, child: Text(sTexto))

            ],
          ),

        ),
      );
  }


}