import 'package:extrator/services/palette_file/gpl_file_generator.dart';
import 'package:extrator/services/palette_file/hex_file_generator.dart';
import 'package:extrator/services/palette_file/pal_file_generator.dart';
import 'package:extrator/services/palette_file/palette_file_generator.dart';

enum PaletteFileType {
  pal(PalFileGenerator()),
  hex(HexFileGenerator()),
  gpl(GplFileGenerator())
  ;
  final PaletteFileGenerator generator;
  const PaletteFileType(this.generator);
}