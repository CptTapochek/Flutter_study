import 'package:flutter/material.dart';
import 'package:task_list/pages/home.dart';
import 'package:task_list/pages/main_screen.dart';

void main() => runApp(MaterialApp(
  theme: ThemeData(
    primaryColor: Colors.deepOrangeAccent
  ),
  initialRoute: '/',
  routes: {
    '/': (context) => MainScreen(key: null),
    '/task_list': (context) => Home(key: null)
  },
));