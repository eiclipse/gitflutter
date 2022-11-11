

class MessagesDTO{
  int _seq;
  String _writer;
  String _message;
  DateTime _write_date;

  MessagesDTO(this._seq, this._writer, this._message, this._write_date);
  factory MessagesDTO.fromDatabaseJson(Map<String,dynamic> data) => MessagesDTO(
      data['seq'],
      data['writer'],
      data['message'],
      DateTime.fromMillisecondsSinceEpoch(data['write_date'] as int)
  );

  DateTime get write_date => _write_date;

  set write_date(DateTime value) {
    _write_date = value;
  }

  String get message => _message;

  set message(String value) {
    _message = value;
  }

  String get writer => _writer;

  set writer(String value) {
    _writer = value;
  }

  int get seq => _seq;

  set seq(int value) {
    _seq = value;
  }

  Map<String,dynamic> toMap(){
    final map = {
      'writer':writer,
      'message':message
    };

    return map;
  }


}