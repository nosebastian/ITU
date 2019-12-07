import 'package:flutter/material.dart';
import 'package:itu_project/Task.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:itu_project/Widgets/Background.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../RadioButton.dart';
import '../../User.dart';

String globaNewNote = "";
String globalNewSteps = "";
String globalNewStep = "";
String globalNewReminder = "";
int globalPickedGroupIndex = -1;

class NewTaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
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
                color: Colors.white60
              ),
              onPressed: (){
                currentTask = Task();
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: BackGround(),
            ),
            Positioned(
              top: size.height / 11,
              bottom: 0,
              width: size.width,
              child: ListBackGround(
                size: size,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          if (currentTask.title == null){
            Alert(
              context: context,
              title: "Title of task can not be empty",
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
              ]
            ).show();
            return;
          }
          currentTask.notes = globaNewNote;
          currentTask.done = List.filled(currentTask.steps == null ? 0 : currentTask.steps.length, 0);
          if (loggedUser.todo == null) {
            List<Task> firstTask = [currentTask];
            loggedUser.todo = firstTask;
          } else {
            loggedUser.todo.add(currentTask);
          }
          globalNewReminder = "";
          globalNewStep = "";
          globalNewSteps = "";
          if(currentTask.date == null) currentTask.date = DateTime.now().toString();
          if(currentTask.finishAt == null){
            currentTask.finishAt = currentTask.date.replaceRange(11, 15, "24:00");
            
          }
          currentTask = Task();

          Navigator.pop(context);
        },
        label: Text('Save this task'),
        icon: Icon(Icons.done),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class ListBackGround extends StatelessWidget {
  ListBackGround({
    Key key,
    Size size,
  })  : _size = size,
        super(key: key);
  final Size _size;

  @override
  Widget build(BuildContext context) {
    return Container(
      
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
        child: Container(
          
          child: ListView(
            children: <Widget>[
              Container(
                  width: _size.width,
                  child: Container(
                    height: _size.height/1.25,
                    child: ListView(
                      children: <Widget>[
                        Container(
                          alignment: Alignment.center,
                          child: Text(
                            "New Task",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 30,
                                fontWeight: FontWeight.w500),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(30, 30, 35, 20),
                          child: TextField(
                            obscureText: false,
                            autofocus: false,
                            decoration: InputDecoration(
                              hasFloatingPlaceholder: false,
                              hintText: "Task title...",
                              hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.5)),
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
                                fontSize: 18, fontWeight: FontWeight.bold),
                            onChanged: ((value) {
                              currentTask.title = value;
                            }),
                          ),
                        ),
                        Calendar(),
                        SizedBox(
                          height: 20,
                        ),
                        CustomTimePicker(),
                        GestureDetector(
                            onTap: () {
                              Alert(
                                  context: context,
                                  title: "Steps",
                                  content: StepsDialog(),
                                  buttons: [
                                    DialogButton(
                                      color: Colors.deepOrangeAccent,
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        "Save this step",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                "Steps to complete +",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        Container(
                          padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                          height: 100,
                          child: Steps(),
                        ),
                        GestureDetector(
                            onTap: () {
                              Alert(
                                  context: context,
                                  title: "Notes",
                                  content: NoteDialog(),
                                  buttons: [
                                    DialogButton(
                                      color: Colors.deepOrangeAccent,
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        "Save this note",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                            },
                            child: Container(
                              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                              child: Text(
                                "Notes:",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 25,
                                    fontWeight: FontWeight.w500),
                              ),
                            )),
                        Container(
                          // A fixed-height child.
                          child: Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Text(
                                globaNewNote,
                                style: TextStyle(fontSize: 20),
                              )),
                        ),
                       
                        ShowReminder(),
                        ShowPriority(),
                        TaskListPickerWidget(),
                        SizedBox(height: 100,),
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

class Steps extends StatefulWidget {
  @override
  _StepsState createState() => _StepsState();
}

class _StepsState extends State<Steps> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(

        primary: false,
                              itemCount: currentTask.steps == null
                                  ? 0
                                  : currentTask.steps.length,
                              itemBuilder: (BuildContext ctxt, int index) {
                                return Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    children: <Widget>[
                                      GestureDetector(
                                        onTap: (){
                                          currentTask.steps.removeAt(index);
                                          setState(() {
                                            
                                          });
                                        },
                                        child: Icon(Icons.delete_outline),
                                      ),
                                      new Text(
                                        "- " + currentTask.steps[index],
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontSize: 16),
                                      ),
                                    ],
                                  ),
                                );
                              });
  }
}

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  CalendarController _calendarController;
  Map<DateTime, List> _events;
  List _selectedEvents;
  @override
  void initState() {
    super.initState();
    _calendarController = CalendarController();

    final _selectedDay = DateTime.now();
    _selectedEvents = [];
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    currentTask.date = _calendarController.selectedDay.toString();
    print(currentTask.date);
    setState(() {
      _selectedEvents = events;
    });
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      calendarController: _calendarController,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      initialCalendarFormat: CalendarFormat.week,
      availableCalendarFormats: const {
        CalendarFormat.week: '',
      },
      onDaySelected: _onDaySelected,
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
    );
  }
}

class ShowReminder extends StatefulWidget {
  @override
  _ShowReminderState createState() => _ShowReminderState();
}

class _ShowReminderState extends State<ShowReminder> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
          children:<Widget>[
             GestureDetector(
                          onTap: (){
                            Alert(
                                  context: context,
                                  title: "Set reminder for",
                                  content: ReminderDialog(),
                                  buttons: [
                                    DialogButton(
                                      color: Colors.deepOrangeAccent,
                                      onPressed: ()  {
                                        setState(() {
                                          
                                        });
                                        Navigator.pop(context);
                                        },
                                      child: Text(
                                        "Save this reminder",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                          },
                                                  child: Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                            child: Text(
                              "Set reminder",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                        Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                            child: Text(
                                  globalNewReminder == "" ? "" : globalNewReminder.substring(0,16),
                                  style: TextStyle(fontSize: 20),
                                )
                          ),
          ]
    );
  }
}

class ShowPriority extends StatefulWidget {
  @override
  _ShowPriorityState createState() => _ShowPriorityState();
}

class _ShowPriorityState extends State<ShowPriority> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Row(
            children: <Widget>[
              Container(
                child: Text(
                  "Set higher priority",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
              Expanded(
                child: SizedBox(),
              ),
              Container(
                child: Switch(
                  value: false,
                  activeColor: Colors.pink,
                  onChanged: ((bool newValue){
                    setState(() {
                      currentTask.priority = (newValue)?1:0;
                    });
                  }),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}

class CustomTimePicker extends StatefulWidget {
  @override
  _CustomTimePickerState createState() => _CustomTimePickerState();
}

class _CustomTimePickerState extends State<CustomTimePicker> {
  @override
  String _selectedTime;
  String _showTimeFormat;
  Widget build(BuildContext context) {
    if (_selectedTime != null) {
      List<String> showTimeFormat = _selectedTime.split("-");
      for (var item in showTimeFormat) {
        if (item.contains(":")) {
          _showTimeFormat = item;
          _showTimeFormat = _showTimeFormat.substring(2, 8);
        }
      }
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlatButton(
            onPressed: () {
              DatePicker.showTimePicker(context,
                  showTitleActions: true,
                  onChanged: (date) {}, onConfirm: (date) {
                currentTask.finishAt = date.toString();
                _selectedTime = date.toString();
                setState(() {
                  _selectedTime;
                  print(_selectedTime);
                });
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                _showTimeFormat == null ? 'Choose time' : _showTimeFormat,
                style: TextStyle(color: Colors.orange, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            )),
      ],
    );
  }
}

class NoteDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 1),
            ),
            hintText: globaNewNote == "" ? 'Note...' : globaNewNote,
          ),
          onChanged: (note) {
            globaNewNote = note;
          },
        ),
      ],
    );
  }
}

class WarningDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
    
      ],
    );
  }
}

class StepsDialog extends StatelessWidget {
  @override
  int state = 1;
  String _currentStep;
  List<String> newStepList = [];
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.orange, width: 1),
            ),
            hintText: 'Step...',
          ),
          onChanged: (step) {
            _currentStep = step;
            if (currentTask.steps == null) {
              newStepList.add(_currentStep);
              state = -1;
              currentTask.steps = newStepList;
            } else {
              if (state == 1) {
                currentTask.steps.add(_currentStep);
                state = -1;
              } else {
                currentTask.steps.removeLast();
                currentTask.steps.add(_currentStep);
              }
            }

            print(currentTask.steps);
          },
        ),
      ],
    );
  }
}



