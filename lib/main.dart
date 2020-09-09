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
    return TwoPageLayout(
      child: MainPage(),
      secondChild: SecondPage(),
    );
  }
}

/// In single screen mode this will be the first screen the user sees. In spanned
/// mode, this screen will be shown on the left.
class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiScreenInfo(
      builder: (MultiScreenLayoutInfoModel info) {
        return Scaffold(
          appBar: AppBar(
            title: Text('Dialog Experiment'),
          ),
          body: Center(
            child: RaisedButton(
              child: Text('Open Dialog'),
              onPressed: () => showDialog(
                context: context,
                builder: (_) => Stack(
                  children: [
                    Positioned(
                      left: 100,
                      top: MediaQuery.of(context).size.height / 3,
                      child: AlertDialog(
                        title: Text(!info.isSpanned
                            ? 'This is a dialog'
                            : 'This is a dialog on the left screen'),
                        actions: [
                          FlatButton(
                            child: Text('OK'),
                            onPressed: () => Navigator.of(context).pop(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

/// In spanned mode, this screen will be shown on the right.
class SecondPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
