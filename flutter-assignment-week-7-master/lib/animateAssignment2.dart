import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

/**
 * This part of assignment cover explicit animation part.
 * APP with animations
 */

class AnimatedLogo extends AnimatedWidget {
  // Make the Tweens static because they don't change.
  static final _opacityTween = Tween<double>(begin: 0.1, end: 1);
  static final _sizeTween = Tween<double>(begin: 0, end: 300);

  AnimatedLogo({Key key, Animation<double> animation})
      : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    return Center(
      child: Opacity(
        /**
         * TODO add opacityTween evaluate value to opacity
         * HINT: use following code.
         * opacity: _opacityTween.evaluate(animation),
         */
          // code here
        
        opacity: _opacityTween.evaluate(animation),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          /**
           * TODO add sizeTween evaluation to height value
           * HINT use following code
           * height: _sizeTween.evaluate(animation),
           */
          // code here
          height: _sizeTween.evaluate(animation),
          /**
           * TODO add sizeTween evaluation to width value
           * HINT use following code
           * width: _sizeTween.evaluate(animation),
           */
           //code here
          width: _sizeTween.evaluate(animation),
          child: FlutterLogo(),
        ),
      ),
    );
  }
}

class LogoApp extends StatefulWidget {
  _LogoAppState createState() => _LogoAppState();
}

class _LogoAppState extends State<LogoApp> with SingleTickerProviderStateMixin {
  Animation<double> animation;
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(duration: const Duration(seconds: 3), vsync: this);
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          controller.forward();
        }
      });
    controller.forward();
  }

  @override
  Widget build(BuildContext context) => AnimatedLogo(animation: animation);

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}

void main() => runApp(LogoApp());