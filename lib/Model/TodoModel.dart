import 'dart:math';

class Todomodel {
  String title;
  String description;
  String date;
  int? id;
  bool iscompletedcheckbox = false;

  Todomodel({
    this.id = 0,
    required this.date,
    required this.description,
    required this.title,
    required this.iscompletedcheckbox,
  });

  Map<String, dynamic> insertTomap() {
    return {
      "date": date,
      "description": description,
      "title": title,
      "iscompletedcheckbox": iscompletedcheckbox ? 1 : 0,
    };
  }

  Map<String, dynamic> updateTomap() {
    return {
      "id": id,
      "date": date,
      "description": description,
      "title": title,
      "iscompletedcheckbox": iscompletedcheckbox ? 1 : 0,
    };
  }
}