class ReminderDialog extends StatelessWidget {
  @override
  int state = 1;
  String _currentStep;
  List<String> newStepList = [];
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CustomTimePickerWithDate()
      ],
    );
  }
}

class PriorityDialog extends StatefulWidget {
  @override
  _PriorityDialogState createState() => _PriorityDialogState();
}

class _PriorityDialogState extends State<PriorityDialog> {
  @override
  double _sliderValue = currentTask.priority == null ? 0.0 : currentTask.priority.toDouble();
  List<String> newStepList = [];
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Slider(
                  activeColor: Colors.indigoAccent,
                  min: 0.0,
                  max: 2.0,
                  onChanged: (newRating) {
                    currentTask.priority = newRating.toInt();
                    setState(() => _sliderValue = newRating);
                    
                  },
                  value: _sliderValue,
                ),
                Container(
                width: 50.0,
                alignment: Alignment.center,
                child: Text('${_sliderValue.toInt()}',
                    style: Theme.of(context).textTheme.display1),
              ),
               Text("Priority, will be displayed as colorful dot, red as max, green as min",style: TextStyle(fontSize: 12),),
      ],
    );
  }
}


class CustomTimePickerWithDate extends StatefulWidget {
  @override
  _CustomTimePickerStateWithDate createState() => _CustomTimePickerStateWithDate();
}

