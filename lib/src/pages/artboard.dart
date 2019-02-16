import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../organisms/box_frame.dart';
import '../organisms/properties_panel.dart';
import '../organisms/stretchy_box.dart';
import '../organisms/tool_chest.dart';
import 'artboard_bloc.dart';

class Artboard extends StatelessWidget {
  ///TODO: make stateful, init artboard size - change if
  ///orientation changes or go into preview mode etc, 
  ///dispose function
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final ArtboardBloc bloc = ArtboardBloc();
    bloc.setArtboardSize(screen*0.9);
    return BlocProvider<ArtboardBloc>(
      bloc: bloc,
      child: Stack(
        children: <Widget>[
          PositionedDirectional(
            end: 0,
            top: 0,
            child: PropPanel(),
          ),
          PositionedDirectional(
            start: 0,
            bottom: 0,
            child: ToolChest()
          ),
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: screen.width*.9,
              height: screen.height*.9,
              child: StreamBuilder<List<StretchyModel>>(
                stream: bloc.stretchyStream,
                initialData: const <StretchyModel>[],
                builder: (BuildContext context, AsyncSnapshot<List<StretchyModel>> snapshot){
                  final List<Widget> layers = <Widget>[Container()]; 
                  for(int i = 0; i < snapshot.data.length; i++){
                    layers.add(StretchyBox(snapshot.data[i]));
                  }
                  return Stack(
                    children: 
                    layers +
                    <Widget>[BoxFrame()],
                  );
                },
              )
            )
          ),
        ],
      )
    );
  }
}