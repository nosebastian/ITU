import 'dart:async';

class Task{
  String _finishAt;
  String _title;
  List<String> _steps;
  String _notes;
  int _priority;
  String _date;
  List<int> _done;
  String _reminder;

  set finishAt(String finishAt){
    this._finishAt = finishAt;
  }

  set title(String title){
    this._title = title;
  }

  set steps(List<String> steps){
    this._steps = steps;
  }

  set notes(String notes){
    this._notes = notes;
  }

  set priority(int priority){
    this._priority = priority;
  }

  set done(List<int> done){
    this._done = done;
  }

  set date(String date){
    this._date = date;
  }

  set reminder(String reminder){
    this._reminder= reminder;
  }

  String get date => this._date;

  String get finishAt => this._finishAt;

  String get title => this._title;

  List<String> get steps => this._steps;

  List<int> get done => this._done;

  String get notes => this._notes;
  
  String get reminder => this._reminder;

  int get priority => this._priority;
}

Task currentTask = Task();

