import 'package:climbing_wall/hold_coords.dart';
import 'package:flutter/material.dart';

import 'const.dart';
import 'widgets/horizontal_wall_widget.dart';
import 'widgets/vertical_wall_widget.dart';

class ClimbingWallWidget extends StatefulWidget {
  const ClimbingWallWidget({
    super.key,
    required this.rows,
    required this.columns,
    this.backgroundColor,
  });

  final Color? backgroundColor;
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
    setScreenWallSize();
    super.didChangeDependencies();
  }

  void setScreenWallSize() {
    screenSize = MediaQuery.of(context).size;
    setState(() {
      verticalHoldSize = widget.columns > 0
          ? screenSize.width / widget.columns
          : kDefaultHoldSize;
      horizontalHoldSize =
          widget.rows > 0 ? screenSize.height / widget.rows : kDefaultHoldSize;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: screenSize.width,
      height: screenSize.height,
      color: widget.backgroundColor ?? Colors.white,
      child: widget.columns >= widget.rows
          ? VerticalWall(
              rows: widget.rows,
              columns: widget.columns,
              verticalHoldSize: verticalHoldSize,
              wallSize: Size(
                screenSize.width,
                screenSize.height,
              ),
              exceptions: [
                HoldCoords(
                  row: 3,
                  column: 2,
                ),
              ],
              onPressed: (hold) {
                print(hold.toString());
              },
            )
          : HorizontalWall(
              rows: widget.rows,
              columns: widget.columns,
              horizontalHoldSize: horizontalHoldSize,
              wallSize: Size(
                screenSize.width,
                screenSize.height,
              ),
              onPressed: (hold) {
                print(hold.toString());
              },
            ),
    );
  }
}
