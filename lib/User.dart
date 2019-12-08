// Lukáš Schmelcer(xschme00)
// Adam Feranec(xferan00)
// Marek Vaško(xvasko16)

import 'dart:async';
import 'package:itu_project/TaskList.dart';

import 'Task.dart';

class User{
  String _name;
  List<Task> _todo;
  List<Task> _todaysTasks;
  DateTime _showDate;
  List<int> _showOnly;
  List<TaskList> _taskLists;

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

  List<Task> get todaysTasks {
    List<Task> returnList = this._todaysTasks;
    return returnList;
  }

  set todaysTasks(List<Task> todaysTasks){
    this._todaysTasks = todaysTasks;
  }

  set showOnly(List<int> showOnly){
    this._showOnly = showOnly;
  }

  set taskLists(List<TaskList> taskLists) {
    this._taskLists = taskLists;
  }

  List<int> get showOnly => this._showOnly;

  DateTime get showDate => this._showDate;

  List<Task> get todo => this._todo;

  List<TaskList> get taskLists => this._taskLists;
}

User loggedUser = User();  

