import 'package:flutter/material.dart';

class SizeManipulator extends StatelessWidget{
  final Color color;
  SizeManipulator({this.color : Colors.black87});
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        width: 22,
        height: 11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          color: color,
        ),
      ),
    );
  }
}