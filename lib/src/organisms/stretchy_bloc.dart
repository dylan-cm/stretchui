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
  double get width => _abs(sizeStream.value.width);
  double get height => _abs(sizeStream.value.height);
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
  Function() get endResize => (){
    _sizeSubject.sink.add(
      Size(
        _abs(_sizeSubject.stream.value.width), 
        _abs(_sizeSubject.stream.value.height) 
      )
    );
  };

  void dispose() { 
    _sizeSubject.close();
    // _invertedSubject.close();
  }

  double _abs(double value) => math.sqrt( math.pow(value, 2) );
}