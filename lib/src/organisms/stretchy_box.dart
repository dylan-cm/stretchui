import 'package:flutter/material.dart';
import '../molecules/box_frame.dart';
import 'stretchy_bloc.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';
import '../molecules/padding_frame.dart';

class StretchyBox extends StatelessWidget{
  final double extPadding, intPadding;//, width, height;
  //TODO: add in parent widget with abstract class to pass in gesture detector
  //TODO: add in suppport for passing a child like an image, video, or button
  StretchyBox({
    this.extPadding:16, 
    this.intPadding:16,
  });

  @override
  Widget build(BuildContext context) {
    final bloc = StretchyBloc();
    final screen = MediaQuery.of(context).size;
    return BlocProvider<StretchyBloc>(
      bloc: bloc,
      child: StreamBuilder<Param>(
        stream: bloc.paramStream,
        initialData: Param.start(),
        builder: (context, AsyncSnapshot<Param> snapshot){ 
          return boxBuilder(bloc, screen, context);
        }
      )
    );
  }

  Widget boxBuilder(StretchyBloc bloc, Size screen, BuildContext context){
    return Positioned(
      left: bloc.x*screen.width,
      top: bloc.y*screen.height,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) => _onDrag(bloc, details, screen),
        // onVerticalDragUpdate: (DragUpdateDetails details) => _onDrag(bloc, details, screen),
        child:  Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              color: Colors.transparent,
              padding: EdgeInsets.all(extPadding),
              child: Container(
                alignment: AlignmentDirectional.center,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(intPadding),
                width: bloc.width*screen.width, 
                height: bloc.height*screen.height, 
                child: Container(
                  alignment: AlignmentDirectional.center,
                  color: Colors.transparent,
                  //TODO: This is where a child would go instead 
                )
              )
            ),
            BoxFrame(
              width: bloc.width*screen.width, 
              height: bloc.height*screen.height, 
            ),
            PaddingFrame(
              width: bloc.width*screen.width,
              height: bloc.height*screen.height,
              intPadding: intPadding,
              extPadding: extPadding
            ),
          ]
        ),
      ),
    );
  }

  void _onDrag(StretchyBloc bloc, DragUpdateDetails details, Size screen){
    bloc.updatePosition(Offset(
      details.delta.dx/screen.width,
      details.delta.dy/screen.height
    ));
  }
}