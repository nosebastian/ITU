import 'package:flutter/material.dart';
import 'package:itu_project/Task.dart';
import 'package:itu_project/Task.dart' as prefix0;
import 'package:table_calendar/table_calendar.dart';
import 'package:itu_project/Widgets/Background.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import '../../User.dart';

String globaNewNote = "";
String globalNewSteps = "";
String globalNewStep = "";
String globalNewReminder = "";

class NewTaskView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            Positioned(
              child: BackGround(),
            ),
            Positioned(
              top: size.height / 10,
              child: Container(
                padding: EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topLeft,
                      child: Text(
                        "Hi " + loggedUser.name,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                        ),
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: size.height / 7.3,
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
    currentTask.date = _calendarController.selectedDay.toIso8601String();
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
        GestureDetector(
                          onTap: (){
                             Alert(
                                  context: context,
                                  title: "Set priority",
                                  content: PriorityDialog(),
                                  buttons: [
                                    DialogButton(
                                      color: Colors.deepOrangeAccent,
                                      onPressed: () {
                                        setState(() {
                                          
                                        });
                                        Navigator.pop(context);
                                        },
                                      child: Text(
                                        "Save priority for this task",
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 20),
                                      ),
                                    )
                                  ]).show();
                          },
                                                  child: Container(
                            padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
                            child: Text(
                              "Set priority for this task",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 25,
                                  fontWeight: FontWeight.w500),
                            ),
                            
                          ),
                          
                        ),
                        Container(
                              padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                              child: Text(
                                currentTask.priority == null ? "" : currentTask.priority.toString(),
                                style: TextStyle(fontSize: 20),
                              )),
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
                currentTask.finishAt = date.toUtc().toString();
                _selectedTime = date.toString();
                setState(() {
                  _selectedTime;
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
                  max: 3.0,
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