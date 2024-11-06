
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

//import 'package:image_picker_web/image_picker_web.dart';

class UserForm extends StatefulWidget {
  @override
  _UserFormState createState() => _UserFormState();
}

class _UserFormState extends State<UserForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _nicknameController = TextEditingController();
  final storage = FirebaseStorage.instance;
  final db = FirebaseFirestore.instance;

  bool blUploading=false;

  dynamic _avatar;

  //File? _avatar;

  /*
  Future<void> _pickAvatar() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        _avatar = File(pickedImage.path);
      });
    }
  }
*/

  Future<void> _pickAvatar() async {
    if (kIsWeb) {
      // Usa ImagePickerWeb en la web
      /*final image = await ImagePickerWeb.getImageAsBytes();
      if (image != null) {
        setState(() {
          _avatar = image;
        });
      }*/
    } else {
      // Usa ImagePicker en plataformas móviles
      final picker = ImagePicker();
      final pickedImage = await picker.pickImage(source: ImageSource.camera);
      if (pickedImage != null) {
        setState(() {
          _avatar = File(pickedImage.path);
        });
      }
    }
  }

  void _submitForm() async{
    if (_formKey.currentState!.validate()) {
      setState(() {
        blUploading=true;
      });
      String uidUsuario=FirebaseAuth.instance.currentUser!.uid;

      String urlImg=await subirImagen(uidUsuario);
      Map<String,dynamic> datosPerfil={
        "nombre":_nameController.text,
        "edad":_ageController.text,
        "apodo":_nicknameController.text,
        "imagenURL":urlImg
      };

      db.collection("Perfiles").doc(uidUsuario).set(datosPerfil);

      setState(() {
        blUploading=false;
      });

    }
  }

  Future<String> subirImagen(String userID) async{
    String sUrlDeImagen="";

    final storageRef=storage.ref();
    final avatarImageRef = storageRef.child("images/users/$userID/avatar.jpg");
    if (kIsWeb) {
      try {
        // Upload raw data.
        await avatarImageRef.putData(_avatar);
      } on Exception catch (e) {
        print("--------->>>>>>>>>>> ${e}");
        // ...
      }
    }
    else{
      try {
        
        await avatarImageRef.putFile(_avatar);
        sUrlDeImagen=await avatarImageRef.getDownloadURL();
      } on Exception catch (e) {
        print("--------->>>>>>>>>>> ${e}");
      }
    }

    return sUrlDeImagen;

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Form')),
      body: blUploading?
      const Center(child:CircularProgressIndicator()):
      SingleChildScrollView(
            child:  Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: _pickAvatar,
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: _avatar != null
                            ? (kIsWeb
                            ? MemoryImage(_avatar)
                            : FileImage(_avatar) as ImageProvider)
                            : null,
                        child: _avatar == null
                            ? Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                            : null,
                      ),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: _nameController,
                      decoration: InputDecoration(labelText: 'Name'),
                      validator: (value) {
                        return value!.isEmpty ? 'Please enter your name' : null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _ageController,
                      decoration: InputDecoration(labelText: 'Age',errorStyle: TextStyle(color: Colors.yellow)),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value!.isEmpty) return 'Please enter your age';
                        final age = int.tryParse(value);
                        if (age == null || age <= 0) return 'Enter a valid age';

                        return null;
                      },
                    ),
                    SizedBox(height: 10),
                    TextFormField(
                      controller: _nicknameController,
                      decoration: InputDecoration(labelText: 'Nickname'),
                      validator: (value) =>
                      value!.isEmpty ? 'Please enter a nickname' : null,
                    ),
                    SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: Text('Submit'),
                    ),
                  ],
                ),
              ),
            ),
          )
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _nicknameController.dispose();
    super.dispose();
  }
}
