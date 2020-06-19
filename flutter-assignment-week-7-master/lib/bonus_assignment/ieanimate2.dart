import 'package:flutter/material.dart';
import 'package:flutter_xlider/flutter_xlider.dart';

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
  double sliderValue = 100;
  Color beginColor = Colors.white;
  Color endColor = Colors.red;

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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              getTweenAnimationWidget(),
              getColorSlider()
            ],
          )),
    );
  }

  Widget getTweenAnimationWidget() {
    return TweenAnimationBuilder(
        tween: ColorTween(begin: beginColor, end: endColor),
        duration: Duration(seconds: 5),
        builder: (context, Color color, _) {
          return ColorFiltered(
            child: Image.asset('assets/sunflr.png'),
            colorFilter: ColorFilter.mode(color, BlendMode.modulate),
          );
        });
  }

  Widget getColorSlider() {
    return FlutterSlider(
        min: 0,
        max: 100,
        values: [sliderValue],
        onDragging: (index, lowerValue, upperValue){
            updateState(lowerValue);
        });
        //onChanged: (value) => updateState);
  }

  void updateState(double value) {
    setState(() {
      sliderValue = value;
      beginColor = endColor;
      endColor = Color.fromARGB(255, (255), getColorsValue(value), getColorsValue(value));
    });
  }

  int getColorsValue(double value){
    return ((1 - (value/100)) * 255).toInt();
  }
}
