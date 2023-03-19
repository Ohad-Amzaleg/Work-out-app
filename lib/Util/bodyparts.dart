import 'dart:ui';

import 'package:flutter/material.dart';

class PictureWithButtons extends StatefulWidget {
  @override
  _PictureWithButtonsState createState() => _PictureWithButtonsState();
}

class _PictureWithButtonsState extends State<PictureWithButtons> {
  List<Offset> _endPoints = [
    Offset(100, 200),
    Offset(300, 400),
    Offset(500, 600),
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('images/HumanBody.png', fit: BoxFit.fill),
        CustomPaint(
          painter: MyPainter(endPoints: _endPoints),
          child: Container(
            width: double.infinity,
            height: double.infinity,
          ),
        ),
        GestureDetector(
          onTap: () {
          },
          child: Stack(
            children: _endPoints
                .map(
                  (endPoint) => Positioned(
                left: endPoint.dx - 10,
                top: endPoint.dy - 10,
                child: ElevatedButton(
                  onPressed: () {
                    // handle button tap
                  },
                  child: Text('Button'),
                ),
              ),
            )
                .toList(),
          ),
        ),
      ],
    );
  }
}

class MyPainter extends CustomPainter {
  final List<Offset> endPoints;

  MyPainter({required this.endPoints});

  @override
  void paint(Canvas canvas, Size size) {
    // draw lines
    Paint paint = Paint()..color = Colors.blue;
    for (int i = 0; i < endPoints.length; i++) {
      canvas.drawLine(Offset(0, 0), endPoints[i], paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
