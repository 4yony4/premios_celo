import 'package:flutter/material.dart';

class AuthView extends StatelessWidget{

  Widget sBody;

  AuthView(this.sBody);

  void setBody(Widget sBody){
    this.sBody=sBody;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PRUEBA"),),
      body: sBody,
      bottomNavigationBar: Text("BUTTOM"),
    );
  }

}