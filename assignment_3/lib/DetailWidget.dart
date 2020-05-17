import 'package:flutter/material.dart';

class DetailWidget extends StatefulWidget {
  final int data;

  DetailWidget(this.data);

  @override
  _DetailWidgetState createState() => _DetailWidgetState();
}

class _DetailWidgetState extends State<DetailWidget> {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            getImageWidget(constraints),
            getTextWidget(constraints)
          ],
        );
      },
    );
  }

  Widget getImageWidget(BoxConstraints constraints) {
    var size = constraints.maxHeight > constraints.maxWidth
        ? constraints.maxWidth
        : constraints.maxHeight / 1.5;
    BoxFit fit = constraints.maxHeight > constraints.maxWidth
        ? BoxFit.fitWidth
        : BoxFit.fitHeight;
    return FittedBox(
      fit: fit,
      child: Icon(
        Icons.account_circle,
        color: Colors.blue,
        size: size,
      ),
    );
  }

  Widget getTextWidget(BoxConstraints constraints) {
    return Container(
        width: constraints.maxWidth / 2,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        child:
        Padding(
            padding: EdgeInsets.only(left: 15, right: 15, top: 5, bottom: 5),
            child: FittedBox(
              fit: BoxFit.fitWidth,
              child: Text(
                "VentureDive",
                style: TextStyle(color: Colors.white),
              ),
            )));
  }
}
