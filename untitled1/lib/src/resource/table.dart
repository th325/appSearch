import 'package:flutter/material.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
class TablePage extends StatefulWidget{
  InfoClass info;
  TablePage(InfoClass data){
    info=data;
  }

  _TablePageState createState()=>new _TablePageState(info);
}
class _TablePageState extends State<TablePage> {
  InfoClass infos = new InfoClass();

  _TablePageState(InfoClass info){
    infos=info;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      home:Scaffold(
        appBar: AppBar(title: Text("Table"),),
        body: Container(
          width: double.infinity,
          height: double.infinity,
          child:Container(
            width: double.infinity,
            //color: Color.fromRGBO(85, 102, 215, 0.3),
            child: Column(
              children: <Widget>[
                Container(
                  width: 150,
                  height: 150,
                  alignment: AlignmentDirectional.center,
                  child: Text(infos.Price==null?"0":infos.Price+'\$',style: TextStyle(color: Colors.white,fontSize: 30),),
                  decoration: BoxDecoration(
                    color:Colors.blue,
                    shape: BoxShape.circle
                  ),
                ),
                Container(
                  width: double.infinity,
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
                              Text("databaseCel2",style: TextStyle(color:Colors.black,fontSize: 18)),
                            )
                          ]
                        )
                        , DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Text("Số tầng",style: TextStyle(color:Colors.black,fontSize: 18)),
                              ),
                              DataCell(
                                Text("databaseCel2",style: TextStyle(color: Colors.black,fontSize: 18)),
                              )
                            ]
                        ),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Text("Pass",style: TextStyle(color:Colors.black,fontSize: 18)),
                              ),
                              DataCell(
                                Text("databaseCel2",style: TextStyle(color: Colors.black,fontSize: 18)),
                              )
                            ]
                        ),
                        DataRow(
                            cells: <DataCell>[
                              DataCell(
                                Text("Thông tin quản lý",style: TextStyle(color: Colors.black,fontSize: 18)),
                              ),
                              DataCell(
                                Text("databaseCel2",style: TextStyle(color: Colors.black,fontSize: 18)),
                              )
                            ]
                        ),

                      ]),
                ),
              ],
            ),
          )
        ),
      )

    );
  }
}