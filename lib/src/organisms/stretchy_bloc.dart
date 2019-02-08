import 'dart:math' as math;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../atoms/param.dart';
export '../atoms/param.dart';

class StretchyBloc extends BlocBase{
  final _paramSubject = BehaviorSubject<Param>(seedValue: Param(100, 100, 0, 0, Colors.white));
  //TODO: paddingSubject exterior and interior
  //TODO: rotation
  //TODO: position relative to screen
  
  //Getters
  ValueObservable<Param> get paramStream => _paramSubject.stream;
  double get width => _abs(paramStream.value.width);
  double get height => _abs(paramStream.value.height);
  //Setters
  Function(double) get setWidth => (dx) {
    _paramSubject.sink.add(
      paramStream.value.alter(width: paramStream.value.width+dx*2)
    );
  };
  Function(double) get setHeight => (dy) {
    _paramSubject.sink.add(
      paramStream.value.alter(height: paramStream.value.height+dy*2)
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

  void dispose() { 
    _paramSubject.close();
  }

  double _abs(double value) => math.sqrt( math.pow(value, 2) );
}