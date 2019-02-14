import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../molecules/box_frame.dart';
import '../molecules/padding_frame.dart';
import '../pages/artboard_bloc.dart';
import 'stretchy_bloc.dart';

class StretchyBox extends StatelessWidget{
  const StretchyBox({this.id = 0});
  //TODO: add in parent widget with abstract class to pass in gesture detector
  //TODO: add in suppport for passing a child like an image, video, or button
  //TODO: abstract all logic to bloc and everything else to model. switch to MVC?
    //just take in model and display it so that model can be passed to prop panel
  final int id;

  @override
  Widget build(BuildContext context) {
    final ArtBloc artboard = BlocProvider.of<ArtBloc>(context);
    final StretchyBloc bloc = StretchyBloc(artboard.size);
    return BlocProvider<StretchyBloc>(
      bloc: bloc,
      child: StreamBuilder<Param>(
        stream: bloc.paramStream,
        initialData: Param.start(),
        builder: (BuildContext context, AsyncSnapshot<Param> snapshot){ 
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
        onTap: () => artboard.selectStretchyAt(id),
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
    return StreamBuilder<int>(
      stream: artboard.selectedStream,
      builder: (BuildContext context, AsyncSnapshot<int> snapshot) {
        return artboard.stretchySelected.id==id ? Stack(
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