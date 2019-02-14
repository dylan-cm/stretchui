import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../organisms/stretchy_bloc.dart';

class WidthManipulator extends StatelessWidget{
  const WidthManipulator.right({this.color = Colors.black87, this.sign = 1});
  const WidthManipulator.left({this.color = Colors.black87, this.sign = -1});

  final Color color;
  final int sign;

  @override
  Widget build(BuildContext context) {
    final StretchyBloc bloc = BlocProvider.of<StretchyBloc>(context);
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) => _onDragUpdate(context, details, bloc),
      onHorizontalDragEnd: (DragEndDetails details)=> _onDragEnd(details, bloc),
      child: Container(
        alignment: AlignmentDirectional.center,
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withOpacity(0.0),
          ),
        child: Container(
          width: 11,
          height: 22,
          decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2.0)),
          color: color,
          ),
        ),
      ),
    );
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails details, StretchyBloc bloc){
    bloc.setWidth(sign*details.delta.dx/MediaQuery.of(context).size.width);
  }

  void _onDragEnd(DragEndDetails details, StretchyBloc bloc){
    bloc.endResize();
  }
}