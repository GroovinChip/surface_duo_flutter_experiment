import 'package:flutter/material.dart';
import 'package:multi_screen_layout/multi_screen_layout.dart';

void main() {
  runApp(
    MaterialApp(
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MasterDetailLayoutExample();
  }
}

class MasterDetailLayoutExample extends StatefulWidget {
  @override
  _MasterDetailLayoutExampleState createState() =>
      _MasterDetailLayoutExampleState();
}

class _MasterDetailLayoutExampleState extends State<MasterDetailLayoutExample> {
  int selectedItem;

  @override
  Widget build(BuildContext context) {
    return MasterDetailLayout(
      master: Master(
        onItemSelected: (int selected) {
          setState(() => selectedItem = selected);
        },
      ),
      detail: Detail(itemNumber: selectedItem),
      isSelected: selectedItem != null,
    );
  }
}

class Master extends StatelessWidget {
  const Master({
    Key key,
    @required this.onItemSelected,
  }) : super(key: key);

  final void Function(int) onItemSelected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Item List'),
        actions: [
          FlatButton(
            child: Text(
              'CLEAR SELECTION',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => onItemSelected(null),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 10,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(index.toString()),
            trailing: Icon(Icons.chevron_right),
            onTap: () => onItemSelected(index),
          );
        },
      ),
    );
  }
}

class Detail extends StatelessWidget {
  const Detail({
    Key key,
    @required this.itemNumber,
  }) : super(key: key);

  final int itemNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail View'),
      ),
      body: Center(
        child: Text(itemNumber == null ? 'No Selection' : 'Item #$itemNumber'),
      ),
    );
  }
}
