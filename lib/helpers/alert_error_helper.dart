import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AlertErrorHelper {
  static Future<void> showDialogError(
      BuildContext ctx, PlatformException error) async {
    
    return showDialog(
      context: ctx,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(error.code),
          content: new Text(error.message),
          actions: <Widget>[
           
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
