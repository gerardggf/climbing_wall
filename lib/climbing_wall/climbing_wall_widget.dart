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
    this.padding,
    this.holdChild,
    this.onPressed,
    this.holdColor,
    this.defaultHoldColor,
  });

  ///Background climbing wall color.
  ///
  ///By default set to white
  final Color? backgroundColor;

  ///Climbing wall rows and columns to be painted
  final int rows, columns;

  ///Set the climbing wall padding dimensions.
  ///
  ///By default set to 5 pixels in all directions
  final EdgeInsets? padding;

  ///Set the widget shown inside each hold
  ///
  ///"coords" parameter shows the current hold coordinates in the wall
  final Widget Function(HoldCoords coords)? holdChild;

  ///Function called when a hold is pressed
  final void Function(HoldCoords hold)? onPressed;

  ///Set the current hold color
  final Color? Function(HoldCoords hold)? holdColor;

  ///Change the default hold color
  ///
  ///By default set to grey ([Colors.grey])
  final Color? defaultHoldColor;

  @override
  State<ClimbingWallWidget> createState() => _ClimbingWallWidgetState();
}

class _ClimbingWallWidgetState extends State<ClimbingWallWidget> {
  double verticalHoldSize = kDefaultHoldSize,
      horizontalHoldSize = kDefaultHoldSize;
  Size widgetSize = const Size(0, 0);

  final GlobalKey _key = GlobalKey();

  @override
  void didChangeDependencies() {
    setScreenWallSize();
    super.didChangeDependencies();
  }

  void setScreenWallSize() {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        final renderBox = _key.currentContext?.findRenderObject() as RenderBox?;

        widgetSize = renderBox?.size ?? const Size(0, 0);
        setState(
          () {
            verticalHoldSize = widget.columns > 0
                ? widgetSize.width / widget.columns
                : kDefaultHoldSize;
            horizontalHoldSize = widget.rows > 0
                ? (widgetSize.height - kToolbarHeight) / widget.rows
                : kDefaultHoldSize;
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.all(5),
      child: Container(
        key: _key,
        width: double.maxFinite,
        height: double.maxFinite,
        color: widget.backgroundColor ?? Colors.white,
        child: widget.columns <= widget.rows
            ? VerticalWall(
                rows: widget.rows,
                columns: widget.columns,
                verticalHoldSize: verticalHoldSize,
                wallSize: Size(
                  widgetSize.width,
                  widgetSize.height,
                ),
                exceptions: [
                  HoldCoords(
                    row: 3,
                    column: 2,
                  ),
                ],
                onPressed: widget.onPressed,
                holdChild: widget.holdChild,
                holdColor: widget.holdColor,
                defaultHoldColor: widget.defaultHoldColor,
              )
            : HorizontalWall(
                rows: widget.rows,
                columns: widget.columns,
                horizontalHoldSize: horizontalHoldSize,
                wallSize: Size(
                  widgetSize.width,
                  widgetSize.height,
                ),
                onPressed: widget.onPressed,
                holdChild: widget.holdChild,
                holdColor: widget.holdColor,
                defaultHoldColor: widget.defaultHoldColor,
              ),
      ),
    );
  }
}
