import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  String _name = "welcome";
  String _lastname = "welcome";
  int _age = 22;
  int get age => _age;

  String get name => _name;
  String get lastname => _lastname;

  changeName() {
    _name = "samih";
    notifyListeners();
  }

  changelastname() {
    _lastname = "damaj";
    notifyListeners();
  }

  changeAge() {
    _age = 25;
    notifyListeners();
  }
}
