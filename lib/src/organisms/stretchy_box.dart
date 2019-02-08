import 'package:flutter/material.dart';
import '../molecules/box_frame.dart';

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
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(intPadding),
            width: width,
            height: height,
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