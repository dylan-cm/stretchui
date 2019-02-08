import 'package:flutter/material.dart';
import 'organisms/stretchy_box.dart';

class App extends StatefulWidget{
  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
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
          ),
        )
      )
    );
  }
}