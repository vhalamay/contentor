import 'package:flutter/painting.dart';

const watermarkTextStyle = TextStyle(
  fontFamily: 'NotoSans',
  fontSize: 40,
  fontWeight: FontWeight.w600,
  fontVariations: [FontVariation('wght', 600)],
  color: Color(0xE6FFFFFF),
  shadows: [Shadow(color: Color(0xAA000000), blurRadius: 4, offset: Offset(1, 1))],
);
const double watermarkInset = 16;
