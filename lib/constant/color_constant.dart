import 'export.dart';

class ColorConstant {
  static Color primaryColor = fromHex('#7B1FA2');
  static Color accentColor = fromHex('#E040FB');
  static Color black900 = fromHex('#000000');
  static Color white900 = fromHex('#FFFFFF');
  static Color gray100 = fromHex('#f2f6fb');
  static Color blueGray100 = fromHex('#d9d9d9');
  static Color black90087 = fromHex('#87000000');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}
