import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';

class WidthManipulator extends StatelessWidget{
  const WidthManipulator.right({this.color = Colors.black87, this.right = true});
  const WidthManipulator.left({this.color = Colors.black87, this.right = false});

  final Color color;
  final bool right;

  @override
  Widget build(BuildContext context) {
    final ArtboardBloc bloc = BlocProvider.of<ArtboardBloc>(context);
    return GestureDetector(
      onHorizontalDragUpdate: (DragUpdateDetails details) => _onDragUpdate(details, bloc),
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

  void _onDragUpdate(DragUpdateDetails details, ArtboardBloc bloc){
    bloc.setWidth(details.delta.dx, right);
  }

  void _onDragEnd(DragEndDetails details, ArtboardBloc bloc){}
}