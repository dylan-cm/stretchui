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
  double get width => sizeStream.value.width;
  double get height => sizeStream.value.height;
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