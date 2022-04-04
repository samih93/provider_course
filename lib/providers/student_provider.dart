import 'package:flutter/cupertino.dart';

class StudentProvider extends ChangeNotifier {
  List<String> _listOfStudent = [];
  List<String> get listOfStudent => _listOfStudent;

  addStudent(String name) {
    _listOfStudent.add(name);
    notifyListeners();
  }
}
