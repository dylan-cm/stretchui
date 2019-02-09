import 'package:flutter/material.dart';
import 'artboard_bloc.dart';
import '../bloc_provider.dart';

class Artboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = ArtBloc();
    return BlocProvider(
      bloc: bloc,
      child: Scaffold(
        body: Center(
          child: StreamBuilder(
            stream: bloc.stretchyStream,
            initialData: Stack(),
            builder: (context, snapshot){
              return bloc.stretchyStack;
            },
          )
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add_box),
          onPressed: bloc.addStretchy,
        ),
      )
    );
  }
}