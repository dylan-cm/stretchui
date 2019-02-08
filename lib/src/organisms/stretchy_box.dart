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
    return BlocProvider<StretchyBloc>(
      bloc: bloc,
      child: StreamBuilder(
        stream: bloc.sizeStream,
        initialData: Size(100,100),
        builder: (context, AsyncSnapshot<Size> snapshot){ 
          return Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.center,
                color: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.all(extPadding),
                width: bloc.width+extPadding*2,
                height: bloc.height+extPadding*2,
                  child: Container(
                  alignment: AlignmentDirectional.center,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(intPadding),
                  width: bloc.width,
                  height: bloc.height,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    color: Theme.of(context).primaryColorDark,
                    //This is where a child would go instead 
                  )
                )
              ),
              BoxFrame(
                width: bloc.width,
                height: bloc.height,
              ),
            ]
          );
        }
      )
    );
  }
}