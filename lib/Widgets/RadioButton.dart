// Lukáš Schmelcer (xschme00)

import 'package:flutter/material.dart';
import 'package:itu_project/Task.dart';
import 'package:itu_project/User.dart';
import './Views/NewTaskView.dart';

class RadioButton extends StatefulWidget {
    RadioButton({
    int index,
    int indexOfNote,
  }) : index = index, indexOfNote = indexOfNote;


  final int index;
  final int indexOfNote;
  @override

  RadioButtonState createState() {
    return new RadioButtonState();
  }
}

class RadioButtonState extends State<RadioButton> {


  @override
  Widget build(BuildContext context) {
  bool isChecked = loggedUser.todo[widget.indexOfNote].done[widget.index] == 1 ? true : false;
    return Checkbox(
      activeColor: Colors.white,
  
  value: isChecked,
  onChanged: (value) {
    setState(() {
      isChecked = value;
      int i = isChecked ? 1 : 0;
      loggedUser.todo[widget.indexOfNote].done[widget.index] = i;

    });
  },
);
  }
}


// Radios for importance choose 

class RadioButtonImportance extends StatefulWidget {
    RadioButtonImportance({
    int index,
  }) : index = index;


  final int index;
  @override

  RadioButtonImportanceState createState() {
    return new RadioButtonImportanceState();
  }
}

class RadioButtonImportanceState extends State<RadioButtonImportance> {


  @override
  Widget build(BuildContext context) {
  bool isChecked = loggedUser.showOnly[widget.index] == 1 ? true : false;
    return Checkbox(
      activeColor: Colors.deepOrange,
  
  value: isChecked,
  onChanged: (value) {
    setState(() {
      isChecked = value;
      int i = isChecked ? 1 : 0;
      loggedUser.showOnly[widget.index] = i;

    });
  },
);
  }
}



class RadioButtonPriority extends StatefulWidget {
    RadioButtonPriority({
    int index,
  }) : index = index;


  final int index;
  @override

  RadioButtonPriorityState createState() {
    return new RadioButtonPriorityState();
  }
}

class RadioButtonPriorityState extends State<RadioButtonPriority> {


  @override
  Widget build(BuildContext context) {
  bool isChecked = currentTask.priority == 1 ? true : false;
    return Checkbox(
      activeColor: Colors.deepOrange,
  
  value: isChecked,
  onChanged: (value) {
    setState(() {
      isChecked = value;
      int i = isChecked ? 1 : 0;
      currentTask.priority = i;
    });
  },
);
  }
}
