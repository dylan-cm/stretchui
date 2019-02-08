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
      home: Scaffold( //TODO: move to artboard screen file
        body: Center(
          child: StretchyBox(
            extPadding:extPadding, 
            intPadding:intPadding,
            width: width,
            height: height,
          ),
        )
      )
    );
  }
}

class StretchyBox extends StatelessWidget{
  final double extPadding, intPadding, width, height;
  //TODO: add in parent widget with abstract class to pass in gesture detector
  //TODO: add in suppport for passing a child like an image, video, or button
  StretchyBox({
    this.extPadding:0, 
    this.intPadding:0, 
    this.width:100, 
    this.height:100
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}