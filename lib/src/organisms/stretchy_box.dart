import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';

class StretchyBox extends StatelessWidget{
  const StretchyBox(this.model);
  //TODO: add in parent widget with abstract class to pass in gesture detector
  //TODO: add in suppport for passing a child like an image, video, or button
  final StretchyModel model;

  @override
  Widget build(BuildContext context) {
    final ArtboardBloc bloc = BlocProvider.of<ArtboardBloc>(context);
    return Positioned(
      //TODO: support other alignments than top-left
      left: model.pixelX,
      top: model.pixelY,
      child: GestureDetector(
        onTap: () => bloc.selectStretchyAt(model.id),
        onPanStart: (DragStartDetails _) => bloc.selectStretchyAt(model.id),
        child: Container(
          alignment: AlignmentDirectional.center,
          color: Colors.red,//TODO: for testing purposes only
          width: model.pixelWidth + model.extPadding*2, 
          height: model.pixelHeight + model.extPadding*2,
          padding: EdgeInsets.all(model.extPadding),
          child: Container(
            alignment: AlignmentDirectional.center,
            color: Theme.of(context).primaryColor,
            padding: EdgeInsets.all(model.intPadding),
            width: model.pixelWidth, 
            height: model.pixelHeight, 
            child: Container(
              alignment: AlignmentDirectional.center,
              color: Colors.transparent,
              //TODO: This is where a child would go instead 
            )
          )
        ),
      ),
    );
  }
}