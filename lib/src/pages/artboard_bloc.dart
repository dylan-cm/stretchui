import 'dart:math' as math;
import 'package:rxdart/rxdart.dart';
import 'package:flutter/material.dart';
import '../atoms/stretchy_model.dart';
import '../bloc_provider.dart';
export '../atoms/stretchy_model.dart';

class ArtboardBloc extends BlocBase{
  final BehaviorSubject<List<StretchyModel>> _stretchySubject = BehaviorSubject<List<StretchyModel>>(seedValue: <StretchyModel>[]);
  final BehaviorSubject<int> _selectedSubject = BehaviorSubject<int>(seedValue: null);
  final BehaviorSubject<Size> _artBoardsizeSubject = BehaviorSubject<Size>();
  ///
  ///Getters
  ///
  ValueObservable<List<StretchyModel>> get stretchyStream => _stretchySubject.stream;
  ValueObservable<int> get selectedStream => _selectedSubject.stream;
  StretchyModel get stretchySelected => _stretchySubject.stream.value[_selectedSubject.stream.value];
  ValueObservable<Size> get artboardSizeStream => _artBoardsizeSubject.stream;
  Size get artboardSize => _artBoardsizeSubject.stream.value;
  ///
  ///Setters
  ///
  ///Set the size of the artboard
  Function(Size) get setSize => (Size _size) => _artBoardsizeSubject.sink.add(_size);
  ///Update dimension along x axis of StretchyBox
  Function(double, bool) get setWidth => (double dx, bool right) {
    //Convert change in pixels to change in points
    final double dw = dx/artboardSize.width;
    //Store a modifiable copy of the list of models
    final List<StretchyModel> updatedList = stretchyStream.value;
    //Store the results of the helper function
    final List<double> result = 
      _setDimension(
        dw, 
        updatedList[selectedStream.value].width, 
        updatedList[selectedStream.value].x, 
        right,
      );
    //Update the list at the selected model with the resulting dimension change
    updatedList[selectedStream.value] = updatedList[selectedStream.value].alter(
      width: result[0],
      pixelWidth: _abs(_pointsToPixels(result[0], true)),
    );
    //Add the updated list to the stream of models
    _stretchySubject.sink.add( updatedList );
    //Update the position of the box as determined by results
    updatePosition(
      Offset(result[1], 0)
    );
  };
  ///Update dimension along y axis of StretchyBox
  Function(double, bool) get setHeight => (double dy, bool bottom) {
    //Convert change in pixels to change in points
    final double dh = dy/artboardSize.height;
    //Store a modifiable copy of the list of models
    final List<StretchyModel> updatedList = stretchyStream.value;
    //Store the results of the helper function
    final List<double> result = 
      _setDimension(
        dh, 
        updatedList[selectedStream.value].height, 
        updatedList[selectedStream.value].y, 
        bottom,
      );
    //Update the list at the selected model with the resulting dimension change
    updatedList[selectedStream.value] = updatedList[selectedStream.value].alter(
      height: result[0],
      pixelHeight: _abs(_pointsToPixels(result[0], false)),
    );
    //Add the updated list to the stream of models
    _stretchySubject.sink.add( updatedList );
    //Update the position of the box as determined by results
    updatePosition(
      Offset(0, result[1])
    );
  };
  ///Set the x and y position of the StretchyBox
  Function(Offset) get updatePosition => (Offset offset) {
    //Store new positions to variables for each axis
    final double newX = offset.dx + stretchySelected.x;
    final double newY = offset.dy + stretchySelected.y;
    //Store a modifiable copy of the list of models
    final List<StretchyModel> updatedList = stretchyStream.value;
    //Check to keep box on screen, if so update position for each axis
    if(0 <= newX && newX <= (1-stretchySelected.width) )
      //Update the list at the selected model with the new position for that axis
      updatedList[selectedStream.value] = updatedList[selectedStream.value].alter(
        x: newX,
        pixelX: _pointsToPixels(newX, true),
      );
      //Add the updated list of models to the model stream
      _stretchySubject.sink.add( updatedList );
    if(0 <= newY && newY <= (1 - stretchySelected.height) )
      //Update the list at the selected model with the new position for that axis
      updatedList[selectedStream.value] = updatedList[selectedStream.value].alter(
        y: newY,
        pixelY: _pointsToPixels(newY, false),
      );
      //Add the updated list of models to the model stream
      _stretchySubject.sink.add( updatedList );
  };
  ///Move selected StretchyModel up and down stack render
  ///effectively changing layers.
  Function() get upStack => () {
    if(selectedStream.value < stretchyStream.value.length-1) {
      final List<StretchyModel> updatedList = <StretchyModel>[]
        ..addAll(stretchyStream.value)
        ..insert(selectedStream.value+2, stretchySelected)
        ..removeAt(selectedStream.value);
      _stretchySubject.sink.add(updatedList);
      selectStretchyAt(selectedStream.value+1);
    }
  };
  Function() get downStack => () {
    if(selectedStream.value>0) {
      final List<StretchyModel> updatedList = <StretchyModel>[]
        ..addAll(stretchyStream.value)
        ..insert(selectedStream.value-1, stretchySelected)
        ..removeAt(selectedStream.value);
      _stretchySubject.sink.add(updatedList);
      selectStretchyAt(selectedStream.value-1);
    }
  };
  Function() get topStack => () {
    if(selectedStream.value < stretchyStream.value.length-1){
      final List<StretchyModel> updatedList = <StretchyModel>[]
        ..addAll(stretchyStream.value)
        ..insert(stretchyStream.value.length, stretchySelected)
        ..removeAt(selectedStream.value+1);
      _stretchySubject.sink.add(updatedList);
      selectStretchyAt(stretchyStream.value.length-1);
    }
  };
  Function() get bottomStack => () {
    if(selectedStream.value>0) {
      final List<StretchyModel> updatedList = <StretchyModel>[]
        ..addAll(stretchyStream.value)
        ..insert(0, stretchySelected)
        ..removeAt(selectedStream.value+1);
      _stretchySubject.sink.add(updatedList);
      selectStretchyAt(0);
    }
  };
  ///Add a StretchyModel to the top of the stack (top layer)
  Function() get addStretchy => (){
    final int id = _generateId();
    //Initial dimension given to StretchyBox upon creation
    const double initialDimension = 0.25;
    final List<StretchyModel> updatedList = <StretchyModel>[]
      ..addAll(stretchyStream.value)
      ..add(StretchyModel.start(
        id: id,
        pixelWidth: _pointsToPixels(initialDimension, true),
        pixelHeight: _pointsToPixels(initialDimension, false),
        pixelX: _pointsToPixels(initialDimension*1.5, true),
        pixelY: _pointsToPixels(initialDimension*1.5, false),
      ));
     _stretchySubject.sink.add(updatedList);
     selectStretchyAt(id);
  };
  ///selectStretchy
  Function(int) get selectStretchyAt => (int id){
    final int index = stretchyStream.value.indexWhere(
      (StretchyModel model) => model.id == id
    );
    _selectedSubject.sink.add(index);
  };
  ///
  ///Helper functions
  ///
  ///Generate a unique Id
  int _generateId(){
    final math.Random random = math.Random();
    return random.nextInt(1<<16);
  }
  ///Shorthand for getting an absolute value
  double _abs(double value) => math.sqrt( math.pow(value, 2) );
  ///Generalized dimension setter used by both setWidth and setHeight
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
  double _pointsToPixels(double points, bool isHorizontalAxis){
    return points * (isHorizontalAxis ? artboardSize.width : artboardSize.height);
  }

  @override
  void dispose() { 
    _stretchySubject.close();
    _selectedSubject.close();
    _artBoardsizeSubject.close();
  }
}