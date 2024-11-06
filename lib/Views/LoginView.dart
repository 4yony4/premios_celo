import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatefulWidget {
  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController tecUser = TextEditingController();
  TextEditingController tecPass = TextEditingController();

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
      Navigator.of(context).pushNamed("/userform");
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("LOGIN PREMIOS CELO"),
          TextFormField(
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
              IconButton(
                  icon: const FaIcon(Icons.check), onPressed: clickSobreLogin),
              IconButton(icon: const FaIcon(Icons.app_registration), onPressed: clickRegistrar)
            ],
          )
        ],
      ),
    );
  }
}
