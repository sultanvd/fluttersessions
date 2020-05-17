import 'package:flutter/material.dart';

import 'DetailWidget.dart';
import 'ListWidget.dart';

class PortaitScreenWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PortaitScreenState();
  }
}

class PortaitScreenState extends State<PortaitScreenWidget> {
  int itemIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Week 3 Assignment",
          textDirection: TextDirection.ltr,
        ),
      ),
      drawer: getDrawerWidget(context),
      body: getWidgetForBody(itemIndex),
    );
  }

  Widget getDrawerWidget(BuildContext context) {
    return Drawer(
      child: ListWidget(10, (value){
        updateState(value);
        Navigator.pop(context);
      }));
  }

  Widget getWidgetForBody(value) {
    return DetailWidget(value);
  }

  void updateState(value) {
    setState(() {
      itemIndex = value;
    });
  }
}
