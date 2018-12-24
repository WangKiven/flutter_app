import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_mode/other/bloc_demo.dart';
import 'package:flutter_mode/other/data_demo.dart';
import 'package:flutter_mode/other/future_builder_demo.dart';
import 'package:flutter_mode/other/json_demo.dart';
import 'package:flutter_mode/other/permission_demo.dart';
import 'package:flutter_mode/other/photo_demo.dart';
import 'package:flutter_mode/other/sqllite_demo.dart';
import 'package:flutter_mode/utils.dart';
import 'package:flutter_mode/zyj/ui/webview.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtherPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var items = {
      '简单数据存储': () => pushMaterial(context, SimpleAccessData()),
      '文件访问': () => pushMaterial(context, AccessFileDemo()),
      '数据缓存和数据共享': () => pushMaterial(context, DataSherePage()),
      'Sqllite': () => pushMaterial(context, SqlLiteDemo()),
      'json': () => pushMaterial(context, JsonDemo()),
      '': () {},
      'StreamBuilder（结合BLoc使用）': () => pushMaterial(context, BLoCDemo()),
      'FutureBuilder': () => pushMaterial(context, FutureBuilderDemo()),
      ' ': () {},
      '拍照图片选择和裁剪功能(用库)': () => pushMaterial(context, PhotoDemoPage()),
      '权限请求（使用库）': () => pushMaterial(context, PermissionDemoPage()),
      '  ': () {},
      '原生交互(以权限请求为例)': () {},
      '后台运行': () {
        // https://flutter.io/docs/development/packages-and-plugins/background-processes
        // https://medium.com/flutter-io/executing-dart-in-the-background-with-flutter-plugins-and-geofencing-2b3e40a1a124
      },
    };

    return ListView.separated(
      itemBuilder: (context, position) {
        var item = items.entries.elementAt(position);
        return ListTile(
          title: Text(item.key),
          onTap: item.value,
          trailing: Icon(Icons.keyboard_arrow_right),
        );
      },
      itemCount: items.length,
      separatorBuilder: (context, position) => Divider(
            height: 1,
          ),
    );
  }
}

class SimpleAccessData extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var items = {
      'sharedPreferences 保存': () {
        SharedPreferences.getInstance().then((prfs) {
          prfs.setString('say', 'I love you!');
          prfs.setInt('age', 18);

          showToast('已保存age和say');
        });
      },
      'sharedPreferences 读取': () async {
        var prefs = await SharedPreferences.getInstance();
        showAlert(
            context, 'age=${prefs.get('age')}, \nsay=${prefs.get('say')}');
      },
      'sharedPreferences 移除': () async {
        var prefs = await SharedPreferences.getInstance();
        prefs.remove('age');

        showToast('已移除age的值，再次读取将age=null');
      },
      '文档：https://flutter.io/docs/cookbook/persistence/key-value': () =>
          pushMaterial(
              context,
              WebViewPage(
                title: 'doc',
                url: 'https://flutter.io/docs/cookbook/persistence/key-value',
              )),
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('数据存储'),
      ),
      body: ListView.separated(
        itemBuilder: (context, position) {
          var item = items.entries.elementAt(position);
          return ListTile(
            title: Text(item.key),
            onTap: item.value,
          );
        },
        itemCount: items.length,
        separatorBuilder: (context, position) => Divider(
              height: 1,
            ),
      ),
    );
  }
}

class AccessFileDemo extends StatelessWidget {
  Future<File> get localFile async {
    final directory = await getApplicationDocumentsDirectory();
    final file = File('${directory.path}/flutterTest.txt');

    return file;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    var items = {
      '保存和追加文件': () async {
        final file = await localFile;

        if (await file.exists()) {
          file.writeAsStringSync('\nI\'m Jack.', mode: FileMode.append);
          file.writeAsString(' Hello world !', mode: FileMode.append);

          showToast('追加数据成功！');
        } else {
          file.writeAsStringSync('Hello Flutter !', mode: FileMode.write);
          file.writeAsString(' I\'m Kiven', mode: FileMode.append);

          showToast('保存成功！');
        }
      },
      '检测文件是否存在': () async {
        final file = await localFile;

        if (await file.exists()) {
          showToast('文件存在！');
        } else {
          showToast('文件不存在！');
        }
      },
      '读取文件': () async {
        final file = await localFile;
        if (await file.exists()) {
          showToast('文件内容：${await file.readAsString()}');
        } else {
          showToast('文件不存在！');
        }
      },
      '删除文件': () async {
        final file = await localFile;

        if (await file.exists()) {
          file.delete();
          showToast('文件已删除！');
        } else {
          showToast('文件不存在！');
        }
      },
    };

    return Scaffold(
      appBar: AppBar(
        title: Text('文件访问'),
      ),
      body: ListView.separated(
        itemBuilder: (context, position) {
          var item = items.entries.elementAt(position);
          return ListTile(
            title: Text(item.key),
            onTap: item.value,
          );
        },
        itemCount: items.length,
        separatorBuilder: (context, position) => Divider(
              height: 1,
            ),
      ),
    );
  }
}
