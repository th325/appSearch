import 'package:flutter/material.dart';
import 'package:untitled1/src/logical/DBHelper.dart';
import 'package:untitled1/src/resource/Home_page.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
import 'package:after_layout/after_layout.dart';
import 'package:untitled1/src/resource/dropmenu.dart';
import 'package:untitled1/src/resource/table.dart';
import 'dart:async';
Future<List<InfoClass>> getInfoFromDB()async{
  var dbHelper=DBHelper();
  Future<List<InfoClass>> infos=dbHelper.getInfoAll();
  return infos;
}
Future<List<InfoClass>> getInfoDetail(InfoClass info)async{
  var dbHelper=DBHelper();
  List<InfoClass> infotemple;
  InfoClass infoNull=new InfoClass('404');
  Future<List<InfoClass>> infos=dbHelper.getInfo(info);
  infotemple=await infos;
  if (infotemple==null){
    print("aád231132asd");
    return [infoNull];
  }
    return infos;
  }

class Resultpage extends StatefulWidget{
  InfoClass getinfo;
  Resultpage(InfoClass info){
   getinfo=info;
  }
  _ResultpageState createState()=>_ResultpageState(getinfo);

}
class _ResultpageState extends State<Resultpage> with SingleTickerProviderStateMixin {
  InfoClass napInfo;

  _ResultpageState(InfoClass info){
   napInfo=info;
  }
  int state = 0;
  AnimationController controller;
  Animation<double> animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
            controller = AnimationController(
                duration: const Duration(milliseconds: 1000), vsync: this);
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
            Timer(Duration(milliseconds:1200), () {
              setState(() {
                state = 1;
              });
            });
  }
  Widget buttonchild(Widget widgetObj){
    if (state==1){
      return widgetObj;
    }else if(state==0){
      return Padding(
        padding: const EdgeInsets.all(0.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Center(child: Text("Đang tìm kiếm...",style: TextStyle(color:Colors.blue,fontSize: 20),),),
            new Center(
                child:new CircularProgressIndicator(value:animation.value)),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery
        .of(context)
        .size;
    return new Scaffold(

        appBar: AppBar(

            title: Text("Kết quả tìm kiếm")
        ),
        body: new Container(
            width: screenSize.width,
            height: screenSize.height,

            child: FutureBuilder<List<InfoClass>>(
              future: getInfoDetail(this.napInfo),
              builder: (context, snapshot) {
                if (snapshot.data!=null) {

                  if (snapshot.data[0].Vertex != '404') {//Code symbol Null
                    return Container(
                      width: screenSize.width,
                      height: screenSize.height,
                      child:buttonchild(DisplayPage(snapshot,screenSize.width)),
                    );
                  }else if(snapshot.data[0].Vertex == '404'){
                    return Column(
                      children: <Widget>[
                        Notfoundicon(),
                        Container(
                            width: screenSize.width,
                            height: screenSize.height / 3,
                            alignment: AlignmentDirectional.center,
                            child: Text("Rất tiếc không tìm thấy thông tin",
                                style: TextStyle(color: Colors.red, fontSize: 20))
                        ),

                      ],
                    );
                  }
                } else {
                  return Column(
                    children: <Widget>[
                      Container(
                          width: screenSize.width,
                          height: screenSize.height / 3,
                          alignment: AlignmentDirectional.center,
                          child: Text("Loading...",
                              style: TextStyle(color: Colors.blue, fontSize: 20))
                      ),

                    ],
                  );
                }
              },
            )
        )
    );
  }
  Widget DisplayPage(snapshot,double sizeWith){
    return PageView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: snapshot.data.length,
        itemBuilder: (BuildContext context, int index) {
          //return TablePage(snapshot.data[index]);
          return Container(
              width: 400,
              height: 200,


              child: Container(
                width: sizeWith,
                height: 200,

                //color: Color.fromRGBO(85, 102, 215, 0.3),

                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                          0, 40, 0, 0),
                      child: Container(
                        width: 150,
                        height: 150,

                        alignment: AlignmentDirectional
                            .center,
                        child: Text(
                          snapshot.data[index].Price == null
                              ? "0"
                              : snapshot.data[index].Price +
                              ' \$', style: TextStyle(
                            color: Colors.white,
                            fontSize: 30),),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle
                        ),
                      ),
                    ),
                    Container(

                      width: sizeWith,
                      child: DataTable(
                          columns: <DataColumn>[
                            DataColumn(
                              label: Text("Thuộc tính",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18)),

                            ),
                            DataColumn(
                              label: Text("Giá trị",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18)),
                            )
                          ],
                          rows: <DataRow>[
                            DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text("Mã căn hộ",
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize: 18)),
                                  ),
                                  DataCell(
                                    Text(snapshot.data[index]
                                        .Code,
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize: 18)),
                                  )
                                ]
                            )
                            , DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text("Số tầng",
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize: 18)),
                                  ),
                                  DataCell(
                                    Text(snapshot.data[index]
                                        .Floor,
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize: 18)),
                                  )
                                ]
                            ),
                            DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text("Pass",
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize: 18)),
                                  ),
                                  DataCell(
                                    Text(snapshot.data[index]
                                        .Pass,
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize: 18)),
                                  )
                                ]
                            ),
                            DataRow(
                                cells: <DataCell>[
                                  DataCell(
                                    Text(
                                        "Thông tin quản lý",
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize: 18)),
                                  ),
                                  DataCell(
                                    Text(snapshot.data[index]
                                        .InfoFee,
                                        style: TextStyle(
                                            color: Colors
                                                .black,
                                            fontSize: 18)),
                                  )
                                ]
                            ),

                          ]),
                    ),

                  ],
                ),
              )
          );
        }
    );
  }
}
class NotifiText extends StatelessWidget{
  int len=0;
  NotifiText(int length){
    len=length;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    home: Scaffold(
      body: new Container(
      width: double.infinity,
      height: double.infinity,
      alignment: AlignmentDirectional.center,
      child: Text("Có tất cả $len được tìm thấy",style: TextStyle(color: Colors.blueAccent,fontSize: 20))

      )
    );
  }

}
class Notfoundicon extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage;
    assetImage = AssetImage("assets/notfound.png");
    Image image = Image(image: assetImage);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0,0),
      child: Container(
        width: 100,
        height: 100,
        child: image,
      ),
    );
  }

}