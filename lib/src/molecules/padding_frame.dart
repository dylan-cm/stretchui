import 'package:flutter/material.dart';
import 'package:path_drawing/path_drawing.dart';

class PaddingFrame extends StatelessWidget {
  final double width, height, intPadding, extPadding;
  
  PaddingFrame({this.width, this.height, this.intPadding, this.extPadding});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, consraints){
        return CustomPaint(
          painter: _DashPathPainter(
            width: width,
            height: height,
            intPadding: intPadding,
            extPadding: extPadding
          ),
        );
      },
    );
  }
  
}

class _DashPathPainter extends CustomPainter {
  final double width, height, intPadding, extPadding;
  
  _DashPathPainter({this.width, this.height, this.intPadding, this.extPadding});

  @override
  bool shouldRepaint(_DashPathPainter oldDelegate) => true;

  @override
  void paint(Canvas canvas, Size size) {
    canvas.drawPath(
      dashPath(
        Path()
        ..addRect(Rect.fromLTRB(
        width/-2 - extPadding ,
        height/-2 - extPadding, 
        width/2 + extPadding ,
        height/2 + extPadding,
        ))
        ..addRect(Rect.fromLTRB(
        width/-2 + intPadding ,
        height/-2 + intPadding, 
        width/2 - intPadding ,
        height/2 - intPadding,
        )),
        dashArray: CircularIntervalList<double>(
          <double>[5.0, 5.0],
        ),
      ),
      Paint()
      ..color = Colors.cyanAccent
      ..strokeWidth = 2.0
      ..style = PaintingStyle.stroke
    );
    
  }
}