import 'package:flutter/foundation.dart';

/// Small class to hold some app state
class AppState extends ChangeNotifier {
  /// The list item the user has clicked.
  int listItem = 0;

  /// Set the value of `listItem`
  void selectListItem(int item) {
    listItem = item;
    notifyListeners();
  }
}
