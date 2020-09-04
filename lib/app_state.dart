import 'package:flutter/foundation.dart';

class AppState extends ChangeNotifier {
  int listItem = 0;

  void selectListItem(int item) {
    listItem = item;
    notifyListeners();
  }
}
