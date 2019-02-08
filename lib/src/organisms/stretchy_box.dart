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
          var data = snapshot.data;
          double width = math.sqrt( math.pow(snapshot.data.width, 2) );
          double height = math.sqrt( math.pow(snapshot.data.height, 2) );
          return Stack(
            alignment: AlignmentDirectional.center,
            children: <Widget>[
              Container(
                alignment: AlignmentDirectional.center,
                color: Theme.of(context).primaryColorLight,
                padding: EdgeInsets.all(extPadding),
                width: width+extPadding*2,
                height: height+extPadding*2,
                  child: Container(
                  alignment: AlignmentDirectional.center,
                  color: Theme.of(context).primaryColor,
                  padding: EdgeInsets.all(intPadding),
                  width: width,
                  height: height,
                  child: Container(
                    alignment: AlignmentDirectional.center,
                    color: Theme.of(context).primaryColorDark,
                    //This is where a child would go instead 
                  )
                )
              ),
              BoxFrame(
                width: width,
                height: height,
              ),
            ]
          );
        }
      )
    );
  }
}