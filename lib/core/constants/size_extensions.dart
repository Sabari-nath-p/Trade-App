/// Lightweight replacement for `flutter_screenutil` numeric extensions.
///
/// This intentionally returns the original number as a `double`, so existing
/// `.w/.h/.sp/.r` usages become direct (unscaled) values.
extension DirectSizeValues on num {
  double get w => toDouble();
  double get h => toDouble();
  double get sp => toDouble();
  double get r => toDouble();

  // Included for completeness if any code uses screen-based helpers.
  // Here they also behave as direct values (no scaling).
  double get sw => toDouble();
  double get sh => toDouble();
}
