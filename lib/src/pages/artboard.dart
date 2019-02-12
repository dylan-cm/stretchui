import 'package:flutter/material.dart';
import 'artboard_bloc.dart';
import '../bloc_provider.dart';
import '../organisms/tool_chest.dart';

class Artboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ArtBloc();
    return BlocProvider(
      bloc: bloc,
      child: Stack(
        children: <Widget>[
          BlocProvider(
            bloc: bloc,
            child: ToolChest()
          ),
          StreamBuilder(
              stream: bloc.stretchyStream,
              initialData: Stack(),
              builder: (context, snapshot){
                return bloc.stretchyStack;
              },
          ),
        ],
      )
    );
  }
}