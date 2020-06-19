import 'package:flutter/material.dart';

class FadeInDemo extends StatefulWidget {
  _FadeInDemoState createState() => _FadeInDemoState();
}

class _FadeInDemoState extends State<FadeInDemo> {
  double opacityLevel = 0.0;
  double picopacityLevel = 0.0;
  @override
  Widget build(BuildContext context) {
    return Column(children: <Widget>[
      MaterialButton(
          color: Colors.blue,
          child: Text(
            'Show Pic',
            style: TextStyle(color: Colors.white, fontSize: 20.0),
          ),
          onPressed: () => setState(() {
            picopacityLevel = 1.0;
              })),
      MaterialButton(
        child: Text(
          'Show details',
          style: TextStyle(color: Colors.blueAccent),
        ),
        onPressed: () => setState(() {
          opacityLevel = 1.0;
        }),
      ),
      AnimatedOpacity(
          duration: new Duration(seconds: 5),
          opacity: picopacityLevel,
          child:Image.asset('assets/owl.jpg')),
      AnimatedOpacity(
        duration: Duration(seconds: 4),
        opacity: opacityLevel,
        child: Column(
          children: <Widget>[
            Text('Type: Owl'),
            Text('Age: 39'),
            Text('Employment: None'),
          ],
        ),
      )
    ]);
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: Text('Implicit Animation')),
        body: Center(
          child: FadeInDemo(),
        ),
      ),
    );
  }
}

void main() {
  runApp(
    MyApp(),
  );
}
