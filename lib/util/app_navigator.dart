


import 'package:flutter/material.dart';


class AppNavigator { 

  static push(BuildContext context, Widget scene) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ),
    );
  }
  
  static pushReplacement(BuildContext context, Widget scene) {
     Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => scene,
        )
    );
  }

  static pushAndRemoveUntil(BuildContext context, Widget scene) {
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => scene,
      ), (route) => route == null
    );
  }

  static pushResult(BuildContext context, Widget scene, Function(Object) function) {
    Navigator.push(
      context, 
      MaterialPageRoute(builder: (BuildContext context) => scene),
      ).then((result) {
        if(result == null) {
          return;
        }
        function(result);
      }).catchError((error) {
        print('$error');
      });
  }

  static void goBack(BuildContext context) {
    Navigator.pop(context);
  }

  static void goBackWithParams(BuildContext context, result) {
    Navigator.pop(context, result);
  }

}