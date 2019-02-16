import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';

class HeightManipulator extends StatelessWidget{
  const HeightManipulator.top({this.color = Colors.black87, this.bottom = false});
  const HeightManipulator.bottom({this.color = Colors.black87, this.bottom = true});

  final Color color;
  final bool bottom;

  @override
  Widget build(BuildContext context) {
    final ArtboardBloc bloc = BlocProvider.of<ArtboardBloc>(context);
    return GestureDetector(
      onVerticalDragUpdate: (DragUpdateDetails details) => _onDragUpdate(details, bloc),
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

  void _onDragUpdate(DragUpdateDetails details, ArtboardBloc bloc){
    bloc.setHeight(details.delta.dy, bottom);
  }

  void _onDragEnd(DragEndDetails details, ArtboardBloc bloc){}
}