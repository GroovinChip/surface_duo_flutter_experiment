import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:surface_duo_test/app_state.dart';
import 'package:surface_duo_test/detail_view.dart';
import 'package:surface_duo_test/item_list.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppState(),
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState appState, Widget child) {
        return TwoPageLayout(
          child: MainPage(),
          secondChild: DetailView(
            itemNumber: appState.listItem,
          ),
        );
      },
    );
  }
}

/// In single screen mode this will be the first screen the user sees. In spanned
/// mode, this screen will be shown on the left.
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
      ),
      body: ItemList(),
    );
  }
}
