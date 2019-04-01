import 'package:flutter/material.dart';
import 'package:untitled1/src/logical/DBHelper.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
import 'package:after_layout/after_layout.dart';
import 'package:untitled1/src/resource/table.dart';
Future<List<InfoClass>> getInfoFromDB()async{
  var dbHelper=DBHelper();
  Future<List<InfoClass>> infos=dbHelper.getInfoAll();
  return infos;
}
Future<List<InfoClass>> getInfoDetail(InfoClass info)async{
  var dbHelper=DBHelper();
  Future<List<InfoClass>> infos=dbHelper.getInfo(info);
  return infos;
}

class Resultpage extends StatelessWidget{
  InfoClass getinfo;
  Resultpage(InfoClass info){
    getinfo=info;
    print(getinfo);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        home:new InitResult(getinfo)
    );
  }

}

class InitResult extends StatefulWidget{
  InfoClass getinfo;

  InitResult(InfoClass info){
  getinfo  = info;
  }
  @override
  _ResultpageState createState() {
    // TODO: implement createState
    return _ResultpageState(getinfo);
  }

}

class _ResultpageState extends State<InitResult> {
  InfoClass napInfo;

  _ResultpageState(InfoClass info){
   napInfo=info;
  }


  @override
  Widget build(BuildContext context){
    final screenSize=MediaQuery.of(context).size;
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(

        appBar: AppBar(

            title:Text("Kết quả tìm kiếm")
        ),
        body:new Container(
          width:screenSize.width,
          height:screenSize.height,
            
          child:FutureBuilder<List<InfoClass>>(
            future: getInfoDetail(this.napInfo),
            builder: (context,snapshot){
              if(snapshot.data!=null)
                {
                  if(snapshot.data.length!=0) {
                     return Container(
                       width:screenSize.width,
                       height:screenSize.height,

                       child: PageView.builder(
                         scrollDirection: Axis.horizontal,
                           itemCount: snapshot.data.length,
                           itemBuilder: (BuildContext context, int index) {
                             //return TablePage(snapshot.data[index]);
                             return Container(
                                 width:400,
                                 height:200,


                                 child:Container(
                                   width:screenSize.width,
                                   height:200,

                                   //color: Color.fromRGBO(85, 102, 215, 0.3),

                                   child: Column(
                                     children: <Widget>[
                                       Padding(
                                         padding: const EdgeInsets.fromLTRB(0, 40, 0, 0),
                                         child: Container(
                                           width: 150,
                                           height: 150,

                                           alignment: AlignmentDirectional.center,
                                           child: Text(snapshot.data[index].Price==null?"0":snapshot.data[index].Price+'\$',style: TextStyle(color: Colors.white,fontSize: 30),),
                                           decoration: BoxDecoration(
                                               color:Colors.blue,
                                               shape: BoxShape.circle
                                           ),
                                         ),
                                       ),
                                       Container(

                                         width:screenSize.width,
                                         child: DataTable(
                                             columns: <DataColumn>[
                                               DataColumn(
                                                 label: Text("Thuộc tính",style: TextStyle(color: Colors.black,fontSize: 18)),

                                               ),
                                               DataColumn(
                                                 label: Text("Giá trị",style: TextStyle(color: Colors.black,fontSize: 18)),
                                               )
                                             ],
                                             rows: <DataRow>[
                                               DataRow(
                                                   cells: <DataCell>[
                                                     DataCell(
                                                       Text("Mã căn hộ",style: TextStyle(color: Colors.black,fontSize: 18)),
                                                     ),
                                                     DataCell(
                                                       Text(snapshot.data[index].Code,style: TextStyle(color:Colors.black,fontSize: 18)),
                                                     )
                                                   ]
                                               )
                                               , DataRow(
                                                   cells: <DataCell>[
                                                     DataCell(
                                                       Text("Số tầng",style: TextStyle(color:Colors.black,fontSize: 18)),
                                                     ),
                                                     DataCell(
                                                       Text(snapshot.data[index].Floor,style: TextStyle(color: Colors.black,fontSize: 18)),
                                                     )
                                                   ]
                                               ),
                                               DataRow(
                                                   cells: <DataCell>[
                                                     DataCell(
                                                       Text("Pass",style: TextStyle(color:Colors.black,fontSize: 18)),
                                                     ),
                                                     DataCell(
                                                       Text(snapshot.data[index].Pass,style: TextStyle(color: Colors.black,fontSize: 18)),
                                                     )
                                                   ]
                                               ),
                                               DataRow(
                                                   cells: <DataCell>[
                                                     DataCell(
                                                       Text("Thông tin quản lý",style: TextStyle(color: Colors.black,fontSize: 18)),
                                                     ),
                                                     DataCell(
                                                       Text(snapshot.data[index].InfoFee,style: TextStyle(color: Colors.black,fontSize: 18)),
                                                     )
                                                   ]
                                               ),

                                             ]),
                                       ),
                                       Container(
                                         child: RaisedButton(onPressed:(){
                                           Navigator.pop(context);
                                         }
                                         ,child: Text("Trở về"),),
                                       )

                                     ],
                                   ),
                                 )
                             );
                           }
                       ),
                     );
                  }else{
                    return Container(
                        width:screenSize.width,
                        height:screenSize.height,
                        alignment: AlignmentDirectional.center,
                        child: Text("Loading...",style: TextStyle(color: Colors.red,fontSize: 20))
                    );
                  }
                }else{
               return Container(
                   width:screenSize.width,
                   height:screenSize.height,
                   alignment: AlignmentDirectional.center,
                   child: Text("Không có dữ liệu trùng khớp",style: TextStyle(color: Colors.red,fontSize: 20))
                );
              }
            },
          )
        )
      ),
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