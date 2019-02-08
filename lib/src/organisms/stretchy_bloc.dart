import 'dart:math' as math;
import 'package:rxdart/rxdart.dart';
import '../bloc_provider.dart';
import '../atoms/param.dart';
export '../atoms/param.dart';

class StretchyBloc extends BlocBase{
  final _paramSubject = BehaviorSubject<Param>(seedValue: Param.start());
  //TODO: paddingSubject exterior and interior
  //TODO: rotation
  //TODO: position relative to screen
  
  //Getters
  ValueObservable<Param> get paramStream => _paramSubject.stream;
  double get width => _abs(paramStream.value.width);
  double get height => _abs(paramStream.value.height);
  //Setters
  Function(double) get setWidth => (dx) {
    if(-1.0 <= width && width <= 1.0) _paramSubject.sink.add(
      paramStream.value.alter(width: paramStream.value.width+dx*2)
    );
    else _paramSubject.sink.add(
      paramStream.value.alter(width: 1.0)
    );
  };
  Function(double) get setHeight => (dy) {
    if(-1.0 <= height && height <= 1.0) _paramSubject.sink.add(
      paramStream.value.alter(height: paramStream.value.height+dy*2)
    );
    else _paramSubject.sink.add(
      paramStream.value.alter(height: 1.0)
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