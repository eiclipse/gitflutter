import 'package:flutter/cupertino.dart';

class MainAcitivityProvider with ChangeNotifier{
  String _papagoResult = "";
  String _papagoBeforeText = "";

  String get papagoResult => _papagoResult;

  set papagoResult(String value) {
    _papagoResult = value;
    notifyListeners();
  }

  String get papagoBeforeText => _papagoBeforeText;

  set papagoBeforeText(String value) {
    _papagoBeforeText = value;
    notifyListeners();
  }
}