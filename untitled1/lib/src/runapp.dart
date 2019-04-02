import 'package:flutter/material.dart';
import 'package:untitled1/src/resource/Home_page.dart';
import 'package:untitled1/src/resource/dropmenu.dart';
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      title: 'TFind',
      debugShowCheckedModeBanner: false,
        home:HomePage()
    );
  }
}