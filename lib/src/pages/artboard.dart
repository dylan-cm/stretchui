import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../organisms/properties_panel.dart';
import '../organisms/tool_chest.dart';
import 'artboard_bloc.dart';

class Artboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final ArtBloc bloc = ArtBloc();
    bloc.setSize(screen*0.9);
    return BlocProvider<ArtBloc>(
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
              child: StreamBuilder<List<StretchyBox>>(
                stream: bloc.stretchyStream,
                initialData: const <StretchyBox>[],
                builder: (BuildContext context, AsyncSnapshot<List<StretchyBox>> snapshot){
                  return bloc.stretchyStack;
                },
              )
            )
          ),
        ],
      )
    );
  }
}