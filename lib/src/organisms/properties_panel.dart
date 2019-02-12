import 'package:flutter/material.dart';

class PropPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    return Container(
      alignment: AlignmentDirectional.center,
      width: screen.width*0.9,
      height: screen.height*.1,
      color: Colors.grey[900],
      padding: EdgeInsets.all(16.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Expanded(flex: 8, child: Container()),
          Text('X '),
          Container(
            width: 44,
            height: 44,
            child: TextField(),
          ),
          Text('Y '),
          Container(
            width: 44,
            height: 44,
            child: TextField(
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(flex: 8, child: Container()),
        ],
      ),
    );
  }
}