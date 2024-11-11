import '../FbObjects/FbPerfil.dart';

class DataHolder{

  static final DataHolder _instance = DataHolder._internal();


  FbPerfil? miPerfil;

  DataHolder._internal();

  factory DataHolder(){
    return _instance;
  }

  void printTest(){
    print("HEYHEY");
  }

}