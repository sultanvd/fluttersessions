import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

/**
 * This part of assignment cover custom implicit animation part.
 * APP with animations
 */
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
  double targetValue = 60;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
          child: TweenAnimationBuilder(
            /**
             * TODO pass targetValue as the initial value for end parameter to tween object.
             */
        tween: Tween<double>(begin: 0, end: targetValue),
        duration: Duration(seconds: 4),
        builder: (context, size, _) {
          return Transform.rotate(
              /**
               * TODO use size to manipulate angle
               * HINT one possible way to manipulate size value for angle is
               * angle: size % (2 * math.pi),
               * */
              // code here
              angle: size % (2 * math.pi),
              child: IconButton(
                /**
                 * TODO use size to manipulate iconsize
                 * HINT one possible way to manipulate size value for angle is
                 * iconSize: size % (2 * math.pi)
                 */
                // code here
                iconSize: 100,
                icon: Icon(Icons.rotate_right),
                /**
                 * Following code will get triggered when user click the icon object
                 */
                onPressed: () {
                  setState(() {
                    /**
                     * TODO change target value in such a way which creates a loop
                     * HINT: one possible solution for the problem is
                     * targetValue = targetValue == 360 ? 60 : 360;
                     */
                    targetValue = targetValue == 360 ? 60 : 360;
                  });
                },
              ));
        },
      )),
    );
  }
}
