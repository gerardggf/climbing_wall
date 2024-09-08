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

  @override
  bool operator ==(Object other) {
    if (other is HoldCoords) {
      return other.row == row && other.column == column;
    }
    return false;
  }

  @override
  int get hashCode => Object.hash(row, column);
}
