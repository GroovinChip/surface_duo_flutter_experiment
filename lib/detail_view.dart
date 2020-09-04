import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

class DetailView extends StatelessWidget {
  const DetailView({
    Key key,
    @required this.itemNumber,
  }) : super(key: key);

  final int itemNumber;

  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (info) {
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
