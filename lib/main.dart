import 'package:flutter/material.dart';
import 'Widgets/Views/ActiveView.dart';
import 'User.dart';
import 'package:shared_preferences/shared_preferences.dart';


void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  
  @override
  Widget build(BuildContext context) {
    loggedUser.name = "Joe";
    loggedUser.showOnly = [1,0,0,0];
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ITUProject',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ActiveView(),
    );
  }

  _read() async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'my_int_key';
        final value = prefs.getInt(key) ?? 0;
        print('read: $value');
      }

      _save() async {
        final prefs = await SharedPreferences.getInstance();
        final key = 'my_int_key';
        final value = 42;
        prefs.setInt(key, value);
        print('saved $value');
      }
}


