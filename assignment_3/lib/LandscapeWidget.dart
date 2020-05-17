import 'package:flutter/material.dart';

import 'DetailWidget.dart';
import 'ListWidget.dart';

class LandscapeWidget extends StatefulWidget {
  @override
  LandscapeWidgetState createState() {
    return LandscapeWidgetState();
  }
}

class LandscapeWidgetState extends State<LandscapeWidget> {
  var selectedValue = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(), body: buildLandscapeLayout(context));
  }

  Widget buildLandscapeLayout(BuildContext context) {
    return Flex(direction: Axis.horizontal, children: <Widget>[
      Expanded(
        flex: 30,
        child: ListWidget(10, (value) {
          selectedValue = value;
          setState(() {});
        }),
      ),
      Expanded(flex: 70, child: DetailWidget(selectedValue))
    ]);
  }
}
