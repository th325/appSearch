import 'dart:async';
import 'package:flutter/material.dart';
import 'package:countdown/countdown.dart';

class MyAppT extends StatefulWidget {
  @override
  ProgressIndicatorDemoState createState() => new ProgressIndicatorDemoState();
}
class ProgressIndicatorDemoState extends State<MyAppT>
    with SingleTickerProviderStateMixin {
  int state = 0;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    animation = Tween(begin: 0.0, end: 1.0).animate(controller)
      ..addListener(() {
        setState(() {
          // the state that has changed here is the animation object’s value
        });
      });
    controller.forward();
    setState(() {
      state = 0;
    });
    Timer(Duration(milliseconds:2200), () {
      setState(() {
        state = 1;
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return null;
  }
  Widget buttonchild(Widget widgetObj){
    if (state==1){
          return widgetObj;
      }else if(state==0){
          return Padding(
            padding: const EdgeInsets.all(0.0),
            child: new Center(
                child:new CircularProgressIndicator(value:animation.value)),
          );
    }
  }

}