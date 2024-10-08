import 'package:climbing_wall/climbing_wall/widgets/hold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../hold_coords.dart';

class VerticalWall extends ConsumerStatefulWidget {
  const VerticalWall({
    super.key,
    required this.rows,
    required this.columns,
    required this.verticalHoldSize,
    required this.wallSize,
    this.exceptions,
    this.onPressed,
    this.holdChild,
    this.holdColor,
    this.defaultHoldColor,
  });

  final int rows, columns;
  final double verticalHoldSize;
  final List<HoldCoords>? exceptions;
  final Size wallSize;
  final Function(HoldCoords hold)? onPressed;
  final Widget Function(HoldCoords coords)? holdChild;
  final Color? Function(HoldCoords hold)? holdColor;
  final Color? defaultHoldColor;

  @override
  ConsumerState<VerticalWall> createState() => _NormalVerticalWallWidgetState();
}

class _NormalVerticalWallWidgetState extends ConsumerState<VerticalWall> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: widget.rows,
      itemBuilder: (_, int indexRow) {
        return SizedBox(
          height: widget.verticalHoldSize,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ...List.generate(
                widget.columns,
                (indexColumn) {
                  if (widget.exceptions != null &&
                      widget.exceptions!
                          .where((e) =>
                              e.row == indexRow && e.column == indexColumn)
                          .isNotEmpty) {
                    return Hold.empty(
                      radius: widget.verticalHoldSize,
                      child: Text(
                        '$indexRow,$indexColumn',
                      ),
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
                      radius: widget.verticalHoldSize,
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
