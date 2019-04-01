import 'dart:io';
import 'dart:convert';
import 'dart:async';
class testFile{
  void TestFile(String path)async{
    File myCsvFile = new File(path);
    print(await myCsvFile.readAsString(encoding: utf8));
    Stream<List> inputStream = myCsvFile.openRead();
    inputStream.transform(utf8.decoder)
        .transform(new LineSplitter())
        .listen((String line){
      List row=line.split(',');
      String Vertext = row[0];
      String Code = row[1];
      String Area = row[2];
      String Feature = row[3];
      String Price = row[4];
      String Floor = row[5];
      String CountRoom = row[6];
      String Direction = row[7];
      String Pass = row[8];
      String InfoFee = row[9];
      print('$Direction');
    });
    onDone: () { print('File is now closed.'); };
    onError: (e) { print(e.toString()); };
  }
}