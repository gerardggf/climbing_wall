class HoldCoords {
  HoldCoords({
    required this.row,
    required this.column,
  });
  final int row;
  final int column;

  @override
  String toString() {
    return 'HoldCoord($row,$column)';
  }
}
