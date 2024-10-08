import 'package:climbing_wall/climbing_wall/widgets/hold.dart';
import 'package:climbing_wall/hold_coords.dart';
import 'package:flutter/material.dart';

class HorizontalWall extends StatefulWidget {
  const HorizontalWall({
    super.key,
    required this.rows,
    required this.columns,
    required this.horizontalHoldSize,
    required this.wallSize,
    this.exceptions,
    this.onPressed,
    this.holdChild,
    this.holdColor,
    this.defaultHoldColor,
  });

  final int rows, columns;
  final double horizontalHoldSize;
  final List<HoldCoords>? exceptions;
  final Size wallSize;
  final Function(HoldCoords hold)? onPressed;
  final Widget Function(HoldCoords coords)? holdChild;
  final Color? Function(HoldCoords hold)? holdColor;
  final Color? defaultHoldColor;

  @override
  State<HorizontalWall> createState() => _HorizontalWallState();
}

class _HorizontalWallState extends State<HorizontalWall> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      scrollDirection: Axis.horizontal,
      itemCount: widget.columns,
      itemBuilder: (_, int indexColumn) {
        return SizedBox(
          width: widget.horizontalHoldSize,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                widget.rows,
                (indexRow) {
                  if (widget.exceptions != null &&
                      widget.exceptions!
                          .where((e) =>
                              e.row == indexRow && e.column == indexColumn)
                          .isNotEmpty) {
                    return Hold.empty(
                      radius: widget.horizontalHoldSize,
                    );
                  }
                  return InkWell(
                    borderRadius: BorderRadius.circular(50),
                    onTap: () {
                      if (widget.onPressed == null) return;
                      widget.onPressed!(
                        HoldCoords(
                          row: indexRow,
                          column: indexColumn,
                        ),
                      );
                    },
                    child: Hold(
                      radius: widget.horizontalHoldSize,
                      color: widget.holdColor == null
                          ? null
                          : widget.holdColor!(
                              HoldCoords(
                                row: indexRow,
                                column: indexColumn,
                              ),
                            ),
                      defaultColor: widget.defaultHoldColor ?? Colors.grey,
                      child: widget.holdChild == null
                          ? null
                          : widget.holdChild!(
                              HoldCoords(
                                row: indexRow,
                                column: indexColumn,
                              ),
                            ),
                    ),
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
