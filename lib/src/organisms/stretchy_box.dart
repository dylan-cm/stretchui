import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../molecules/box_frame.dart';
import 'stretchy_bloc.dart';
import '../bloc_provider.dart';

class StretchyBox extends StatelessWidget{
  final double extPadding, intPadding;//, width, height;
  //TODO: add in parent widget with abstract class to pass in gesture detector
  //TODO: add in suppport for passing a child like an image, video, or button
  StretchyBox({
    this.extPadding:0, 
    this.intPadding:0, 
    // this.width:100, 
    // this.height:100,
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
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: <Widget>[
          Container(
            alignment: AlignmentDirectional.center,
            color: Theme.of(context).primaryColorLight,
            padding: EdgeInsets.all(extPadding),
            width: bloc.width*screen.width + extPadding*2,
            height: bloc.height*screen.height + extPadding*2,
              child: Container(
              alignment: AlignmentDirectional.center,
              color: Theme.of(context).primaryColor,
              padding: EdgeInsets.all(intPadding),
              width: bloc.width*screen.width, 
              height: bloc.height*screen.height, 
              child: Container(
                alignment: AlignmentDirectional.center,
                color: Theme.of(context).primaryColorDark,
                //This is where a child would go instead 
              )
            )
          ),
          BoxFrame(
            width: bloc.width*screen.width, 
            height: bloc.height*screen.height, 
          ),
        ]
      ),
    );
  }
}