import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NotificationShow{
  Future<bool>Conform(BuildContext context,String str){
    return showDialog(context: context,
        builder: (BuildContext context){
          return new AlertDialog(
            title: Text(str),
            actions: <Widget>[
              new FlatButton(onPressed:(){Navigator.pop(context);}, child: Text("Oke"))
            ],
          );
        }
    );
  }
}