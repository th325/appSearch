import 'package:flutter/material.dart';
import 'package:untitled1/src/logical/Notification.dart';
import 'package:untitled1/src/logical/filetestpicker.dart';
import 'package:untitled1/src/resource/Choice_Page.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
import 'package:untitled1/src/resource/Popup.dart';
import 'package:untitled1/src/resource/Result_page.dart';
import 'package:untitled1/src/resource/dropmenu.dart';
import 'package:untitled1/src/resource/edit_page.dart';
import 'package:after_layout/after_layout.dart';
class HomePage extends StatefulWidget{
  @override
  _MyHomePageState createState()=>_MyHomePageState();
}
class  _MyHomePageState extends State<HomePage>{
  @override
  int currentindex=0;
  List<Widget> pages;
  SearchPage searchPage;
  FileChoice fileChoice;
  Widget currentPage;
  @override
  void initState(){
    searchPage = new SearchPage();
    fileChoice = new FileChoice();
    pages=[searchPage,fileChoice];
    currentPage=searchPage;
    super.initState();
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(

      body:currentPage,
      bottomNavigationBar: new BottomNavigationBar(
          currentIndex: currentindex,
          onTap: (int index){
            setState(() {
              currentindex = index;
              currentPage=pages[index];

            });
          },
          items: [
            new BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text("Tìm kiếm")),
            new BottomNavigationBarItem(
                icon: Icon(Icons.save),
                title: Text("Thay file"))
          ]) ,
    );
  }

}
class SearchPage extends StatefulWidget{
  _SearchPageState createState()=>_SearchPageState();
}
class _SearchPageState extends State<SearchPage> with AfterLayoutMixin<SearchPage>{
  InfoClass napInfo = new InfoClass(null);
  AgrumentList agrumentList = new AgrumentList();
  bool traverse=false;
  int currentindex=0;
  NotificationShow notificationShow = new NotificationShow();
  var _hintTextArea="",_hintTextVertext="",_hintTextCountRoom="",_hintTextFeature="",_hintTextDirection="";

  @override

  @override
  void afterFirstLayout(BuildContext context)async{
    String er= await agrumentList.LoadAgru();
      if(!traverse) {
        if(er=='true'){
          setState(() {
            traverse=true;
          });
        }else{
          print(er);
          notificationShow.Conform(context,"Vui lòng thực hiện thay file");
        };

      }
  }
  Widget build(BuildContext context) {
    // TODO: implement build


    return
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(0, 60, 0, 0),
                child: Container(
                  child: Column(
                    children:<Widget>[
                      Container(
                          width: 80,
                          height: 80,
                          child: importLogo()),
                      Row(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
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
                            padding: const EdgeInsets.fromLTRB(20, 50, 20, 0),
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
                          onPressed: (){
                            print(context);
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Resultpage(napInfo)));
                          },
                            child: Text("Tìm kiếm",style:TextStyle(fontSize: 20,color: Colors.white),)
                          ),
                        ),
                      )

                    ]

                  ),
                ),
              ),
            );
  }
  void onTapPopup(String choice){
    switch(choice){
      case'Thay đổi database':{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>FileChoice()));
        break;
      }
      case'Sửa đổi thuộc tính':{

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