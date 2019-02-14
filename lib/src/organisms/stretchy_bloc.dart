import 'dart:math' as math;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../atoms/param.dart';
import '../bloc_provider.dart';
export '../atoms/param.dart';

class StretchyBloc extends BlocBase{
  StretchyBloc(this.screen);

  final BehaviorSubject<Param> _paramSubject = BehaviorSubject<Param>(seedValue: Param.start());
  final Size screen;
  //TODO: padding exterior and interior setters
  //TODO: rotation

  //Getters
  ValueObservable<Param> get paramStream => _paramSubject.stream;
  double get width => _abs(paramStream.value.width);
  double get height => _abs(paramStream.value.height);
  double get x => paramStream.value.x;
  double get y => paramStream.value.y;
  double get intPadding => paramStream.value.intPadding;
  double get extPadding => paramStream.value.extPadding;
  //Setters
  Function(double, bool) get setWidth => (double dx, bool right) {
    final double dw = dx/screen.width;
    final List<double> result = _setDimension(dw, paramStream.value.width, x, right);
    _paramSubject.sink.add( paramStream.value.alter(width: result[0]) );
    updatePosition(Offset(result[1], 0));
  };
  Function(double, bool) get setHeight => (double dy, bool bottom) {
    final double dh = dy/screen.height;
    final List<double> result = _setDimension(dh, paramStream.value.height, y, bottom);
    _paramSubject.sink.add( paramStream.value.alter(height: result[0]) );
    updatePosition(Offset(0, result[1]));
  };
  Function() get endResize => (){
    _paramSubject.sink.add(
      paramStream.value.alter(
        width: _abs(_paramSubject.stream.value.width), 
        height: _abs(_paramSubject.stream.value.height) 
      )
    );
  };
  Function(Offset) get updatePosition => (Offset offset) {
    //Set new positions to variables
    final double newX = offset.dx + x;
    final double newY = offset.dy + y;
    //Check to keep box on screen, if so update position
    if(0 <= newX && newX <= (1-width) )
      _paramSubject.sink.add(
        paramStream.value.alter(
          x: x+offset.dx
        )
      );
    if(0 <= newY && newY <= (1 - height) )
      _paramSubject.sink.add(
        paramStream.value.alter(
          y: y+offset.dy
        )
      );
  };

  @override
  void dispose() { 
    _paramSubject.close();
  }
  //Helper functions
  double _abs(double value) => math.sqrt( math.pow(value, 2) );

  List<double> _setDimension(double dDim, double dimension, double axis, bool rightOrBottom){
    //TODO: Fix bug where position jumps slightly when box flips rappidly 
    
    //Cap the dimension to 100% screen dimension, lock x so box 
    //doesn't fly offscreen
    if(_abs(dimension) > 1.0) 
      return <double>[1.0, -1.0];
    //Bound dimension between 0 and total screen dimension
    else if(0 <= dimension && dimension <= 1.0) {
    // else if(dimension <= 1) {
      //On the right or bottom handles, change dimension if it's decreasing or if
      //you haven't hit the edge of the artboard
      if(rightOrBottom && (dDim < 0 || ((dimension+dDim+axis) <= 1)) )
       return <double>[dimension+dDim, 0];
      //On the left handle, change dimension if you haven't hit the edge
      //of the artboard
      else if(!rightOrBottom && (axis+dDim)>0)
        return <double>[dimension-dDim, dDim];
    }
    //Check if flipped, bound between 0 and total screen dimension
    //behaves as if it has flipped and continues to follow gesture
    else if(-1.0 <= dimension && dimension < 0) {
      //On the right or bottom handles, change dimension if it's increasing or if
      //you haven't hit the edge of the artboard
      if(rightOrBottom && (axis+dDim)>0)
       return <double>[dimension+dDim, dDim];
      //On the left handle, change dimension if you haven't hit the edge
      //of the artboard
      else if(!rightOrBottom && (dDim > 0 || ((dimension-dDim+axis) <= 1)) ) {
        return <double>[dimension-dDim, 0];
      }
    }
    return <double>[dimension, 0];
  }
}