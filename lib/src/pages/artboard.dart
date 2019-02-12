import 'package:flutter/material.dart';
import 'artboard_bloc.dart';
import '../bloc_provider.dart';
import '../organisms/tool_chest.dart';

class Artboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final bloc = ArtBloc();
    bloc.setSize(screen*.9);
    return BlocProvider(
      bloc: bloc,
      child: Stack(
        children: <Widget>[
          PositionedDirectional(
            start: 0,
            bottom: 0,
            child: BlocProvider(
              bloc: bloc,
              child: ToolChest()
            )
          ),
          PositionedDirectional(
            end: 0,
            bottom: 0,
            child: Container(
              color: Colors.white,
              width: screen.width*.9,
              height: screen.height*.9,
              child: StreamBuilder(
                stream: bloc.stretchyStream,
                initialData: Stack(),
                builder: (context, snapshot){
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