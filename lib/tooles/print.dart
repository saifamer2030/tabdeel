import 'package:flutter/foundation.dart';

bool isInDebugMode() {
  bool inDebugMode = false;
  assert(inDebugMode = true);
  return inDebugMode;
}

void printwithcolors(int bg, int color1, int color2, dynamic data) {
  if (!isInDebugMode()) return;
  if (data is Map) {
    data.keys.forEach((key) {
      debugPrint(
          "\u001b[${bg}m\u001b[38;5;${color1}m Object[\u001b[38;5;${color2}m$key\u001b[38;5;${color1}m] => \u001b[38;5;${color2}m${data[key]?.toString()}");
    });
  } else {
    var messages = data.toString().split("\n");
    messages.forEach((msg) {
      debugPrint("\u001b[${bg}m\u001b[38;5;${color1}m $msg");
    });
  }
}

void printRed(dynamic data) {
  printwithcolors(40, 160, 9, data);
}

void printGreen(dynamic data) {
  printwithcolors(40, 46, 50, data);
}

void printBlue(dynamic data) {
   printwithcolors(47, 21, 17, data);
}

void printYellow(dynamic data) {
   printwithcolors(40, 11, 40, data);
}
