import 'package:flutter/material.dart';
import 'package:itu_project/Bloc/reload_list_bloc.dart';
import 'package:itu_project/Widgets/RadioButton.dart';
import 'package:itu_project/User.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text("Settings",style: TextStyle(color: Colors.black),),
        elevation: 0,
        leading: IconButton(
          onPressed: (){Navigator.pop(context);},
          icon: Icon(Icons.arrow_back,color: Colors.black,),
        ),
      ),
      body: Container(color: Colors.white,
      child:         ListView(
          children: <Widget>[
            Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            RadioButtonImportance(index: 0),
                            new Text("Show all notes",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                          ],
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            RadioButtonImportance(index: 2),
                            new Text("Show notes with higher priority",style: TextStyle(color: Colors.black,fontWeight: FontWeight.w500,fontSize: 16),),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.fromLTRB(30, 30, 35, 20),
                          child: TextField(
                            obscureText: false,
                            autofocus: false,
                            decoration: InputDecoration(
                              hasFloatingPlaceholder: false,
                              hintText: loggedUser.name == null ? "How we shoul call you..." : loggedUser.name,
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
                              loggedUser.name = value;
                            }),
                          ),
                        ),
          ],
        ),),
    );
  }
}