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
      builder: (context, value, child) {
        return TwoPageLayout(
          child: MainPage(),
          secondChild: DetailView(
            itemNumber: value.listItem,
          ),
        );
      },
    );
  }
}

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
