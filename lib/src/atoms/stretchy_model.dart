import 'package:flutter/material.dart';

class StretchyModel{
  StretchyModel(
    this.width, 
    this.height, 
    this.extPadding, 
    this.intPadding, 
    this.x,
    this.y,
    this.color,
    this.id,
    this.layerColor,
    this.pixelWidth,
    this.pixelHeight,
    this.pixelX,
    this.pixelY,
  );

  StretchyModel.start({
    this.width = 0.25, 
    this.height = 0.25, 
    this.extPadding = 0, 
    this.intPadding = 0, 
    this.x = 0.375,
    this.y = 0.375,
    this.color = Colors.grey,
    @required this.id,
    this.layerColor = Colors.cyanAccent,
    @required this.pixelWidth,
    @required this.pixelHeight,
    @required this.pixelX,
    @required this.pixelY,
  });
  ///A helper function to set any property of the model without
  ///having to input the rest as only non-null parameters are changed.
  StretchyModel alter({
    double width, 
    double height, 
    double extPadding, 
    double intPadding,
    double x,
    double y,
    Color color,
    int id,
    Color layerColor,
    double pixelWidth,
    double pixelHeight,
    double pixelX,
    double pixelY,
    }){
    return StretchyModel(
      width ?? this.width, 
      height ?? this.height, 
      extPadding ?? this.extPadding, 
      intPadding ?? this.intPadding, 
      x ?? this.x,
      y ?? this.y,
      color ?? this.color,
      id ?? this.id,
      layerColor ?? this.layerColor,
      pixelWidth ?? this.pixelWidth,
      pixelHeight ?? this.pixelHeight,
      pixelX ?? this.pixelX,
      pixelY ?? this.pixelY,
    );
  }
  ///Properties that use points(pt) as scalors of screen size
  final double width, height, x, y;
  ///Properties that use pixels(px)
  final double pixelWidth, pixelHeight, pixelX, pixelY, extPadding, intPadding;
  ///Primary color for this and the layer color for the frame
  final Color color, layerColor;
  ///Unique Id of this
  final int id;
}