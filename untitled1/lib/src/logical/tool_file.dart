import 'package:untitled1/src/logical/DBHelper.dart';
import 'package:untitled1/src/logical/readfile.dart';

class ToolFile{
  String _pathfile="";
  testFile tf= new testFile();
  void applyfile(String _path){
    _pathfile=_path;
    var dbhelper = DBHelper();
    dbhelper.InsertIntoDB(_pathfile);
    print("insert success");
  }
}