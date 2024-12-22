import 'package:extrator/components/palette_cell.dart';
import 'package:flutter/material.dart';

class PaletteGrid extends StatelessWidget {
  final List<List<Color>> palettes;

  const PaletteGrid(this.palettes, {super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: const BoxDecoration(
            color: Color(0xff3a2c39),
            borderRadius: BorderRadius.all(Radius.circular(20))),
        padding: EdgeInsets.only(top: 20, bottom: 20),
        width: MediaQuery.sizeOf(context).width * 0.95,
        child: Expanded(
            flex: 0,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: palettes
                    .map((palette) => [
                          PaletteCell(palette),
                          SizedBox(
                            height: 10,
                          )
                        ])
                    .expand((e) => e)
                    .toList())));
  }
}
