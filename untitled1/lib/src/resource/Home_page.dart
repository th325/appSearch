import 'package:flutter/material.dart';
import 'package:untitled1/src/logical/filetestpicker.dart';
import 'package:untitled1/src/resource/Choice_Page.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
import 'package:untitled1/src/resource/Popup.dart';
import 'package:untitled1/src/resource/Result_page.dart';
import 'package:untitled1/src/resource/dropmenu.dart';
import 'package:untitled1/src/resource/edit_page.dart';
import 'package:after_layout/after_layout.dart';
class SearchPage extends StatefulWidget{
  @override
  _SearchPageState createState()=>_SearchPageState();
}
class _SearchPageState extends State<SearchPage>with AfterLayoutMixin<SearchPage>{
  InfoClass napInfo = new InfoClass();
  AgrumentList agrumentList = new AgrumentList();
  bool traverse=false;
  int currentindex=0;
  My Navigatorbar ;
  var _hintTextArea="",_hintTextVertext="",_hintTextCountRoom="",_hintTextFeature="",_hintTextDirection="";

  @override
  initState(){
    super.initState();

  }
  @override
  void afterFirstLayout(BuildContext context){
    setState(() {
      if(!traverse) {
        agrumentList.LoadAgru();
        traverse=true;
      }
    });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    if(!traverse){
      agrumentList.LoadAgru();
      traverse=true;
    }
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
      home:Scaffold(
        appBar: AppBar(
          title: Text("Tìm kiếm"),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: onTapPopup,
              itemBuilder: (BuildContext context){
                return Itempopup.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                }).toList();
              },
            )

          ],
        ),
        body:Padding(
          padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Container(
              child: Column(
                children:<Widget>[
                  Container(
                      width: 60,
                      height: 60,
                      child: importLogo()),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Container(
                          width: 150,
                          height: 50,
                          child:new DropdownButtonFormField(
                            hint: Text(_hintTextVertext==""?"Tháp":_hintTextVertext),
                            items: agrumentList.listVertex, onChanged: onWriteChangeVertex
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Container(
                          width: 150,
                          height: 50,
                          child:new DropdownButtonFormField(
                            hint: Text(_hintTextArea==""?"Diện tích":_hintTextArea),
                            items: agrumentList.listArea, onChanged: onWriteChangeArea
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Container(
                          width: 150,
                          height: 50,
                          child:new DropdownButtonFormField(
                            hint: Text(_hintTextFeature==""?"Đặc điểm căn hộ":_hintTextFeature),
                            items: agrumentList.listFeature, onChanged: onWriteChangeFeature,
                          ),
                        ),
                      ),

                    ],
                  ),
                  Row(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Container(
                          width: 150,
                          height: 50,
                          child:new DropdownButtonFormField(
                            hint: Text(_hintTextDirection==""?"Hướng":_hintTextDirection),
                            items: agrumentList.listDirection, onChanged:onWriteChangeDirection
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                        child: Container(
                            width: 150,
                            height: 50,
                          child:new DropdownButtonFormField(
                            hint: Text(_hintTextCountRoom==""?"Số phòng":_hintTextCountRoom),
                            items: agrumentList.listCountRoom, onChanged:onWriteChangeCountRoom
                          ),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                    child: Container(
                      width: 200,
                      height: 50,
                      child: RaisedButton(
                        color: Colors.blue,
                      onPressed: onTapSearchClick,
                        child: Text("Tìm kiếm",style:TextStyle(fontSize: 20,color: Colors.white),)
                      ),
                    ),
                  )

                ]

              ),
            ),
          ),
        ),
        bottomNavigationBar: new BottomNavigationBar(
            currentIndex: currentindex,
            onTap: (int index){
              setState(() {
                  currentindex = index;
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
  void  _selectPage(int index){
    switch(index){
      case 1:{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FileChoice()));
        break;
      }
    }
  }
  void onTapSearchClick(){
       Navigator.push(context, MaterialPageRoute(builder: (context)=>Resultpage(napInfo)));
  //Navigator.push(context, MaterialPageRoute(builder: (context)=>FilePickerDemo()));
}
  void onTapPopup(String choice){
    switch(choice){
      case'Thay đổi database':{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FileChoice()));
        break;
      }
      case'Sửa đổi thuộc tính':{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>Testdrop()));
       break;
      }
    }
  }
void onWriteChangeVertex(String value){
setState(() {
  _hintTextVertext=value;
});
napInfo.Vertex=value;
}
  void onWriteChangeArea(String value){
    setState(() {
      _hintTextArea=value;
      napInfo.Area=value;

    });
  }
  void onWriteChangeFeature(String value){
    setState(() {
      _hintTextFeature=value;
      napInfo.Feature=value;

    });
  }
  void onWriteChangeDirection(String value){
    setState(() {
      _hintTextDirection=value;
      napInfo.Direction=value;

    });
  }
  void onWriteChangeCountRoom(String value){
    setState(() {
      _hintTextCountRoom=value;
      napInfo.CountRoom=value;

    });
  }
}
class importLogo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage;
    assetImage = AssetImage("assets/logos.png");
    Image image = Image(image: assetImage);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0,0),
      child: Container(
        width: 500,
        height: 500,
        child: image,
      ),
    );
  }

}