class _CustomTimePickerStateWithDate extends State<CustomTimePickerWithDate> {
  @override
  String _selectedTime;
  String _showTimeFormat;
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        FlatButton(
            onPressed: () {
              DatePicker.showDateTimePicker(context,
                  showTitleActions: true,
                  onChanged: (date) {}, onConfirm: (date) {
                  currentTask.reminder = date.toString();
                  globalNewReminder = date.toString();
                  _showTimeFormat = currentTask.reminder;
                  
                  setState(() {
                    _showTimeFormat;
                  });
              }, currentTime: DateTime.now(), locale: LocaleType.en);
            },
            child: Container(
              alignment: Alignment.center,
              child: Text(
                globalNewReminder == "" ? 'Choose time' : globalNewReminder.substring(0,16),
                style: TextStyle(color: Colors.orange, fontSize: 25),
                textAlign: TextAlign.center,
              ),
            )
            ),
      ],
    );
  }
}


class TaskListPickerWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return TaskListPickerState();
  }
}


class TaskListPickerState extends State<TaskListPickerWidget> {
  int _radioButtonGroup = 122;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        GestureDetector(

          child: Container(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 5),
            child: Row(
              children: <Widget>[
                Text(
                  "Add to task list ",
                  textAlign: TextAlign.left,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.w500
                  ),
                ),
                Icon(
                  Icons.add,
                  color: Colors.black,
                  size: 25,
                ),
              ],
            )
          ),
          onTap: ((){
            Alert(
              context: context,
              title: "Chose task list",
              content: Container(
                width: 300,
                height: 200,
                child: ListView.builder(
                  itemCount: (loggedUser.taskLists == null)?0:loggedUser.taskLists.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Container(
                      child: Row(
                        children: <Widget>[
                          Icon(
                            Icons.brightness_1,
                            color: loggedUser.taskLists[index].color,
                            size: 20,
                          ),
                          SizedBox(width: 10,),
                          Text(
                            loggedUser.taskLists[index].name,
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          Expanded(
                            child: SizedBox(),
                          ),
                          Radio(
                            groupValue: _radioButtonGroup,
                            value: index,
                            activeColor: Colors.pink,
                            onChanged: ((int newValue){
                              setState(() {
                                globalPickedGroupIndex = newValue;
                              });
                            }),
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ),
              
              buttons: [
                DialogButton(
                  color: Colors.deepOrangeAccent,
                  onPressed: ()  {
                    setState(() {
                    });
                    Navigator.pop(context);
                    },
                  child: Text(
                    "Pick a task list",
                    style: TextStyle(
                        color: Colors.white, fontSize: 20),
                  ),
                )
              ] 

            ).show();
          }),
        ),
        Container(
          padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
            child: Text(
              "Task list",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.black54,
                fontSize: 17,
                fontWeight: FontWeight.w500
              ),
            ),
        )
      ],
    );
  }
}




