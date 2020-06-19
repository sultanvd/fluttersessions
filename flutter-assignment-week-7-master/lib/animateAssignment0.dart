import 'package:flutter/material.dart';


/**
 * This part of assignment cover explicit animation part.
 * APP without animations
 */
void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        /**
         * TODO Enter margins for Flutter LOGO.
         * HINT: you can use library function
         * margin: EdgeInsets.symmetric(vertical: marginValue)
         * where marginValue can have following sample values {10, 20, 30, 50}
         */
        // Enter your code here
      margin: EdgeInsets.symmetric(vertical: 50, horizontal: 40),

        /**
         * TODO Enter the value of height for flutter logo
         * HINT: you can code like
         * height: someValue
         */
        // Enter your code here
        height: 150,

        /**
         * TODO Enter the value of width for flutter logo
         * HINT: you can code like
         * width: someValue
         */
        // Enter your code here
        width: 150,

        child: FlutterLogo(),
      ),
    );
  }
}