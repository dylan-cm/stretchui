import 'dart:math' as math;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../bloc_provider.dart';

class StretchyBloc extends BlocBase{
  final _sizeSubject = BehaviorSubject<Size>(seedValue: Size(100, 100));
  //TODO: paddingSubject exterior and interior
  //TODO: rotation
  //TODO: position relative to screen
  
  //Getters
  ValueObservable<Size> get sizeStream => _sizeSubject.stream;
  double get width => math.sqrt( math.pow(sizeStream.value.width, 2) );
  double get height => math.sqrt( math.pow(sizeStream.value.height, 2) );
  //Setters
  Function(double) get setWidth => (dx) {
    _sizeSubject.sink.add(
      Size(sizeStream.value.width+dx*2, sizeStream.value.height)
    );
  };
  Function(double) get setHeight => (dy) {
    _sizeSubject.sink.add(
      Size(sizeStream.value.width, sizeStream.value.height+dy*2)
    );
  };

  void dispose() { 
    _sizeSubject.close();
    // _invertedSubject.close();
  }
}