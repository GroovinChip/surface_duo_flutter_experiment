import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';
import 'package:provider/provider.dart';
import 'package:surface_duo_test/app_state.dart';
import 'package:surface_duo_test/detail_view.dart';

class ItemList extends StatelessWidget {
  const ItemList({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<AppState>(
      builder: (context, value, child) => MultiScreenInfo(
        builder: (info) => ListView.builder(
          itemCount: 10,
          itemBuilder: (context, index) {
            int item = index + 1;
            return ListTile(
              title: Text('Item #$item'),
              onTap: () {
                if (info.isSpanned) {
                  value.selectListItem(item);
                } else {
                  value.selectListItem(item);
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
        ),
      ),
    );
  }
}
