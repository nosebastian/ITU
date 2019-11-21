import 'package:flutter/material.dart';
import 'package:itu_project/User.dart';

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
