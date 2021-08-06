import 'package:flutter/material.dart';

class Cube extends StatelessWidget {
  const Cube({
    Key? key,
    required this.topLeft,
    required this.width,
    required this.height,
    this.backSquareOffset = Offset.zero,
  }) : super(key: key);

  final Offset topLeft;
  final double width;
  final double height;
  final Offset backSquareOffset;

  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: topLeft.dy, left: topLeft.dx),
      width: width,
      height: height,
      color: Colors.transparent,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Transform.translate(
            offset: backSquareOffset,
            child: CustomPaint(painter: RectanglePainter(a: Offset.zero, b: Offset(width, height), color: Colors.red)),
          ),
          CustomPaint(
            painter: RectanglePainter(a: Offset.zero, b: Offset(width, height), color: Colors.red),
          ),
          // Left
          CustomPaint(
            painter: PoligonPainter(
              topLeft: backSquareOffset,
              topRight: Offset.zero,
              bottomLeft: Offset(backSquareOffset.dx, backSquareOffset.dy + height),
              bottomRigth: Offset(0, height),
            ),
          ),
          // Right
          CustomPaint(
            painter: PoligonPainter(
              topLeft: Offset(backSquareOffset.dx + width, backSquareOffset.dy),
              topRight: Offset(width, 0),
              bottomLeft: Offset(backSquareOffset.dx + width, backSquareOffset.dy + height),
              bottomRigth: Offset(width, height),
            ),
          ),
          // Top
          CustomPaint(
            painter: PoligonPainter(
              topLeft: backSquareOffset,
              topRight: Offset(backSquareOffset.dx + width, backSquareOffset.dy),
              bottomLeft: Offset.zero,
              bottomRigth: Offset(width, 0),
            ),
          ),
          // Bottom
          CustomPaint(
            painter: PoligonPainter(
              topLeft: Offset(backSquareOffset.dx, backSquareOffset.dy + height),
              topRight: Offset(backSquareOffset.dx + width, backSquareOffset.dy + height),
              bottomLeft: Offset(0, height),
              bottomRigth: Offset(width, height),
            ),
          ),
          Positioned(
            top: height - 5,
            left: width - 5,
            child: ResizeHandlerBall(
              onDrag: () {
                print('details');
              },
            ),
          ),
        ],
      ),
    );
  }
}

class ResizeHandlerBall extends StatelessWidget {
  const ResizeHandlerBall({Key? key, required this.onDrag});

  final void Function() onDrag;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: (DragStartDetails details) {
        print(details);
      },
      onPanUpdate: (DragUpdateDetails details) {
        print(details);
      },
      child: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
          color: Colors.red,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

class RectanglePainter extends CustomPainter {
  const RectanglePainter({
    required this.a,
    required this.b,
    this.color = Colors.white,
  });

  final Offset a;
  final Offset b;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = this.color.withOpacity(0.3)
      ..strokeWidth = 2
      ..style = PaintingStyle.fill;

    final rect = Rect.fromPoints(a, b);
    canvas.drawRect(rect, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}

class PoligonPainter extends CustomPainter {
  const PoligonPainter({
    required this.topLeft,
    required this.topRight,
    required this.bottomLeft,
    required this.bottomRigth,
  });

  final Offset topLeft;
  final Offset topRight;
  final Offset bottomLeft;
  final Offset bottomRigth;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.red.withOpacity(0.3)
      ..style = PaintingStyle.fill;

    final paint2 = Paint()
      ..color = Colors.red
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    Path path = Path();
    path.addPolygon([
      bottomRigth,
      bottomLeft,
      topLeft,
      topRight,
    ], true);

    Path path2 = Path();
    path2.addPolygon([
      bottomRigth,
      bottomLeft,
      topLeft,
      topRight,
    ], true);

    canvas.drawPath(path, paint);
    canvas.drawPath(path2, paint2);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
