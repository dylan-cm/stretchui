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
  Function(double) get setWidth => (double dx) {
    //TODO: Fix bug where position jumps slightly when box flips
    //As long as the box hasn't flipped, symmmetrically increase width about center
    //by incrementing width by two times gesture input and decreasing the x position
    if(0 <= paramStream.value.width && paramStream.value.width <= 1.0) 
      _paramSubject.sink.add(
        paramStream.value.alter(
          width: paramStream.value.width+dx*2,
          x: paramStream.value.x-dx,
          )
      );
    //Cap the width to 100% screen width, lock x so box doesn't fly offscreen
    else if(paramStream.value.width > 1.0) 
      _paramSubject.sink.add(
        paramStream.value.alter(
          width: 1.0,
          x: paramStream.value.x+dx,
          )
      );
    //When flipped, symmmetrically increase width about center by incrementing width 
    // by two times gesture input and decreasing the x position with negative dx
    else if(-1.0 <= paramStream.value.width && paramStream.value.width < 0) 
      _paramSubject.sink.add(
        paramStream.value.alter(
          width: paramStream.value.width+dx*2,
          x: paramStream.value.x+dx,
          )
      );
    //When flipped, cap the width to 100% screen width, lock x so box doesn't fly offscreen
    else if(paramStream.value.width < -1.0) 
      _paramSubject.sink.add(
        paramStream.value.alter(
          width: -1.0,
          x: paramStream.value.x-dx,
          )
      );
  };
  Function(double) get setHeight => (double dy) {
        //As long as the box hasn't flipped, symmmetrically increase height about center
    //by incrementing height by two times gesture input and decreasing the y position
    if(0 <= paramStream.value.height && paramStream.value.height <= 1.0) 
      _paramSubject.sink.add(
        paramStream.value.alter(
          height: paramStream.value.height+dy*2,
          y: paramStream.value.y-dy,
          )
      );
    //Cap the height to 100% screen height, lock y so box doesn't fly offscreen
    else if(paramStream.value.height > 1.0) 
      _paramSubject.sink.add(
        paramStream.value.alter(
          height: 1.0,
          y: paramStream.value.y+dy,
          )
      );
    //When flipped, symmmetrically increase height about center by incrementing height 
    // by two times gesture input and decreasing the y position with negative dy
    else if(-1.0 <= paramStream.value.height && paramStream.value.height < 0) 
      _paramSubject.sink.add(
        paramStream.value.alter(
          height: paramStream.value.height+dy*2,
          y: paramStream.value.y+dy,
          )
      );
    //When flipped, cap the height to 100% screen height, lock y so box doesn't fly offscreen
    else if(paramStream.value.height < -1.0) 
      _paramSubject.sink.add(
        paramStream.value.alter(
          height: -1.0,
          y: paramStream.value.y-dy,
          )
      );
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
    // //Set new positions to variables
    // final double newX = offset.dx + x;
    // final double newY = offset.dy + y;
    // //Check to keep box on screen, if so update position
    // if(0 <= newX && newX <= (screen.width*0.8) )
    //   _paramSubject.sink.add(
    //     paramStream.value.alter(
    //       x: x+offset.dx
    //     )
    //   );
    // if(0 <= newY && newY <= (screen.height*(1 - height)) )
    //   _paramSubject.sink.add(
    //     paramStream.value.alter(
    //       y: y+offset.dy
    //     )
    //   );
    _paramSubject.sink.add(
      paramStream.value.alter(
        x: x+offset.dx,
        y: y+offset.dy
      )
    );
  };

  @override
  void dispose() { 
    _paramSubject.close();
  }

  double _abs(double value) => math.sqrt( math.pow(value, 2) );
}