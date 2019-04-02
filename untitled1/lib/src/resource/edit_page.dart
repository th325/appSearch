import 'package:untitled1/src/logical/DBHelper.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:untitled1/src/resource/Infoclass.dart';
class AgrumentList{
  List<DropdownMenuItem<String>>listArea=[];
  List<DropdownMenuItem<String>>listVertex=[];
  List<DropdownMenuItem<String>>listFeature=[];
  List<DropdownMenuItem<String>>listCountRoom=[];
  List<DropdownMenuItem<String>>listDirection=[];

  Future<File> _getLocalFile()async{
    String dir = (await getApplicationDocumentsDirectory()).path;
    return new File('$dir/fileAgru.txt');
  }
  Future<Null>SaveAgru()async{
    String lineArea="",lineVertex="",lineFeature="",lineCountRoom="",lineDirection="";
    for(int i =0;i<listArea.length;i++)
      lineArea+=listArea[i].value.toString()+',';
    for(int i =0;i<listVertex.length;i++)
      lineVertex+=listVertex[i].value.toString()+',';
    for(int i =0;i<listFeature.length;i++)
      lineFeature+=listFeature[i].value.toString()+',';
    for(int i =0;i<listCountRoom.length;i++)
      lineCountRoom+=listCountRoom[i].value.toString()+',';
    for(int i =0;i<listDirection.length;i++)
      lineDirection+=listDirection[i].value.toString()+',';
     await(await _getLocalFile()).writeAsStringSync(lineVertex+'@'+lineArea+'@'+lineFeature+'@'+lineCountRoom+'@'+lineDirection);
  }
  Future<String>LoadAgru()async{
    try {
      String liststr = await(await _getLocalFile())
          .readAsStringSync()
          .toString();
      print(liststr);
      listVertex = [];
      listArea = [];
      listFeature = [];
      listCountRoom = [];
      listDirection = [];
      LoopTask(liststr.split('@')[0], ',', listVertex);
      LoopTask(liststr.split('@')[1], ',', listArea);
      LoopTask(liststr.split('@')[2], ',', listFeature);
      LoopTask(liststr.split('@')[3], ',', listCountRoom);
      LoopTask(liststr.split('@')[4], ',', listDirection);
      for (int i = 0; i < listVertex.length; i++) {
        print(listVertex[i].value + listVertex.length.toString());
      }
      return "true";
    }catch(e){
      return e.toString();
    }
  }
  void theSame(){

  }
  Future<Null>LoopTask(String Str,String charac,List<DropdownMenuItem<String>> listObject){
    List<String>listStr=Str.split(charac);
    for(int i=0;i<listStr.length;i++){
      if(listStr[i]!="")
      listObject.add(new DropdownMenuItem(child: Text(listStr[i]),value: listStr[i],));
    }

  }
  Future<List<DropdownMenuItem<String>>>initSubclass(List<DropdownMenuItem<String>>listObject,String patem)async{
     for(int i=0;i<listObject.length;i++){
       if(listObject[i].value==patem) return listObject;
     }
     listObject.add(new DropdownMenuItem(child: Text(patem),value: patem,));
   return listObject;
  }
}