import 'package:flutter/material.dart';

class Hold extends StatelessWidget {
  const Hold({
    super.key,
    required this.radius,
    this.color,
    this.child,
  });
  final double radius;
  final Color? color;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: radius,
      width: radius,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color ?? Colors.grey,
      ),
      child: child,
    );
  }
}
