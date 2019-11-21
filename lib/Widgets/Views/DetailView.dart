import 'package:flutter/material.dart';
import 'package:itu_project/Widgets/Background.dart';
import 'package:itu_project/Widgets/RadioButton.dart';
import 'package:itu_project/User.dart';
class DetailView extends StatelessWidget {
  const DetailView({
    Key key,
    String title,
    List<String> steps,
    String notes,
    int index,
  }) : _index = index,_notes = notes,_steps = steps, _title = title,super(key: key);


  final String _title;
  final List<String> _steps;
  final String _notes;
  final int _index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: Container(
          decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomRight,
          end: Alignment.topLeft,
          stops: [0, 0.05],
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
              icon: Icon(Icons.arrow_back),
              onPressed: (){

                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Stack(children: <Widget>[
        BackGround(),
        ListView(
          children: <Widget>[
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(_title,style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text("Notes",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text(_notes == null ? "" : _notes,style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
            ),
            
            Container(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: Text("Steps",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 30),),
            ),
            Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: _steps == null ? 0 : _steps.length,
                    itemBuilder: (BuildContext ctxt, int index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            RadioButton(index: index,indexOfNote: _index),
                            new Text("- "+_steps[index],style: TextStyle(color: Colors.white,fontWeight: FontWeight.w500,fontSize: 16),),
                          ],
                        ),
                      );
                      }
                  ),
                ),
          ],
        )
      ],),
      floatingActionButton: FloatingActionButton.extended(
      onPressed: () {
        loggedUser.todo.removeAt(_index);
        Navigator.pop(context);
      },
      label: Text('Mark as done'),
      icon: Icon(Icons.done),
      backgroundColor: Colors.pink,
    ),
    );
  }
}