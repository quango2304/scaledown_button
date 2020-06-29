library scaledownbutton;

import 'package:flutter/material.dart';

class ScaleDownButton extends StatefulWidget {
  final Widget child;
  final Function onTap;
  final double scale;

  const ScaleDownButton({Key key, this.child, this.onTap, this.scale = 0.1})
      : super(key: key);
  @override
  _ScaleDownButtonState createState() => _ScaleDownButtonState();
}

class _ScaleDownButtonState extends State<ScaleDownButton>
    with SingleTickerProviderStateMixin {
  AnimationController controller;

  @override
  void initState() {
    super.initState();
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 100));
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: GestureDetector(
        onTapDown: (detail) {
          controller.forward();
        },
        onTapUp: (detail) {
          Future.delayed(Duration(milliseconds: 200), () {
            controller.reverse();
            if (widget.onTap != null) {
              widget.onTap();
            }
          });
        },
        onTapCancel: () {
          controller.reverse();
        },
        child: widget.child,
      ),
      builder: (context, child) {
        return Transform.scale(
          scale: 1 - controller.value * widget.scale,
          child: child,
        );
      },
    );
  }
}
