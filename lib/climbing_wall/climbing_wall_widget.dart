import 'package:flutter/material.dart';

import 'const.dart';
import 'widgets/horizontal_wall_widget.dart';
import 'widgets/vertical_wall_widget.dart';

class ClimbingWallWidget extends StatefulWidget {
  const ClimbingWallWidget({
    super.key,
    this.color,
    required this.rows,
    required this.columns,
  });

  final Color? color;
  final int rows, columns;

  @override
  State<ClimbingWallWidget> createState() => _ClimbingWallWidgetState();
}

class _ClimbingWallWidgetState extends State<ClimbingWallWidget> {
  double verticalHoldSize = kDefaultHoldSize,
      horizontalHoldSize = kDefaultHoldSize;
  Size screenSize = const Size(0, 0);

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    setScreenWallSize();
  }

  void setScreenWallSize() {
    screenSize = MediaQuery.of(context).size;
    setState(() {
      verticalHoldSize = screenSize.width / widget.columns;
      horizontalHoldSize = screenSize.height / widget.rows;
    });
  }

  @override
  Widget build(BuildContext context) {
    print(verticalHoldSize);
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: widget.color ?? Colors.white,
      child: widget.columns >= widget.rows
          ? VerticalWall(
              rows: widget.rows,
              columns: widget.columns,
              verticalHoldSize: verticalHoldSize,
              exceptions: [],
            )
          : HorizontalWall(
              rows: widget.rows,
              columns: widget.columns,
              horizontalHoldSize: horizontalHoldSize,
            ),
    );
  }
}
