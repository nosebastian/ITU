import 'dart:async';
import 'Task.dart';

class User{
  String _name;
  List<Task> _todo;
  List<Task> _todaysTasks;
  DateTime _showDate;
  List<int> _showOnly;

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

  List<Task> get todaysTasks => this._todaysTasks;

  set todaysTasks(List<Task> todaysTasks){
    this._todaysTasks = todaysTasks;
  }

  set showOnly(List<int> showOnly){
    this._showOnly = showOnly;
  }

  List<int> get showOnly => this._showOnly;

  DateTime get showDate => this._showDate;

  List<Task> get todo => this._todo;


}

User loggedUser = User();  

