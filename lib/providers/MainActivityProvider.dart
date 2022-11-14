import 'package:flutter/cupertino.dart';

import '../dao/MessagesDAO.dart';
import '../dto/MessagesDTO.dart';

class MainAcitivityProvider with ChangeNotifier{
  // Papago related
  String _papagoResult = "";
  String _papagoBeforeText = "";

  // DB_List hidden checkbox related
  bool _deleteMode = false;

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

  bool get deleteMode => _deleteMode;

  set deleteMode(bool value) {
    _deleteMode = value;
    notifyListeners();
  }
}