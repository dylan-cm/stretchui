import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget{
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  double extPadding, intPadding, width, height;

  void initState() { 
    extPadding = intPadding = 10.0;
    width = height = 200.0;
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          alignment: AlignmentDirectional.center,
          color: Theme.of(context).primaryColorLight,
          padding: EdgeInsets.all(extPadding),
          width: width+extPadding,
          height: height+extPadding,
            child: Container(
            alignment: AlignmentDirectional.center,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(intPadding),
            width: width,
            height: height,
            child: Container(
              alignment: AlignmentDirectional.center,
              color: Theme.of(context).primaryColorDark,
              padding: EdgeInsets.all(intPadding),
              width: width-intPadding,
              height: height-intPadding,
            )
          ),
        ),
      )
    );
  }
}

// class StretchyBox(double extPadding, intPadding, width, height){}