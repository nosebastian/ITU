import 'dart:async';
import 'package:flutter/cupertino.dart';

import 'Task.dart';



class TaskList {
  String _name;
  Color _color;
  List<Task> _taskList;

  set name(String name){
    this._name = name;
  }
  set color(Color color){
    this._color = color;
  }
  set askList(List<Task> taskList){
    this._taskList = taskList;
  }
  String get name => this._name;
  Color get color => this._color;
  List<Task> get taskList => this._taskList; 

}