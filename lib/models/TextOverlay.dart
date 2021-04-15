import 'dart:math';

import 'package:flutter/foundation.dart';

class TextOverlay with ChangeNotifier{

  String message = 'The sprinter';
  int repsNumber = 0;

  void changeString () {
    var r = Random();
    const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    this.message = List.generate(10, (index) => _chars[r.nextInt(_chars.length)]).join();
    notifyListeners();
  }

  void increment () {
    repsNumber++;
    notifyListeners();
  }
}