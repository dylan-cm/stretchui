import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';

class PropPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
    final ArtboardBloc bloc = BlocProvider.of<ArtboardBloc>(context);
    return Container(
      width: screen.width*0.9,
      height: screen.height*.1,
      color: Colors.grey[900],
      padding: const EdgeInsets.only(top: 22),
      child: Stack(
      overflow: Overflow.visible,
      alignment: AlignmentDirectional.center,
        children: <Widget>[
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(flex: 8, child: Container()),
              _buildDisplay(bloc, true),
              Expanded(flex: 1, child: Container()),
              _buildDisplay(bloc, false),
              Expanded(flex: 8, child: Container()),
            ],
          ),
          Positioned(
            bottom: 0,
            child: _buildSlider(bloc),
          ),
        ],
      ),
    );
  }

  //Builder method for displaying x & y
  Widget _buildDisplay(ArtboardBloc bloc, bool isXAxis){
    return StreamBuilder<List<StretchyModel>>(
      stream: bloc.stretchyStream,
      builder: (BuildContext context, AsyncSnapshot<List<StretchyModel>> snapshot){
        int value;
        if(snapshot.hasData && bloc.selectedStream.value!=null)
          value = ( isXAxis ? bloc.stretchySelected.x*1000 : bloc.stretchySelected.y*1000 ).floor();  
        else 
          value = 0;
        return Text(
          (isXAxis ? 'X' : 'Y' ) + ': $value',
          style: Theme.of(context).textTheme.headline
        );
      },
    );
  }

  Widget _buildSlider(ArtboardBloc bloc){
    return StreamBuilder<StretchyModel>(
      stream: bloc.propPanelStream,
      builder: (BuildContext context, AsyncSnapshot<StretchyModel> snapshot){
        if(snapshot.hasData){
            return Container(
              alignment: Alignment.center,
              width: bloc.artboardSize.width,
              child: Slider(
                max: 1 - bloc.stretchySelected.width,
                activeColor: Colors.white,
                inactiveColor: Colors.white,
                value: true ? bloc.stretchySelected.x : bloc.stretchySelected.y,
                onChanged:(double value){
                  bloc.updatePosition(Offset(
                  true ? value - bloc.stretchySelected.x : 0, 
                  true ? 0 : value - bloc.stretchySelected.y,
                  ));
                }
              )
            );
        }
        else {
          return Container(
            alignment: Alignment.center,
            width: bloc.artboardSize.width,
            child: Slider(
              activeColor: Colors.white54,
              value: 0.5,
              onChanged: (_){},
            )
          );
        }
      },
    );
  }
}