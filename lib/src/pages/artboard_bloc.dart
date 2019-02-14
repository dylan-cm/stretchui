import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../organisms/stretchy_box.dart';
export '../organisms/stretchy_box.dart';

class ArtBloc extends BlocBase{
  final BehaviorSubject<List<StretchyBox>> _stretchySubject = BehaviorSubject<List<StretchyBox>>(seedValue: <StretchyBox>[]);
  final BehaviorSubject<int> _selectedSubject = BehaviorSubject<int>(seedValue: null);
  final BehaviorSubject<Size> _sizeSubject = BehaviorSubject<Size>();
  //Getters
  ValueObservable<List<StretchyBox>> get stretchyStream => _stretchySubject.stream;
  List<StretchyBox> get stretchyList => _stretchySubject.stream.value;
  Stack get stretchyStack => Stack(children: stretchyList);
  ValueObservable<int> get selectedStream => _selectedSubject.stream;
  StretchyBox get stretchySelected => _stretchySubject.stream.value[_selectedSubject.stream.value];
  Size get size => _sizeSubject.stream.value;
  //Setters
  Function(Size) get setSize => (Size _size) => _sizeSubject.sink.add(_size);
  //Move up and down stack render
  Function() get upStack => () {
    if(selectedStream.value < stretchyList.length-1) {
      final List<StretchyBox> updatedList = <StretchyBox>[]
        ..addAll(stretchyList)
        ..insert(selectedStream.value+2, stretchySelected)
        ..removeAt(selectedStream.value);
      _stretchySubject.sink.add(updatedList);
      selectStretchyAt(selectedStream.value+1);
    }
  };
  Function() get downStack => () {
    if(selectedStream.value>0) {
      final List<StretchyBox> updatedList = <StretchyBox>[]
        ..addAll(stretchyList)
        ..insert(selectedStream.value-1, stretchySelected)
        ..removeAt(selectedStream.value);
      _stretchySubject.sink.add(updatedList);
      selectStretchyAt(selectedStream.value-1);
    }
  };
  Function() get topStack => () {
    if(selectedStream.value < stretchyList.length-1){
      final List<StretchyBox> updatedList = <StretchyBox>[]
        ..addAll(stretchyList)
        ..insert(stretchyList.length, stretchySelected)
        ..removeAt(selectedStream.value+1);
      _stretchySubject.sink.add(updatedList);
      selectStretchyAt(stretchyList.length-1);
    }
  };
  Function() get bottomStack => () {
    if(selectedStream.value>0) {
      final List<StretchyBox> updatedList = <StretchyBox>[]
        ..addAll(stretchyList)
        ..insert(0, stretchySelected)
        ..removeAt(selectedStream.value+1);
      _stretchySubject.sink.add(updatedList);
      selectStretchyAt(0);
    }
  };
  //addStretchy
  Function() get addStretchy => (){
    final List<StretchyBox> updatedList = <StretchyBox>[]
      ..addAll(stretchyList)
      ..add(StretchyBox(id:stretchyList.length));
     _stretchySubject.sink.add(updatedList);
     selectStretchyAt(stretchyList.length-1);
  };
  //selectStretchy
  Function(int) get selectStretchyAt => (int index) => _selectedSubject.sink.add(index);

  @override
  void dispose() { 
    _stretchySubject.close();
    _selectedSubject.close();
    _sizeSubject.close();
  }
}