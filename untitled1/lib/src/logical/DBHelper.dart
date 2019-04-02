import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/src/material/dropdown.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
import 'package:path/path.dart';
import 'dart:convert';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:csv/csv.dart';
import 'package:untitled1/src/resource/edit_page.dart';
class DBHelper{

  final String TABLE_NAME="Data";
  static Database db_instance;
  static Database db_agru;
  AgrumentList agrumentList = new AgrumentList();

  Future<Database> get db async{
     if (db_instance==null)
       db_instance=await initDB();
     return db_instance;
  }
  initDB() async{
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path,"database01.db");
    var db = await openDatabase(path,version: 1,onCreate:onCreateFuncSaveInfo);
    return db;
  }
  void onCreateFuncSaveInfo(Database db,int version ) async{
    print("XONG");
    await db.execute('CREATE TABLE $TABLE_NAME(id INTEGER PRIMARY KEY AUTOINCREMENT,'
        'VerTex TEXT,'
        'Code TEXT,'
        'Area TEXT,'
        'Price TEXT,'
        'Direction TEXT,'
        'CountRoom TEXT,'
        'Feature TEXT,'
        'Floor TEXT,'
        'Pass TEXT,'
        'InfoFee TEXT);');
  }
  Future<String> InsertIntoDB(String pathfile)async{
    try {
      var db_conection = await db;
      final mydata = await rootBundle.loadString(pathfile);

      List<List<dynamic>> listdata = CsvToListConverter().convert(mydata);
      await db_conection.rawDelete('DELETE  FROM $TABLE_NAME');
      for (int i = 0; i < listdata.length; i++) {
        InfoClass info = new InfoClass(null);
        info.Vertex = listdata[i][0];
        info.Code = listdata[i][1];
        info.Area = listdata[i][2];
        info.Feature = listdata[i][3];
        info.Price = listdata[i][4];
        info.Floor = listdata[i][5];
        info.CountRoom = listdata[i][6];
        info.Direction = listdata[i][7];
        info.Pass = listdata[i][8];
        info.InfoFee = listdata[i][9];
        agrumentList.initSubclass(agrumentList.listVertex, info.Vertex);
        agrumentList.initSubclass(agrumentList.listArea, info.Area.toString());
        agrumentList.initSubclass(
            agrumentList.listCountRoom, info.CountRoom.toString());
        agrumentList.initSubclass(agrumentList.listDirection, info.Direction);
        agrumentList.initSubclass(agrumentList.listFeature, info.Feature);

        await db_conection.rawInsert(
            'INSERT INTO $TABLE_NAME(VerTex,Code,Area,Feature,Price,Floor,CountRoom,Direction,Pass,InfoFee)VALUES(?,?,?,?,?,?,?,?,?,?)',
            [
              info.Vertex,
              info.Code,
              info.Area,
              info.Feature,
              info.Price,
              info.Floor,
              info.CountRoom,
              info.Direction,
              info.Pass,
              info.InfoFee,
            ]);
      }
      agrumentList.SaveAgru();
      agrumentList.LoadAgru();
      return "true";
    }catch(e){
      return e.toString();


    }
  }
  Future<List<InfoClass>> getInfoAll() async{
    var db_conection = await db;

    List<Map> list = await db_conection.rawQuery("SELECT * FROM $TABLE_NAME");
    List<InfoClass> infos = new List();

    for (int i = 0;i<list.length;i++){
      InfoClass info  = new InfoClass(null);
      info.Vertex = list[i]['VerTex'];
      info.Code=list[i]['Code'];
      info.Price = list[i]['Price'];
      info.Area=list[i]['Area'];
      info.CountRoom=list[i]['CountRoom'];
      info.Direction=list[i]['Direction'];
      info.Feature=list[i]['Feature'];
      info.Floor=list[i]['Floor'];
      info.InfoFee=list[i]['InfoFee'];
      info.Pass=list[i]['Pass'];
      infos.add(info);

    }
    return infos;
  }
  Future<List<InfoClass>> getInfo(InfoClass info)async{
    var db_connection=await db;
   //[info.Vertex,info.Area,info.Direction,info.Price,info.CountRoom,info.Feature]
    List<Map> list = await db_connection.rawQuery('SELECT * FROM $TABLE_NAME WHERE '
        'VerTex=? and '
        'Area=? and '
        'Direction=? and '
        'CountRoom=? and '
        'Feature=?',[info.Vertex,info.Area,info.Direction,info.CountRoom,info.Feature]);
    print("satart2");
    print([info.Vertex,info.Area,info.Direction,info.CountRoom,info.Feature]);
    print("start3");
    List<InfoClass> infos = new List();
    for (int i = 0;i<list.length;i++){
      InfoClass info  = new InfoClass(null);
      info.Vertex = list[i]['VerTex'];
      info.Code = list[i]['Code'];
      info.Price = list[i]['Price'];
      info.Area=list[i]['Area'];
      info.CountRoom=list[i]['CountRoom'];
      info.Direction=list[i]['Direction'];
      info.Feature=list[i]['Feature'];
      info.Floor=list[i]['Floor'];
      info.InfoFee=list[i]['InfoFee'];
      info.Pass=list[i]['Pass'];
      infos.add(info);
    }

     if (infos.length==0){
      return null;
    };
     return infos;
  }
}
/*
* class InfoClass{
  var Vertex;
  var Area;
  var Price;
  var Direction;
  var CountRoom;
  var Feature;
  var Floor;
  var Pass;
  var InfoFee;
}
* */