import 'package:flutter/material.dart';

class Param{
  final double width, height, extPadding, intPadding;
  final Color color;
  Param oldParam;

  Param(this.width, this.height, this.extPadding, this.intPadding, this.color);
  Param.start({
    this.width:100, 
    this.height:100, 
    this.extPadding:0, 
    this.intPadding:0, 
    this.color:Colors.white
  });

  Param alter({
    double width, 
    double height, 
    double extPadding, 
    double intPadding
    }){
    return new Param(
      width ?? this.width, 
      height ?? this.height, 
      extPadding ?? this.extPadding, 
      intPadding ?? this.intPadding, 
      color ?? this.color,
    );
  }
}