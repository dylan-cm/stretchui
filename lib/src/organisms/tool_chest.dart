import 'package:flutter/material.dart';

class ToolChest extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      color: Colors.grey[900],
      width: screen.width*.1,
      height: screen.height,
      padding: EdgeInsets.all(4),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(
            flex: 4,
            child: Container(),
          ),
          RaisedButton(
            onPressed: (){},
            child: Container(
              height: screen.width*.1,
              child: Icon(Icons.add_box, size: 56,),
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