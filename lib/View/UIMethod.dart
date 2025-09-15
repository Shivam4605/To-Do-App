import 'dart:ui';

class ContainerolorMethod {
  // this method is used to return the colors of containers
  Color containercolors(int checkcontainerindex) {
    if (checkcontainerindex % 4 == 0) {
      return Color(0xFFFAE8E8);
    } else if (checkcontainerindex % 4 == 1) {
      return Color(0xFFE8EDFA);
    } else if (checkcontainerindex % 4 == 2) {
      return Color(0xFFFAF9E8);
    } else if (checkcontainerindex % 4 == 3) {
      return Color(0xFFFAE8FA);
    } else {
      return Color(0xFFFAE8E8);
    }
  }
}
