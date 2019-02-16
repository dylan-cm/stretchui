import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';

class PropPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final ArtboardBloc bloc = BlocProvider.of<ArtboardBloc>(context);
    return Container(
      alignment: AlignmentDirectional.center,
      width: screen.width*0.9,
      height: screen.height*.1,
      color: Colors.grey[900],
      padding: const EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(flex: 8, child: Container()),
          _buildDisplay(bloc, true),
          _buildDisplay(bloc, false),
          Expanded(flex: 8, child: Container()),
        ],
      ),
    );
  }

  //Builder method for displaying x & y
  Widget _buildDisplay(ArtboardBloc bloc, bool isXAxis){
  //   return StreamBuilder<List<StretchyModel>>(
  //     stream: bloc.stretchyStream,
  //     initialData: <StretchyModel>[StretchyModel.start()],
  //     builder: (BuildContext context, AsyncSnapshot<List<StretchyModel>> snapshot){
  //       if(snapshot.data != null){
  //         final int value = ( isXAxis ? bloc.stretchySelected.x*100 : bloc.stretchySelected.y*100 ).floor();
  //         return Text((isXAxis ? 'X' : 'Y' ) + ': $value');
  //       }
  //       else 
  //         return Container();
  //     },
  //   );
  // }
  return Container();
  }
}