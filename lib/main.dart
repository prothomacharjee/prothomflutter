import 'package:flutter/material.dart';
import 'package:prothomflutter/list_view_home.dart';
import 'package:prothomflutter/login_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

      ),
      home: LoginScreen(),
    );
  }
}