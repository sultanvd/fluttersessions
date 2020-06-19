import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Implicit Animation'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: TweenAnimationBuilder(
        tween: Tween<double>(begin: 0, end: 2 * math.pi),
        duration: Duration(seconds: 5),
        builder: (context, ang, _) {
          return Transform.rotate(
            angle: ang,
            child: Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(30),
              child: Image.asset(
                'assets/earth.png',
              ),
            ),
          );
        },
      )),
    );
  }
}
