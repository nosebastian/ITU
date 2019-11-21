import 'package:flutter/material.dart';
import 'package:itu_project/Widgets/Views/DetailView.dart';
import 'package:itu_project/Widgets/Views/SettingsView.dart';
import 'package:table_calendar/table_calendar.dart';
import 'NewTaskView.dart';
import 'package:itu_project/Widgets/Background.dart';
import '../../User.dart';
import '../../Bloc/reload_list_bloc.dart';

int numOfTask = 0;

class ActiveView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (loggedUser.todo != null && loggedUser.showDate != null) {
      loggedUser.todaysTasks = [];
      String chosenDate =
          loggedUser.showDate != null ? loggedUser.showDate.toString() : "";
      chosenDate = chosenDate == "" ? "" : chosenDate.substring(0, 10);
      for (int i = 0; i < loggedUser.todo.length; i++) {
        String taskDate =
            loggedUser.todo[i].date != null ? loggedUser.todo[i].date : "";
        taskDate = taskDate == "" ? "" : taskDate.substring(0, 10);
        if (taskDate == chosenDate && loggedUser.showOnly[0] == 1) {
          // Show all
          loggedUser.todaysTasks.add(loggedUser.todo[i]);
        } else {
          if (taskDate == chosenDate &&
              loggedUser.showOnly[1] == 1 &&
              loggedUser.todo[i].priority == 0) {
            // Fill with priority 0
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
          if (taskDate == chosenDate &&
              loggedUser.showOnly[2] == 1 &&
              loggedUser.todo[i].priority == 1) {
            // Fill with priority 1
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
          if (taskDate == chosenDate &&
              loggedUser.showOnly[3] == 1 &&
              loggedUser.todo[i].priority == 2) {
            // Fill with priority 2
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
        }
      }
      loggedUser.todaysTasks.sort((a, b) {
        return a.finishAt.compareTo(b.finishAt);
      });
    }
    numOfTask =
        loggedUser.todaysTasks == null ? 0 : loggedUser.todaysTasks.length;
    double fromLeft = size.width / 1.2;
    return Scaffold(
      body: StreamBuilder<int>(
          stream: controller.publicRebuild,
          initialData: 0,
          builder: (context, snapshot) {
            return snapshot.data != -1
                ? Container(
                    child: Stack(
                      children: <Widget>[
                        Positioned(
                          child: BackGround(),
                        ),
                        Positioned(
                          top: size.height / 12,
                          child: Container(
                            padding: EdgeInsets.only(left: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  padding:
                                      EdgeInsets.fromLTRB(fromLeft, 0, 0, 0),
                                  child: GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    SettingsView()));
                                      },
                                      child: Icon(
                                        Icons.settings,
                                        color: Colors.white60,
                                      )),
                                ),
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
                                Container(
                                  child: Text(
                                    "Today you have " +
                                        numOfTask.toString() +
                                        " tasks ahead",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 20),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: size.height / 4,
                          bottom: 0,
                          width: size.width,
                          child: ListBackGround(
                            size: size,
                          ),
                        ),
                        Positioned(
                            top: size.height / 4.2,
                            width: size.width,
                            child: Column(
                              children: <Widget>[
                                Calendar(),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            )),
                      ],
                    ),
                  )
                : Container();
          }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => NewTaskView()));
        },
        label: Text('New task'),
        icon: Icon(Icons.add),
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
    if (loggedUser.todo != null && loggedUser.showDate != null) {
      loggedUser.todaysTasks = [];
      String chosenDate =
          loggedUser.showDate != null ? loggedUser.showDate.toString() : "";
      chosenDate = chosenDate == "" ? "" : chosenDate.substring(0, 10);
      for (int i = 0; i < loggedUser.todo.length; i++) {
        String taskDate =
            loggedUser.todo[i].date != null ? loggedUser.todo[i].date : "";
        taskDate = taskDate == "" ? "" : taskDate.substring(0, 10);
                if (taskDate == chosenDate && loggedUser.showOnly[0] == 1) {
          // Show all
          loggedUser.todaysTasks.add(loggedUser.todo[i]);
        } else {
          if (taskDate == chosenDate &&
              loggedUser.showOnly[1] == 1 &&
              loggedUser.todo[i].priority == 0) {
            // Fill with priority 0
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
          if (taskDate == chosenDate &&
              loggedUser.showOnly[2] == 1 &&
              loggedUser.todo[i].priority == 1) {
            // Fill with priority 1
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
          if (taskDate == chosenDate &&
              loggedUser.showOnly[3] == 1 &&
              loggedUser.todo[i].priority == 2) {
            // Fill with priority 2
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
        }
      }
      loggedUser.todaysTasks.sort((a, b) {
        return a.finishAt.compareTo(b.finishAt);
      });
    }
    numOfTask = (loggedUser.todaysTasks == null || loggedUser.todaysTasks == [])
        ? 0
        : loggedUser.todaysTasks.length;
    return Container(
      height: _size.height,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25), topRight: Radius.circular(25)),
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(20, 130, 20, 0),
        child: Container(
          child: ListView.builder(
              itemCount: loggedUser.todaysTasks != null
                  ? loggedUser.todaysTasks.length
                  : 0,
              itemBuilder: (BuildContext ctxt, int index) {
                String _showTimeFormat;
                if (loggedUser.todaysTasks[index].finishAt != null) {
                  List<String> showTimeFormat =
                      loggedUser.todaysTasks[index].finishAt.split("-");
                  for (var item in showTimeFormat) {
                    if (item.contains(":")) {
                      _showTimeFormat = item;
                      _showTimeFormat = _showTimeFormat.substring(2, 8);
                    }
                  }
                } else {
                  _showTimeFormat = "NS";
                }
                return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Task(
                        size: _size,
                        time: _showTimeFormat,
                        index: index,
                        priority: loggedUser.todaysTasks[index].priority,
                        notes: loggedUser.todaysTasks[index].notes,
                        title: loggedUser.todaysTasks[index].title,
                        steps: loggedUser.todaysTasks[index].steps));
              }),
        ),
      ),
    );
  }
}

