import 'package:flutter/material.dart';
import '../molecules/box_frame.dart';
import 'stretchy_bloc.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';
import '../molecules/padding_frame.dart';

class StretchyBox extends StatelessWidget{
  //TODO: add in parent widget with abstract class to pass in gesture detector
  //TODO: add in suppport for passing a child like an image, video, or button
  final int id;
  StretchyBox({this.id:0});

  @override
  Widget build(BuildContext context) {
    final bloc = StretchyBloc();
    final artboard = BlocProvider.of<ArtBloc>(context);
    return BlocProvider<StretchyBloc>(
      bloc: bloc,
      child: StreamBuilder<Param>(
        stream: bloc.paramStream,
        initialData: Param.start(),
        builder: (context, AsyncSnapshot<Param> snapshot){ 
          return boxBuilder(bloc, artboard.size, context, artboard);
        }
      )
    );
  }

  Widget boxBuilder(StretchyBloc bloc, Size screen, BuildContext context, ArtBloc artboard){
    return Positioned(
      left: bloc.x*screen.width,
      top: bloc.y*screen.height,
      child: GestureDetector(
        onPanUpdate: (DragUpdateDetails details) => _onDrag(bloc, details, screen),
        onTap: () => artboard.selectStretchyAt(this.id),
        child: Stack(
          alignment: AlignmentDirectional.center,
          children: <Widget>[
            Container(
              alignment: AlignmentDirectional.center,
              color: Colors.red,
              width: bloc.width*screen.width+bloc.extPadding*2, 
              height: bloc.height*screen.height+bloc.extPadding*2,
              padding: EdgeInsets.all(bloc.extPadding),
              child: Container(
                alignment: AlignmentDirectional.center,
                color: Theme.of(context).primaryColor,
                padding: EdgeInsets.all(bloc.intPadding),
                width: bloc.width*screen.width, 
                height: bloc.height*screen.height, 
                child: Container(
                  alignment: AlignmentDirectional.center,
                  color: Colors.transparent,
                  //TODO: This is where a child would go instead 
                )
              )
            ),
            _buildFrame(artboard, bloc, screen),
          ]
        ),
      ),
    );
  }

  Widget _buildFrame(ArtBloc artboard, StretchyBloc bloc, Size screen){
    return StreamBuilder(
      stream: artboard.selectedStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return artboard.stretchySelected.id==this.id ? Stack(
          children: <Widget>[
             
            BoxFrame(
              width: bloc.width*screen.width, 
              height: bloc.height*screen.height, 
            ),
            PaddingFrame(
              width: bloc.width*screen.width,
              height: bloc.height*screen.height,
              intPadding: bloc.intPadding,
              extPadding: bloc.extPadding
            ),
          ],
        ) : Container();
      },
    );
  }

  void _onDrag(StretchyBloc bloc, DragUpdateDetails details, Size screen){
    bloc.updatePosition(Offset(
      details.delta.dx/screen.width,
      details.delta.dy/screen.height
    ));
  }
}