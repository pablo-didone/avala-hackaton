import 'package:avala_hackaton/cube.dart';
import 'package:avala_hackaton/toolbar.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Avala Hackaton',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: MyHomePage(title: 'Avala Hackaton'),
    );
  }
}

enum DisplacementDirection { top, right, bottom, left }

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Offset cubeOffset = Offset.zero;
  Offset squarePosition = Offset.zero;
  double squareWidth = 50;
  double squareHeight = 50;

  void displace(DisplacementDirection direction) {
    final stepSize = 5;
    Offset newOffset;

    switch (direction) {
      case DisplacementDirection.top:
        newOffset = Offset(cubeOffset.dx, cubeOffset.dy - stepSize);
        break;
      case DisplacementDirection.right:
        newOffset = Offset(cubeOffset.dx + stepSize, cubeOffset.dy);
        break;
      case DisplacementDirection.bottom:
        newOffset = Offset(cubeOffset.dx, cubeOffset.dy + stepSize);
        break;
      case DisplacementDirection.left:
        newOffset = Offset(cubeOffset.dx - stepSize, cubeOffset.dy);
        break;
    }

    setState(() {
      cubeOffset = newOffset;
    });
  }

  void resize(DisplacementDirection direction) {
    final stepSize = 2;
    double newWidth = squareWidth;
    double newHeight = squareHeight;

    switch (direction) {
      case DisplacementDirection.top:
        newHeight = newHeight - stepSize;
        break;
      case DisplacementDirection.right:
        newWidth = newWidth + stepSize;
        break;
      case DisplacementDirection.bottom:
        newHeight = newHeight + stepSize;
        break;
      case DisplacementDirection.left:
        newWidth = newWidth - stepSize;
        break;
    }

    setState(() {
      squareHeight = newHeight;
      squareWidth = newWidth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/cars.jpeg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Draggable(
                  child: Cube(
                    topLeft: squarePosition,
                    width: squareWidth,
                    height: squareHeight,
                    backSquareOffset: cubeOffset,
                  ),
                  feedback: Cube(
                    topLeft: squarePosition,
                    width: squareWidth,
                    height: squareHeight,
                    backSquareOffset: cubeOffset,
                  ),
                  childWhenDragging: Container(),
                  onDragEnd: (dragDetails) {
                    setState(() {
                      squarePosition = squarePosition + dragDetails.offset - Offset(0, 80);
                    });
                  },
                )
              ],
            ),
          ),
          Container(
            color: Colors.black,
            child: ToolBar(
              onDisplace: displace,
              onResize: resize,
            ),
          ),
        ],
      ),
    );
  }
}
