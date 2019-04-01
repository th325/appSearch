import 'package:flutter/material.dart';
import 'package:untitled1/src/resource/Home_page.dart';
class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
        home:SearchPage()
    );
  }
}