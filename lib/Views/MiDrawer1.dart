import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MiDrawer1 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            child:Image.network("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT1HMr_znxlBHJXzENZfRS7dXMlQgVVzhzJQ&s"),
          ),

          Divider(thickness: 3, color: Colors.pink,),
          Text("Nombre"),
          Text("Apellidos"),
          Divider(thickness: 3, color: Colors.pink,),
          TextButton(onPressed: (){}, child: Text("BTN1")),
          TextButton(onPressed: (){}, child: Text("BTN2")),
          TextButton(onPressed: (){}, child: Text("BTN3")),
        ],
      ),
    );
  }
}