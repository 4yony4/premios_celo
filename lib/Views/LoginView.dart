import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:premios_celo/CustomViews/IGButton.dart';
import 'package:premios_celo/FbObjects/FbPerfil.dart';
import 'package:premios_celo/Singletone/DataHolder.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController tecUser = TextEditingController();
  TextEditingController tecPass = TextEditingController();
  final db = FirebaseFirestore.instance;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //if(FirebaseAuth.instance.currentUser!=null){
    //  Navigator.of(context).pushNamed("/userform");
    //}

  }


  void clickSobreLogin() async {
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: tecUser.text, password: tecPass.text);

      final ref = db.collection("Perfiles").doc(FirebaseAuth.instance.currentUser!.uid).
    withConverter(
          fromFirestore: FbPerfil.fromFirestore,
          toFirestore: (FbPerfil perfil, _) => perfil.toFirestore());
      final docSnap = await ref.get();
      DataHolder().miPerfil = docSnap.data(); // Convert to City object

      if (DataHolder().miPerfil != null) {
        Navigator.of(context).pushNamed("/homeview");
      } else {
        Navigator.of(context).pushNamed("/userform");
      }

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  void clickRegistrar(){
    Navigator.of(context).pushNamed("/registerview");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRT1HMr_znxlBHJXzENZfRS7dXMlQgVVzhzJQ&s'), // Replace with your image URL
            fit: BoxFit.fitHeight, // Adjusts how the image fits the container
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("LOGIN PREMIOS CELO"),
            TextFormField(
              onChanged: (String valor){

              },
              controller: tecUser,
              decoration: const InputDecoration(
                labelText: 'Enter your username', // Hint
                border: OutlineInputBorder(),
              ),
            ),
            TextFormField(
              controller: tecPass,
              decoration: const InputDecoration(
                labelText: 'Enter your password', // Hint
                border: OutlineInputBorder(),
              ),
              obscureText: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IGButton(sTexto: "Login", onIGPressed: clickSobreLogin, sUrlImg: "https://media.tenor.com/2roX3uxz_68AAAAM/cat-space.gif",),
                IGButton(sTexto: "Registrar", onIGPressed: clickRegistrar, sUrlImg: "https://media.tenor.com/2roX3uxz_68AAAAM/cat-space.gif",)
                /*IconButton(
                  icon: const FaIcon(Icons.check), onPressed: clickSobreLogin),
              IconButton(icon: const FaIcon(Icons.app_registration), onPressed: clickRegistrar)
               */
              ],
            )
          ],
        ),
      )
    );
  }
}
