import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

/// Show the list item selected by the user. If no selection (which is by default),
/// show 'No Selection'.
class DetailView extends StatelessWidget {
  const DetailView({
    Key key,
    @required this.itemNumber,
  }) : super(key: key);

  /// The list item to show
  final int itemNumber;

  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (MultiScreenLayoutInfoModel info) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Detail View'),
          ),
          body: Center(
            child: Text(itemNumber == 0 ? 'No Selection' : 'Item #$itemNumber'),
          ),
        );
      },
    );
  }
}