class Task extends StatelessWidget {
  Task({
    Key key,
    @required Size size,
    @required String time,
    String title,
    int index,
    int priority,
    List<String> steps,
    String notes,
  })  : _notes = notes,
        _title = title,
        _steps = steps,
        _time = time,
        _priority = priority,
        _index = index,
        _size = size,
        super(key: key);

  final Size _size;
  final String _time;
  final String _title;
  final List<String> _steps;
  final int _index;
  final int _priority;
  String _notes;

  @override
  Widget build(BuildContext context) {
    int titleCutAt = 0;
    if (_title != null) {
      titleCutAt = _title.length > 14 ? 14 : _title.length;
    }

    if (_notes == null) _notes = "";
    Color priorityColor;
    if (_priority != null) {
      if (_priority == 0)
        priorityColor = Colors.green;
      else if (_priority == 1)
        priorityColor = Colors.yellow;
      else
        priorityColor = Colors.red;
    } else {
      priorityColor = Colors.green;
    }
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailView(
                title: _title,
                steps: _steps,
                index: _index,
                notes: _notes,
              ),
            ));
      },
      child: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
        child: Row(
          children: <Widget>[
            Container(
              decoration:
                  BoxDecoration(shape: BoxShape.circle, color: priorityColor),
              width: 10,
              height: 10,
            ),
            Container(
              child: Text(
                _time == null ? "" : _time,
                style: TextStyle(
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                    fontSize: 20),
              ),
            ),
            SizedBox(width: 5),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                gradient: LinearGradient(
                  begin: Alignment.bottomRight,
                  end: Alignment.topLeft,
                  stops: [0.3, 1],
                  colors: [
                    Color.fromRGBO(255, 132, 88, 1),
                    Color.fromRGBO(255, 95, 109, 1),
                  ],
                ),
              ),
              height: _size.height / 6,
              width: _size.width / 1.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                    child: Text(
                      _title != null ? _title.substring(0, titleCutAt) : "",
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  Container(
                    height: _size.height / 9,
                    child: ListView.builder(
                        itemCount: _steps != null ? _steps.length : 0,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                              "- " + _steps[index],
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
        height: _size.height / 6,
      ),
    );
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
    loggedUser.showDate = _calendarController.selectedDay;

    if (loggedUser.todo != null && loggedUser.showDate != null) {
      loggedUser.todaysTasks = [];
      String chosenDate =
          loggedUser.showDate != null ? loggedUser.showDate.toString() : "";
      chosenDate = chosenDate == "" ? "" : chosenDate.substring(0, 10);
      for (int i = 0; i < loggedUser.todo.length; i++) {
        String taskDate =
            loggedUser.todo[i].date != null ? loggedUser.todo[i].date : "";
        taskDate = taskDate == "" ? "" : taskDate.substring(0, 10);
                if (taskDate == chosenDate && loggedUser.showOnly[0] == 1) {
          // Show all
          loggedUser.todaysTasks.add(loggedUser.todo[i]);
        } else {
          if (taskDate == chosenDate &&
              loggedUser.showOnly[1] == 1 &&
              loggedUser.todo[i].priority == 0) {
            // Fill with priority 0
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
          if (taskDate == chosenDate &&
              loggedUser.showOnly[2] == 1 &&
              loggedUser.todo[i].priority == 1) {
            // Fill with priority 1
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
          if (taskDate == chosenDate &&
              loggedUser.showOnly[3] == 1 &&
              loggedUser.todo[i].priority == 2) {
            // Fill with priority 2
            loggedUser.todaysTasks.add(loggedUser.todo[i]);
          }
        }
        loggedUser.todaysTasks.sort((a, b) {
          return a.finishAt.compareTo(b.finishAt);
        });
      }
      numOfTask = loggedUser.todaysTasks.length;
      controller.to.add(numOfTask + 1);
    }
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
