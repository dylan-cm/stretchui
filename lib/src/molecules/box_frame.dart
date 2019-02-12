import 'package:flutter/material.dart';
import '../atoms/width_manipulator.dart';
import '../atoms/height_manipulator.dart';

class BoxFrame extends StatelessWidget {
  final double width, height;
  final Color color;
  //TODO: implement padding manipulation
  BoxFrame({
    this.width:100, 
    this.height:100,
    this.color:Colors.cyanAccent,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          width: width,//+44,
          height: height,//+44,
        ),
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: color),
          ),
        ),
        Positioned(
          top: 0,
          child: HeightManipulator.top(color: color,),
        ),
        Positioned(
          right: 0,
          child: WidthManipulator.right(color: color,),
        ),
        Positioned(
          bottom: 0,
          child: HeightManipulator.bottom(color: color,),
        ),
        Positioned(
          left: 0,
          child: WidthManipulator.left(color: color,),
        ),
      ]
    );
  }
}