import 'package:flutter/material.dart';
import '../atoms/size_manipulator.dart';

class BoxFrame extends StatelessWidget {
  final double extPadding, intPadding, width, height;
  final Color color;
  //TODO: implement padding manipulation
  BoxFrame({
    this.extPadding:0, 
    this.intPadding:0, 
    this.width:100, 
    this.height:100,
    this.color:Colors.black87,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      alignment: AlignmentDirectional.center,
      children: <Widget>[
        Container(
          width: width,
          height: height,
          decoration: BoxDecoration(
            border: Border.all(color: color),
          ),
        ),
        Positioned(
          top: -5,
          child: SizeManipulator(color: color,),
        ),
        Positioned(
          right: -5,
          child: RotatedBox(
            quarterTurns: 1,
            child: SizeManipulator(color: color,),
          )
        ),
        Positioned(
          left: -5,
          child: RotatedBox(
            quarterTurns: 3,
            child: SizeManipulator(color: color,),
          )
        ),
        Positioned(
          bottom: -5,
          child: RotatedBox(
            quarterTurns: 2,
            child: SizeManipulator(color: color,),
          )
        ),
      ]
    );
  }
}