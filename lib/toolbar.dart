import 'package:avala_hackaton/main.dart';
import 'package:flutter/material.dart';

class ToolBar extends StatelessWidget {
  const ToolBar({
    Key? key,
    required this.onDisplace,
    required this.onResize,
  }) : super(key: key);

  final void Function(DisplacementDirection) onDisplace;
  final void Function(DisplacementDirection) onResize;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            children: [
              LongPressingButton(
                child: Transform.rotate(angle: 1.5708, child: Icon(Icons.unfold_more)),
                callback: () => onResize(DisplacementDirection.right),
              ),
              Expanded(
                child: Center(
                  child: LongPressingButton(
                    child: Icon(Icons.expand_less),
                    callback: () => onDisplace(DisplacementDirection.top),
                  ),
                ),
              ),
              LongPressingButton(
                child: Icon(Icons.unfold_less),
                callback: () => onResize(DisplacementDirection.top),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              LongPressingButton(
                child: Icon(Icons.chevron_left),
                callback: () => onDisplace(DisplacementDirection.left),
              ),
              SizedBox(width: 20),
              LongPressingButton(
                child: Icon(Icons.chevron_right),
                callback: () => onDisplace(DisplacementDirection.right),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              LongPressingButton(
                child: Transform.rotate(angle: 1.5708, child: Icon(Icons.unfold_less)),
                callback: () => onResize(DisplacementDirection.left),
              ),
              Expanded(
                child: Center(
                  child: LongPressingButton(
                    child: Icon(Icons.expand_more),
                    callback: () => onDisplace(DisplacementDirection.bottom),
                  ),
                ),
              ),
              LongPressingButton(
                child: Icon(Icons.unfold_more),
                callback: () => onResize(DisplacementDirection.bottom),
              ),
            ],
          )
        ],
      ),
    );
  }
}

class LongPressingButton extends StatefulWidget {
  const LongPressingButton({Key? key, required this.child, required this.callback});

  final Widget child;
  final Function callback;

  @override
  _LongPressingButtonState createState() => _LongPressingButtonState();
}

class _LongPressingButtonState extends State<LongPressingButton> {
  bool isPressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: Container(
        color: Colors.red.shade600,
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 8),
        child: widget.child,
      ),
      onTap: () => widget.callback(),
      onLongPressStart: (_) async {
        isPressed = true;
        do {
          widget.callback();
          await Future.delayed(Duration(milliseconds: 30));
        } while (isPressed);
      },
      onLongPressEnd: (_) => setState(() => isPressed = false),
    );
  }
}
