enum ColorGroup {
  red(hueStart: 345, hueEnd: 30),
  blue(hueStart: 180, hueEnd: 270),
  yellow(hueStart: 45, hueEnd: 90),
  green(hueStart: 90, hueEnd: 180),
  pink(hueStart: 300, hueEnd: 345),
  purple(hueStart: 270, hueEnd: 300),
  orange(hueStart: 30, hueEnd: 60),
  black(
      hueStart: 0,
      hueEnd: 360,
      saturationStart: 0,
      saturationEnd: 0.3,
      lighnessStart: 0.7,
      lighnessEnd: 1),
  white(
      hueStart: 0,
      hueEnd: 360,
      saturationStart: 0,
      saturationEnd: 0.3,
      lighnessStart: 0,
      lighnessEnd: 0.3),
  gray(
      hueStart: 0,
      hueEnd: 360,
      saturationStart: 0,
      saturationEnd: 0.3,
      lighnessStart: 0.3,
      lighnessEnd: 0.7),
  ;

  final int hueStart;
  final int hueEnd;
  final double saturationStart;
  final double saturationEnd;
  final double lighnessStart;
  final double lighnessEnd;

  const ColorGroup({
    required this.hueStart,
    required this.hueEnd,
    this.saturationStart = 0.3,
    this.saturationEnd = 1,
    this.lighnessEnd = 1,
    this.lighnessStart = 0,
  });
}
