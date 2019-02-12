import 'package:flutter/material.dart';

class Param{
  final double width, height, extPadding, intPadding, x, y;
  final Color color;
  Param oldParam;

  Param(
    this.width, 
    this.height, 
    this.extPadding, 
    this.intPadding, 
    this.color,
    this.x,
    this.y
  );

  Param.start({
    this.width:0.25, 
    this.height:0.25, 
    this.extPadding:0, 
    this.intPadding:0, 
    this.color:Colors.white,
    this.x:0.5-0.25/2,
    this.y:0.5-0.25/2,
  });

  Param alter({
    double width, 
    double height, 
    double extPadding, 
    double intPadding,
    double x,
    double y,
    }){
    return new Param(
      width ?? this.width, 
      height ?? this.height, 
      extPadding ?? this.extPadding, 
      intPadding ?? this.intPadding, 
      color ?? this.color,
      x ?? this.x,
      y ?? this.y,
    );
  }
}