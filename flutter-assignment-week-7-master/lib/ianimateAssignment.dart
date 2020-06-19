import 'dart:math';

import 'package:flutter/material.dart';

const _duration = Duration(milliseconds: 900);

double randomBorderRadius() {
  /**
   * TODO return a random value for radius border
   * HINT: one possible solution can be
   * Random().nextDouble() * 64
   */
  // replace the return below with your code
  return Random().nextDouble() * 64;
}

double randomMargin() {
  /**
   * TODO return a random value for margin
   * HINT: one possible solution can be
   * Random().nextDouble() * 64
   */
  // replace the return below with your code
  return Random().nextDouble() * 64;
}

Color randomColor() {
  /**
   * TODO return a random value for color
   * HINT: one possible solution can be
   * Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
   */
  // replace the return below with your code
  return Color(0xFFFFFFFF & Random().nextInt(0xFFFFFFFF));
}

class AnimatedContainerDemo extends StatefulWidget {
  _AnimatedContainerDemoState createState() => _AnimatedContainerDemoState();
}

class _AnimatedContainerDemoState extends State<AnimatedContainerDemo> {
  Color color;
  double borderRadius;
  double margin;

  @override
  void initState() {
    super.initState();
    color = Colors.deepPurple;
    borderRadius = randomBorderRadius();
    margin = randomMargin();
  }

  void change() {
    try {
      setState(() {
        /**
         * TODO update values for color, borderRadius and margin object
         * HINT: you can use the return values from randomColor(), randomBorderRadius(), and randomMargin()
         * like this:
         * color = randomColor();
         * borderRadius = randomBorderRadius();
         * margin = randomMargin();
         */
          // code here

        color = randomColor();
        borderRadius = randomBorderRadius();
        margin = randomMargin();
      });

    } catch (e, s) {
      print(s);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("demo")),
      body: Center(
        child: Container(
          margin: EdgeInsets.only(top: 50),
          child: Column(
            children: <Widget>[
              SizedBox(
                width: 480,
                height: 480,
                child: AnimatedContainer(
                  /**
                   * TODO use the value of margin object to assign the value of margin
                   * HINT: one possible solution can be
                   * margin: EdgeInsets.all(margin*4),
                   */
                   // code here
                  margin: EdgeInsets.all(margin * 4),
                  decoration: BoxDecoration(
                    /**
                     * TODO use the value color object as color paramter
                     * HINT: apply the following code
                     * color: color,
                     */
                    // code here

                    color: color,
                    /**
                     * TODO use the value of borderRadius for applying radius to circular borders
                     * HINT: one possible solution can be
                     * borderRadius: BorderRadius.circular(borderRadius),
                     */
                    //code here
                    borderRadius: BorderRadius.circular(borderRadius)
                  ),
                  duration: _duration,
                ),
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                child: Text(
                  'change',
                  style: TextStyle(color: Colors.white),
                ),
                /**
                 * TODO call change() function when user performs click.
                 * HINT: you can use following logic
                 * onPressed: () => change(),
                 */
                onPressed: () => change(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedContainerDemo(),
    );
  }
}

void main() {
  runApp(
    MyApp(),
  );
}
