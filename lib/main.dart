import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/*void main() => runApp(new Center(
      child: new Text(
        'Hello flutter!',
        textDirection: TextDirection.ltr,
      ),
    ));*/

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter示例主页'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class Point {
  Point(this.x, this.y);

  Point.fromXy(num n) {
    x = n;
    y = n;
  }

  num x;
  num y;
  num z = 0;

  num get a => z;

  set a(num value) => z = value;
}

class Line {}

class Point2D extends Point with Line {
  Point2D(num x, num y) : super(x, y);
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });

    var name = 'bob';
    print('name = ' + name);

    int age;

    print('age = ' + age.toString());

    final type = 9;
    const int sys = 7;

    var list = []; // [] 创建的是一个空的list集合
    list.add(5);
    list.add('4');

    list = const []; //const []创建一个空的、不可变的列表
//    list.add(5);

    list = [3, 4, 6];
    print(list);

    var point = new Point(1, 2);
    var p2 = Point.fromXy(4);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              '你点击按钮的次数:',
              style: Theme.of(context).textTheme.display1,
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
            TextField(),
            RaisedButton(
              onPressed: () {
                _next(context);
              },
              child: Text('next'),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _next(BuildContext context) async {
    final result = await Navigator.push(
        context,
        new MaterialPageRoute(
            builder: (context) => new SecondScreen(
                  count: _counter,
                )));

    showDialog(context: context, child: Center(child: Text('${result == null? 'No data': result}')));


    final response =
    await http.get('https://jsonplaceholder.typicode.com/posts/1');
  }
}

class SecondScreen extends StatelessWidget {
  final int count;

  SecondScreen({Key key, this.count = 0}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Second screen'),
      ),
      body: new Center(
        child: new RaisedButton(
          onPressed: () {
            Navigator.pop(context, 'Hello NO.$count');
          },
          child: Text('Go back $count'),
        ),
      ),
    );
  }
}
