import 'package:flutter/material.dart';
import 'package:itu_project/Widgets/Views/DetailView.dart';
import 'package:itu_project/Widgets/Views/NewTaskListView.dart';
import 'package:itu_project/Widgets/Views/SettingsView.dart';
import 'package:table_calendar/table_calendar.dart';
import 'NewTaskView.dart';
import 'package:itu_project/Widgets/Background.dart';
import '../../User.dart';
import '../../Bloc/reload_list_bloc.dart';

class TaskListView extends StatelessWidget {
  @override
  Widget build (BuildContext context) {
    final size = MediaQuery.of(context).size;
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
              child: TaskListBackgroundWidget(),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => NewTaskListView()),
          );
        },
        label: Text('Add new task list'),
        icon: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

class TaskListBackgroundWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return new Container(
      height: size.height *0.7,
      width: size.width,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25), topRight: Radius.circular(25)
        ),
      ),
      child:
      Column(
        children: <Widget>[
          
          Container(
            padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
            child: Text(
              "Lists of tasks",
              style: TextStyle(
                  fontSize: 30,
                  color: Colors.black,
                  fontWeight: FontWeight.w600),
            ),
          ),
          Container(
                    height: size.height / 9,
                    child: ListView.builder(
                        primary: false,
                        itemCount: 0,
                        itemBuilder: (BuildContext ctxt, int index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: new Text(
                              "- ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16),
                            ),
                          );
                        }),
                  ),
        ],
      )
    );
  }
}