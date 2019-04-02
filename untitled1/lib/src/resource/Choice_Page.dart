import 'package:flutter/material.dart';

import 'package:flutter/services.dart';
import 'package:file_picker/file_picker.dart';
import 'package:untitled1/src/logical/Notification.dart';
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
  NotificationShow notificationShow = new NotificationShow();
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
    String err="";

      ToolFile insertFile=new ToolFile();
      err=await insertFile.applyfile(_path);
      if (err=="true") {
        notificationShow.Conform(context, "Tiến trình đã hoàn thành");
      }else{
        notificationShow.Conform(context,"Sự cố: "+err.toString());
      }
    setState(() {
      _pathShow="...";
    });


  }
  Widget build(BuildContext context) {
    // TODO: implement build
    return
       Padding(
         padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
         child: Container(
           width: double.infinity,
           height: 500,
           child:Column(
             children: <Widget>[
               Expanded(
                 flex: 6,
                 child: Column(
                   children: <Widget>[
                     Text("Vui lòng chọn file định dạng CSV",style: TextStyle(fontSize: 20),),

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
       );
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