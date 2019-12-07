import 'package:flutter/material.dart';
import 'package:itu_project/TaskList.dart';
import 'package:itu_project/Widgets/Views/DetailView.dart';
import 'package:itu_project/Widgets/Views/SettingsView.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:table_calendar/table_calendar.dart';
import 'NewTaskView.dart';
import 'package:itu_project/Widgets/Background.dart';
import 'package:flutter_colorpicker/block_picker.dart';
import '../../User.dart';
import '../../Bloc/reload_list_bloc.dart';

String globaNewName = "";
Color globalNewColor = Colors.amber;

class NewTaskListForm extends StatefulWidget {
  @override
  NewTaskListFormState createState() {
    return NewTaskListFormState();
  }
}

class NewTaskListFormState extends State<NewTaskListForm> {
  final _formKey = GlobalKey<FormState>();
  TaskList currentTaskList = new TaskList();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Container(
      padding: EdgeInsets.fromLTRB(30, 0, 30, 0),
      height: MediaQuery.of(context).size.height,
      child: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.fromLTRB(0, 30, 0, 30),
            child: Text(
              "Add new task list",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black,
                fontSize: 25,
              ),
            ),
          ),
          TextField(
            obscureText: false,
            autofocus: false,
            decoration: InputDecoration(
              hasFloatingPlaceholder: false,
              hintText: "Task list name...",
              hintStyle: TextStyle(
                color: Colors.grey.withOpacity(.5)
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.orange, width: 1),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide:
                    BorderSide(color: Colors.grey, width: 1.0),
              ),
            ),
            style: TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
            onChanged: ((value) {
              globaNewName = value;
            }),
          ),
          SizedBox(
            height: 30,
          ),
          PickColorWidget(),
        ],
      ),
    );
  }
}

class PickColorWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PickColorWidgetState();
  }
}

class PickColorWidgetState extends State<PickColorWidget> {
  Color _currentColor = Colors.grey;
  void _changeColor(Color color) {
    setState(() {
      globalNewColor = color;
      _currentColor = color;
    });
  }
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      child: Row(
        children: <Widget>[
          Text(
            "Pick a color",
            textAlign: TextAlign.right,
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.brightness_1,
            color: _currentColor,
            size: 25,
          ),
        ],
      ),
      onTap: (() {
        showDialog(
          context: context,
          builder: ((BuildContext context){
            return AlertDialog(
            title: const Text('Pick a color'),
            content: SingleChildScrollView(
              child: BlockPicker(
                availableColors: <Color>[
                  Colors.amber,
                  Colors.blue,
                  Colors.red,
                  Colors.orange,
                  Colors.green,
                  Colors.pink,
                  Colors.brown,
                ],
                pickerColor: Color(0xffff00),
                onColorChanged: ((color){
                  _currentColor = color;
                  setState(() {
                    _currentColor;
                    print("Currently chosen color is: ");
                    print(_currentColor.toString());
                  });
                }),
              ),
            ),
            actions: <Widget>[
              FlatButton(
                child: const Text('Done'),
                onPressed: () {
                  print("Another little color change");
                   print(_currentColor.toString());
                  setState(() {
                    globalNewColor = _currentColor;
                  });
                  Navigator.of(context).pop();
                  },
                ),
              ],
            );
          }),
        );
      })
    );
  }
}


class NewTaskListView extends StatelessWidget {
  
  @override
  Widget build (BuildContext context) {
    final _size = MediaQuery.of(context).size;
    return new Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(30),
        child: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          stops: [0, 0.01],
          colors: [
            Color.fromRGBO(255, 132, 88, 1),
            Color.fromRGBO(255, 95, 109, 1),
          ],
        ),
      ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              color: Colors.black,
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white60,
              ),
              onPressed: (){
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: 
      Stack(
        children: <Widget>[
                      Positioned(
              child: BackGround(),
            ),
          Positioned
          (
            top: _size.height / 100,
              bottom: 0,
              width: _size.width,
                      child: Container(
                        child: ListView(
              children: <Widget>[
                SizedBox(height: 40,),
                Container(
                  width: _size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25), topRight: Radius.circular(25)
                    ),
                  ),
                  child: NewTaskListForm(),
                ),
              ],
            ),
                      ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if(globaNewName != "")
          {
            TaskList newTaskList = new TaskList();
            newTaskList.name = globaNewName;
            globaNewName = "";
            newTaskList.color = globalNewColor;
            if(loggedUser.taskLists == null)
              loggedUser.taskLists = [newTaskList];
            else
              loggedUser.taskLists.add(newTaskList);
          }
          else
          {
            Alert(
              context: context,
              title: "Name of task list cannot be empty",
              content: WarningDialog(),
              buttons: [
                DialogButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    "Ok",
                    style: TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),
                )
              ]).show();
              return;
          }
          Navigator.pop(context);
        },
        label: Text('New task list'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}