import 'package:flutter/material.dart';
import 'package:itu_project/Widgets/Views/DetailView.dart';
import 'package:table_calendar/table_calendar.dart';
import 'NewTaskView.dart';
import 'package:itu_project/Widgets/Background.dart';
import '../../User.dart';

class ActiveView extends StatelessWidget {

  
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    int numOfTask = loggedUser.todo == null ? 0 : loggedUser.todo.length;
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
                    Container(
                      child: Text(
                        "Today you have " +
                            numOfTask.toString() +
                            " tasks ahead",
                        style: TextStyle(color: Colors.white, fontSize: 20),
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
      ),
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
    int numOfTask = (loggedUser.todo == null || loggedUser.todo == [])
        ? 0
        : loggedUser.todo.length;
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
              itemCount: numOfTask,
              itemBuilder: (BuildContext ctxt, int index) {
                String _showTimeFormat;
                if (loggedUser.todo[index].finishAt != null) {
                  List<String> showTimeFormat =
                      loggedUser.todo[index].finishAt.split("-");
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
                        notes: loggedUser.todo[index].notes,
                        title: loggedUser.todo[index].title,
                        steps: loggedUser.todo[index].steps));
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
    List<String> steps,
    String notes,
  })  : _notes = notes,
        _title = title,
        _steps = steps,
        _time = time,
        _index = index,
        _size = size,
        super(key: key);

  final Size _size;
  final String _time;
  final String _title;
  final List<String> _steps;
  final int _index;
  String _notes;

  @override
  Widget build(BuildContext context) {
    int titleCutAt = 0;
    if(_title != null){
      titleCutAt = _title.length > 20 ? 20 : _title.length;
    }
     
    if (_notes == null) _notes = "";
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
        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                _time,
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
                      _title != null ?_title.substring(0, titleCutAt) : "",
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
