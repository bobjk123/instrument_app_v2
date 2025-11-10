import 'package:flutter/material.dart';

// Small compatibility extension requested by the user: provide `withValues(alpha: )`
// which maps to the standard `withOpacity` behavior. This keeps previous
// replacements working without changing visual output.
extension ColorWithValues on Color {
  Color withValues({double? alpha}) {
    if (alpha == null) return this;
    return withValues(alpha: alpha);
  }
}
