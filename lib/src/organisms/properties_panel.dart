import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import 'stretchy_bloc.dart';

class PropPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final StretchyBloc bloc = BlocProvider.of<StretchyBloc>(context);
    //BAD!!!!!! No access to correct properties within bloc in tree
    //Artboard --- ArtBloc --- StetchyBoxes --- StretchyBlocs
    //                     `-- PropertyPanels
    //Significant refactor needed before proceeding
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
          _buildDisplay(bloc, 'X'),
          _buildDisplay(bloc, 'Y'),
          Expanded(flex: 8, child: Container()),
        ],
      ),
    );
  }

  //Builder method for displaying x & y
  Widget _buildDisplay(StretchyBloc bloc, String axis){
    return StreamBuilder<Param>(
      stream: bloc.paramStream,
      builder: (BuildContext context, AsyncSnapshot<Param> snapshot){
        final int value = ( (axis == 'X') ? snapshot.data.x*100 : snapshot.data.y*100 ).floor();
        return Text('$axis: $value');
      },
    );
  }
}