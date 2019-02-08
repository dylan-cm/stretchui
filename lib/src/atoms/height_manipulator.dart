import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../organisms/stretchy_bloc.dart';

class HeightManipulator extends StatelessWidget{
  final Color color;
  final int sign;

  HeightManipulator.top({this.color : Colors.black87, this.sign : -1});
  HeightManipulator.bottom({this.color : Colors.black87, this.sign : 1});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StretchyBloc>(context);
    return GestureDetector(
      onVerticalDragUpdate: (details) => _onDragUpdate(details, bloc),
      child: Container(
        width: 22,
        height: 11,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          color: color,
        ),
      ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details, StretchyBloc bloc){
    bloc.setHeight(sign*details.delta.dy);
  }
}