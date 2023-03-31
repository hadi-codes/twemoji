enum FitzpatrickType {
  /// Fitzpatrick modifier of type 1/2 (pale white/white)
  type1_2,

  /// Fitzpatrick modifier of type 3 (cream white)
  type3,

  /// Fitzpatrick modifier of type 4 (moderate brown)
  type4,

  /// Fitzpatrick modifier of type 5 (dark brown)
  type5,

  /// Fitzpatrick modifier of type 6 (black)
  type6
}

extension FitzpatrickTypeExtension on FitzpatrickType {
  /// Gets the corresponding unicode representation of that fitzpatrick type.
  String get unicode {
    switch (this) {
      case FitzpatrickType.type1_2:
        return '1f3fb';
      case FitzpatrickType.type3:
        return '1f3fc';
      case FitzpatrickType.type4:
        return '1f3fd';
      case FitzpatrickType.type5:
        return '1f3fe';
      case FitzpatrickType.type6:
        return '1f3ff';
    }
  }
}
