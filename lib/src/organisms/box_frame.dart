import 'package:flutter/material.dart';
import '../atoms/height_manipulator.dart';
import '../atoms/width_manipulator.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';
//TODO: include selector for each frame
class BoxFrame extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final ArtboardBloc bloc = BlocProvider.of<ArtboardBloc>(context);
    return StreamBuilder<int>(
      stream: bloc.selectedStream ,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot){
        if(!snapshot.hasData)
          return Container();
        else {
          final StretchyModel model = bloc.stretchySelected;
          final Size artboardSize = bloc.artboardSize;
          return Positioned(
            left: model.pixelX,
            top: model.pixelY,
            child: Stack(
              overflow: Overflow.visible,
              alignment: AlignmentDirectional.center,
              children: <Widget>[
                GestureDetector(
                  onPanUpdate: (DragUpdateDetails details){
                    _onDrag(bloc, details, artboardSize);
                  },
                child: Container(
                  width: model.pixelWidth,
                  height: model.pixelHeight,
                  decoration: BoxDecoration(
                    border: Border.all(color: model.layerColor),
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: HeightManipulator.top(color: model.layerColor,),
                ),
                Positioned(
                  right: 0,
                  child: WidthManipulator.right(color: model.layerColor,),
                ),
                Positioned(
                  bottom: 0,
                  child: HeightManipulator.bottom(color: model.layerColor,),
                ),
                Positioned(
                  left: 0,
                  child: WidthManipulator.left(color: model.layerColor,),
                ),
              ]
            )
          );  
        }
      }
    );
  }

  void _onDrag(ArtboardBloc bloc, DragUpdateDetails details, Size artboardSize){
    bloc.updatePosition(Offset(
      details.delta.dx/artboardSize.width,
      details.delta.dy/artboardSize.height
    ));
  }
}