import 'package:climbing_wall/climbing_wall/widgets/hold.dart';
import 'package:climbing_wall/hold_coords.dart';
import 'package:flutter/material.dart';

class HorizontalWall extends StatefulWidget {
  const HorizontalWall({
    super.key,
    required this.rows,
    required this.columns,
    required this.horizontalHoldSize,
    this.exceptions,
  });

  final int rows, columns;
  final double horizontalHoldSize;
  final List<HoldCoords>? exceptions;

  @override
  State<HorizontalWall> createState() => _HorizontalWallState();
}

class _HorizontalWallState extends State<HorizontalWall> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      cacheExtent: double.infinity,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(5),
      scrollDirection: Axis.horizontal,
      itemCount: widget.columns,
      itemBuilder: (_, int indexColumn) {
        return SizedBox(
          height: widget.horizontalHoldSize,
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
                    return const SizedBox();
                  }
                  return Hold(
                    radius: widget.horizontalHoldSize,
                    child: Text(
                      '$indexRow,$indexColumn',
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
