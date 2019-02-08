import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../bloc_provider.dart';

class StretchyBloc extends BlocBase{
  final _sizeSubject = BehaviorSubject<Size>();
  //TODO: paddingSubject exterior and interior
  //TODO: rotation
  //TODO: position relative to screen

  //Getters
  ValueObservable<Size> get sizeStream => _sizeSubject.stream;
  double get width => sizeStream.value.width;
  double get height => sizeStream.value.height;
  //Setters
  Function(Size) get setSize => (newSize) => _sizeSubject.sink.add(newSize);

  void dispose() { 
    _sizeSubject.close();
  }
}