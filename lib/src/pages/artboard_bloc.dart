import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../organisms/stretchy_box.dart';

class ArtBloc extends BlocBase{
  final _stretchySubject = BehaviorSubject<List<StretchyBox>>(seedValue: []);
  final _selectedSubject = BehaviorSubject<int>(seedValue: null);
  final _sizeSubject = BehaviorSubject<Size>();
  //Getters
  ValueObservable<List<StretchyBox>> get stretchyStream => _stretchySubject.stream;
  List<StretchyBox> get stretchyList => _stretchySubject.stream.value;
  Stack get stretchyStack => Stack(children: stretchyList);
  ValueObservable<int> get selectedStream => _selectedSubject.stream;
  StretchyBox get stretchySelected => _stretchySubject.stream.value[_selectedSubject.stream.value];
  Size get size => _sizeSubject.stream.value;
  //Setters
  Function(Size) get setSize => (_size) => _sizeSubject.sink.add(_size);
  //Move up and down stack render
  Function() get upStack => () {
    if(selectedStream.value < stretchyList.length-1) {
      _stretchySubject.sink.add(
        List<StretchyBox>()
        ..addAll(stretchyList)
        ..insert(selectedStream.value+2, stretchySelected)
        ..removeAt(selectedStream.value)
      );
      selectStretchyAt(selectedStream.value+1);
    }
  };
  Function() get downStack => () {
    if(selectedStream.value>0) {
      _stretchySubject.sink.add(
        List<StretchyBox>()
        ..addAll(stretchyList)
        ..insert(selectedStream.value-1, stretchySelected)
        ..removeAt(selectedStream.value)
      );
      selectStretchyAt(selectedStream.value-1);
    }
  };
  Function() get topStack => () {
    if(selectedStream.value < stretchyList.length-1){
      _stretchySubject.sink.add(
        List<StretchyBox>()
        ..addAll(stretchyList)
        ..insert(stretchyList.length, stretchySelected)
        ..removeAt(selectedStream.value+1)
      );
      selectStretchyAt(stretchyList.length-1);
    }
  };
  Function() get bottomStack => () {
    if(selectedStream.value>0) {
      _stretchySubject.sink.add(
        List<StretchyBox>()
        ..addAll(stretchyList)
        ..insert(0, stretchySelected)
        ..removeAt(selectedStream.value+1)
      );
      selectStretchyAt(0);
    }
  };
  //addStretchy
  Function() get addStretchy => (){
     _stretchySubject.sink.add(
      List<StretchyBox>()
      ..addAll(stretchyList)
      ..add(StretchyBox(id:stretchyList.length))
     );
     selectStretchyAt(stretchyList.length-1);
  };
  //selectStretchy
  Function(int) get selectStretchyAt => (index) => _selectedSubject.sink.add(index);
  Function(Key) get selectStretchy => (key) {
    _selectedSubject.sink.add( stretchyList.indexWhere( (stretchy)=> stretchy.key == key ) );
  };

  @override
  void dispose() { 
    _stretchySubject.close();
    _selectedSubject.close();
    _sizeSubject.close();
  }
}