import 'package:flutter/material.dart';
import 'package:untitled1/src/resource/Choice_Page.dart';
import 'package:untitled1/src/runapp.dart';
class Testdrop extends StatefulWidget{
  TestdropState createState()=>TestdropState();

}
class My extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home:new Testdrop()
    );
  }

}
class TestdropState extends State<Testdrop>{
  @override
  int currentindex=0;
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home:new Scaffold(
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: currentindex,
            onTap: (int index){
              setState(() {
                currentindex=index;
                _selectPage(index);
              });
            },
            items: [
          new BottomNavigationBarItem(
              icon: Icon(Icons.search),
              title: Text("Tìm kiếm")),
          new BottomNavigationBarItem(
              icon: Icon(Icons.save),
              title: Text("Thay file"))
        ]),
      )
    );
  }
void _selectPage(int index){
    switch(index){
      case 0:
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>MyApp()));
        break;
      }
      case 1:
        {
          Navigator.push(context, MaterialPageRoute(builder: (context)=>FileChoice()));
          break;
        }

    }
}
}