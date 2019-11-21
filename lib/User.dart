import 'dart:async';
import 'Task.dart';

class User{
  String _name;
  List<Task> _todo;
  DateTime _showDate;

  set name(String name){
    this._name = name;
  }

  set todo(List<Task> todo){
    this._todo = todo;
  }

  String get name => this._name;

  set showDate(DateTime showDate){
    this._showDate = showDate;
  }

  DateTime get showDate => this._showDate;

  List<Task> get todo => this._todo;


}

User loggedUser = User();  