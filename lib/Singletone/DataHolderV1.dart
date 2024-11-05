import 'package:flutter/cupertino.dart';

import '../Views/AuthView.dart';

class DataHolderV1 {

  static final DataHolderV1 _dataHolder = DataHolderV1._internal();

  String sNombre="Yony";
  late AuthView authView;

  DataHolderV1._internal() {
    authView=AuthView(Container());
  }

  factory DataHolderV1(){
    return _dataHolder;
  }

}