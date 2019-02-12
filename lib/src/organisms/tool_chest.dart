import 'package:flutter/material.dart';
import '../bloc_provider.dart';
import '../pages/artboard_bloc.dart';

class ToolChest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final bloc = BlocProvider.of<ArtBloc>(context);
    return Container(
      color: Colors.grey[900],
      width: screen.width*0.1,
      height: screen.height*0.9,
      padding: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(),
          ),
          FlatButton(
            onPressed: ()=>bloc.addStretchy(),
            child: Container(
              height: screen.width*.1,
              child: Icon(Icons.add_box, size: 56, color: Colors.white,),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          RaisedButton(
            onPressed: (){},
            child: Container(
              height: screen.width*.1,
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(),
          ),
          RaisedButton(
            onPressed: (){},
            child: Container(
              height: screen.width*.1,
            ),
          ),
          Expanded(
            flex: 4,
            child: Container(),
          ),
        ],
      ),
    );
  }
}