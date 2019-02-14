import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../organisms/stretchy_bloc.dart';

class HeightManipulator extends StatelessWidget{
  const HeightManipulator.top({this.color = Colors.black87, this.sign = -1});
  const HeightManipulator.bottom({this.color = Colors.black87, this.sign = 1});

  final Color color;
  final int sign;

  @override
  Widget build(BuildContext context) {
    final StretchyBloc bloc = BlocProvider.of<StretchyBloc>(context);
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) => _onDragUpdate(context, details, bloc),
      onVerticalDragEnd: (DragEndDetails details) => _onDragEnd( details, bloc),
      child: Container(
        alignment: AlignmentDirectional.center,
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: color.withOpacity(0.0),
          ),
        child: Container(
          width: 22,
          height: 11,
          decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(2.0)),
          color: color,
          ),
        ),
      ),
    );
  }

  void _onDragUpdate(BuildContext context, DragUpdateDetails details, StretchyBloc bloc){
    bloc.setHeight(sign*details.delta.dy/MediaQuery.of(context).size.height);
  }

  void _onDragEnd(DragEndDetails details, StretchyBloc bloc){
    bloc.endResize();
  }
}