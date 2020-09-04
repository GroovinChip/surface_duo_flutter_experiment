import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:provider/provider.dart';
import 'package:surface_duo_test/app_state.dart';
import 'package:surface_duo_test/detail_view.dart';

/// Show a list of items. When an item is tapped in single screen mode, take
/// the user to the DetailView screen. In spanned mode, simply update the app
/// state to reflect the item chosen and the DetailView on the left screen
/// will update.
class ItemList extends StatelessWidget {
  const ItemList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (BuildContext context, AppState appState, Widget child) {
        return MultiScreenInfo(
          builder: (MultiScreenLayoutInfoModel info) {
            return ListView.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                int item = index + 1;
                return ListTile(
                  title: Text('Item #$item'),
                  onTap: () {
                    if (info.isSpanned) {
                      appState.selectListItem(item);
                    } else {
                      appState.selectListItem(item);
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => DetailView(
                            itemNumber: item,
                          ),
                        ),
                      );
                    }
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
