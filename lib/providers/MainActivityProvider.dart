import 'package:flutter/cupertino.dart';
import 'package:gitpractice01/ui/main/TabViewFactory.dart';

import '../dao/MessagesDAO.dart';
import '../dto/MessagesDTO.dart';

class MainAcitivityProvider with ChangeNotifier{
  // Papago related
  String _papagoResult = "";
  String _papagoBeforeText = "";

  // DB_List hidden checkbox related
  bool _deleteMode = false;
  Future<List<MessagesDTO>> _messages = MessagesDAO.db.list();

  Future<List<MessagesDTO>> get messages => _messages;
  set messages(Future<List<MessagesDTO>> value) {
    _messages = value;
  }

  void insert(writer, message){
    MessagesDAO.db.insert(MessagesDTO(0,writer,message,DateTime.now()));
    this.messages = MessagesDAO.db.list();
    //notifyListeners();
  }

  void isCheckedRefresh(MessagesDTO dto) {
    dto.isChecked = !dto.isChecked;
    notifyListeners();
  }
  
  void removeAll(List<int> list){
    MessagesDAO.db.delete(list);
    this.messages = MessagesDAO.db.list();
    //notifyListeners();
  }



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

  void deleteBySeq(List<int> delete_list) {
    MessagesDAO.db.delete(delete_list);
    notifyListeners();
  }

  void setAllIsChecked(bool bool) {
    this.messages.then((list){
      list.forEach((e) {
        e.isChecked=bool;
      });
    });
  }




}