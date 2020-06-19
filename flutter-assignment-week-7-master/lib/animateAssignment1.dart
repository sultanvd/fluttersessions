import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

/**
 * This part of assignment cover explicit animation part.
 * APP with animations
 */
void main() => runApp(LogoApp());

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

/**
 * TODO give the following class implimentation of SingleTickerProviderStateMixin
 *
 * HINT: by using following code
 * with SingleTickerProviderStateMixin
 */
class _LogoAppState extends State<LogoApp>
    with SingleTickerProviderStateMixin /* code here*/ {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();

    /**
     * TODO create instance of AnimationController
     * HINT: you can use following code
     * AnimationController(duration: ... , vsync: ...)
     *
     * TODO pass SingleTickerProviderStateMixin refrence as vsync parameter in animation controller object
     * HINT: you can apply following code
     * vsync: this
     *
     * TODO pass Duration object as duration parameter in animation controller object
     * HINT: you can use following code
     * duration: const Duration(seconds: someIntValue)
     *
     * TODO assign AnimationControllerObject to controller variable.
     * controller = AnimationController(duration: ... , vsync: ...)
     */
    //controller = // code here
    controller =
        AnimationController(duration: Duration(seconds: 5), vsync: this);

    // #docregion addListener
    try {
      animation = Tween<double>(begin: 20, end: 300).animate(controller)
        ..addListener(() {
          // #enddocregion addListener
          setState(() {
            // The state that has changed here is the animation object’s value.
          });
          // #docregion addListener
        })
        ..addStatusListener((status) {
          /**
           * TODO check if animation status is completed
           * HINT you can apply following logic
           * if (status == AnimationStatus.completed){
           * ..
           * }
           */
          // replace the condition below with your code
          if (status == AnimationStatus.completed) {
            /**
             * TODO call controller.reverse()
             */
            // code here
            controller.reverse();
          }
          /**
           * TODO check else if animation status is completed
           * HINT you can apply following logic
           * else if (status == AnimationStatus.dismissed){
           * .....
           * }
           */

          // replace the condition below with your code
          else if (status == AnimationStatus.dismissed) {
            /**
             * TODO call controller.forward()
             */
            // code here
            controller.forward();
          }
        });
    } catch (e, s) {
      print(s);
    }
    /**
     * TODO call controller.forward()
     */
    // code here
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        height: animation.value,
        width: animation.value,
        child: FlutterLogo(),
      ),
    );
  }

  @override
  void dispose() {
    /**
     * TODO dispose controller
     * by calling controller.dispose()
     */
    // code here
    controller.dispose();
    /**
     * TODO call supper to dispose
     */
    //code here
    super.dispose();
  }
}
