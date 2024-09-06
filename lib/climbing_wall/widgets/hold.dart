import 'package:climbing_wall/hold_coords.dart';
import 'package:flutter/material.dart';

class Hold extends StatelessWidget {
  const Hold({
    super.key,
    required this.radius,
    this.onPressed,
    this.color,
    this.child,
  });
  final double radius;
  final Color? color;
  final Widget? child;
  final Function(HoldCoords hold)? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: radius,
      width: radius,
      child: Container(
        margin: const EdgeInsets.all(2),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: color ?? Colors.grey,
        ),
        child: child == null
            ? null
            : Center(
                child: child,
              ),
      ),
    );
  }

  static Widget empty({
    required double radius,
    Widget? child,
  }) {
    return SizedBox(
      height: radius,
      width: radius,
      child: child == null
          ? null
          : Center(
              child: child,
            ),
    );
  }
}
