import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:untitled1/src/logical/tool_file.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:untitled1/src/resource/Home_page.dart';
class FileChoice extends StatefulWidget{
  _FileChoiceState createState()=>new _FileChoiceState();


}

class _FileChoiceState extends State<FileChoice>{
  String _path="";
  String _pathShow="...";
  String _nameShow="";
  int currentindex=1;

  @override
  void _OnGetFile()async{

      _path=null;
      String Extension="csv";
      _path= await FilePicker.getFilePath(type: FileType.CUSTOM,fileExtension: Extension);
      setState((){
        _pathShow=_path != null?_path:"...";

    });

  }
  void _OnAccept()async{
    ToolFile insertFile=new ToolFile();
    insertFile.applyfile(_path);

    setState(() {
      _pathShow="...";
    });
  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
        debugShowCheckedModeBanner: false,
     theme: new ThemeData(primarySwatch: Colors.blue),
     
     home: Scaffold(
        appBar: AppBar(
          title: Text("Chỉnh sửa database"),
        ),
        body: 
       Container(
         width: double.infinity,
         height: 500,
         child:Column(
           children: <Widget>[
             Expanded(
               flex: 6,
               child: Column(
                 children: <Widget>[
                   Text("Vui lòng chọn file định dạng CSV"),

                   ImageFile(_pathShow),

                   new Text(_pathShow,style: TextStyle(color:Colors.indigoAccent),),

                 ],

               ),
              // child: Text("Vui lòng chọn file định dạng CSV"),

             ),
          Expanded(
            flex: 4,

            child: Column(

              children: <Widget>[
                Container(

                  width: 200,
                  height: 70,
                  child: RaisedButton(
                   child: Text("Chọn file",style: TextStyle(color: Colors.white,fontSize: 18),),
                      color: Colors.blue,
                   onPressed: _OnGetFile),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                  child: Container(
                    width: 200,
                    height: 70,
                    child: RaisedButton(
                        child: Text("Chấp nhận",style: TextStyle(color: Colors.white,fontSize: 18),),
                        color: Colors.blue,
                        onPressed:_pathShow=="..."?null:_OnAccept),

                  ),
                ),
              ],
            ),
          ),
           ],
         )
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
    ),

    );

  }
  void  _selectPage(int index){
    switch(index){
      case 0:{
        Navigator.push(context, MaterialPageRoute(builder: (context)=>SearchPage()));
        break;
      }
    }
  }
}
class ImageFile extends StatelessWidget{
  String _pathShow="...";
  ImageFile(String pathShow){
    _pathShow=pathShow;
  }
  @override
  Widget build(BuildContext context) {
    AssetImage assetImage;
    if(_pathShow!="..."){
      assetImage = AssetImage("assets/icon_csv.png");

    }else{
      assetImage = AssetImage("assets/empty.png");
    }
    Image image = Image(image: assetImage);
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 10),
      child: Container(
        width: 100,
        height: 100,
        child: image,
      ),
    );
  }

}