@Deprecated('Use FFAutoImport instead.')

/// Annotation of argument import
class FFArgumentImport {
  const FFArgumentImport([this.suffix]);

  /// The suffix of this import
  /// for example, maybe you need to hide,show
  /// hide xyz,show abc
  final String? suffix;
}
