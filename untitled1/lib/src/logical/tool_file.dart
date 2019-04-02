import 'package:untitled1/src/logical/DBHelper.dart';
import 'package:untitled1/src/logical/readfile.dart';

class ToolFile{
  String _pathfile="";
  testFile tf= new testFile();
  String er;

  String err;
  applyfile(String _path) async{
      _pathfile = _path;
      var dbhelper = DBHelper();
      er=await dbhelper.InsertIntoDB(_pathfile);
      print(er);
      return er;
  }
}