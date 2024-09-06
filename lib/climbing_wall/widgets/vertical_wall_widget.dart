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
    this.exceptions,
  });

  final int rows, columns;
  final double verticalHoldSize;
  final List<HoldCoords>? exceptions;

  @override
  ConsumerState<VerticalWall> createState() => _NormalVerticalWallWidgetState();
}

class _NormalVerticalWallWidgetState extends ConsumerState<VerticalWall> {
  @override
  Widget build(BuildContext context) {
    print(widget.verticalHoldSize);
    return ListView.builder(
      cacheExtent: double.infinity,
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(5),
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
                    return const SizedBox();
                  }
                  return Hold(
                    radius: widget.verticalHoldSize,
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
