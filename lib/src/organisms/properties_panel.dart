import 'package:flutter/material.dart';

class PropPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Size screen = MediaQuery.of(context).size;
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
          const Text('X '),
          Container(
            width: 44,
            height: 44,
            child: const TextField(),
          ),
          const Text('Y '),
          Container(
            width: 44,
            height: 44,
            child: const TextField(
              keyboardType: TextInputType.number,
            ),
          ),
          Expanded(flex: 8, child: Container()),
        ],
      ),
    );
  }
}