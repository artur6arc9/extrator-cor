import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:extrator/extensions/hex_extension.dart';

class ColorCell extends StatelessWidget {
  const ColorCell(this.color, {super.key});

  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Clipboard.setData(ClipboardData(text: color.toHex()));
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("cor ${color.toHex()} salvo")));
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.white, width: 2),
            color: color,
          ),
          width: 100,
          height: 100,
        ));
  }
}
