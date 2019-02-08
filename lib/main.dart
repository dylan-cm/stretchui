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
    return Stack(
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          alignment: AlignmentDirectional.center,
          color: Theme.of(context).primaryColorLight,
          padding: EdgeInsets.all(extPadding),
          width: width+extPadding*2,
          height: height+extPadding*2,
            child: Container(
            alignment: AlignmentDirectional.center,
            // color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(intPadding),
            width: width,
            height: height,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              // border: Border.all()
            ),
            child: Container(
              alignment: AlignmentDirectional.center,
              color: Theme.of(context).primaryColorDark,
              //This is where a child would go instead 
            )
          )
        ),
        BoxFrame(
          width: width,
          height: height,
        ),
      ]
    );
  }
}

class BoxFrame extends StatelessWidget {
  final double extPadding, intPadding, width, height;
  //TODO: implement padding manipulation
  BoxFrame({
    this.extPadding:0, 
    this.intPadding:0, 
    this.width:100, 
    this.height:100
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        border: Border.all(),
      ),
    );
  }
}