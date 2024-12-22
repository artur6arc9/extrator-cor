import 'package:extrator/components/color_cell.dart';
import 'package:flutter/material.dart';

class PaletteCell extends StatelessWidget {
  final List<Color> palette;

  const PaletteCell(this.palette, {super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 10,
      alignment: WrapAlignment.center,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: palette.map((color) => ColorCell(color)).toList(),
    );
  }
}
