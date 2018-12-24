import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

showAlert(BuildContext context, String say) {
//    showAboutDialog(context: context, children: <Widget>[Text('sa')]);
  /*showGeneralDialog(context: context, pageBuilder: (context, an1, an2){
      return Text(say);
    });*/
  showDialog(
      context: context,
      builder: (context) => Center(
            child: Text(
              say,
              style: TextStyle(
                  fontSize: 15,
                  color: Colors.green,
                  decoration: TextDecoration.none),
            ),
          ),
      barrierDismissible: true);
}

Future<SharedPreferences> getSharedPreferences() async{
  return SharedPreferences.getInstance();
}

showToast(String text) => Fluttertoast.showToast(msg: text);

pushMaterial(BuildContext context, Widget page) {
  Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

Future<File> getFile(String subPathName, {bool isExternal = false}) async {
  final directory = isExternal
      ? (await getExternalStorageDirectory())
      : (await getApplicationDocumentsDirectory());
  final file = File('${directory.path}/subPathName');

  return file;
}
