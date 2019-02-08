import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../organisms/stretchy_bloc.dart';

class WidthManipulator extends StatelessWidget{
  final Color color;
  final int sign;

  WidthManipulator.right({this.color : Colors.black87, this.sign : 1});
  WidthManipulator.left({this.color : Colors.black87, this.sign : -1});

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<StretchyBloc>(context);
    return GestureDetector(
      onHorizontalDragUpdate: (details) => _onDragUpdate(details, bloc),
      child: Container(
        alignment: Alignment(0, 0),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withOpacity(0.0),
          ),
        child: Container(
          width: 11,
          height: 22,
          decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(2.0)),
          color: color,
          ),
        ),
      ),
    );
  }

  void _onDragUpdate(DragUpdateDetails details, StretchyBloc bloc){
    bloc.setWidth(sign*details.delta.dx);
  }
}