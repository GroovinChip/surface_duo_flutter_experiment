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

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Main Page'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('This page always displays!'),
          ),
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Surface Duo Device Info'),
                  trailing: Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => SurfaceDuoInfoPage(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  final bool showAppBar;

  const SecondPage({
    Key key,
    this.showAppBar = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: showAppBar
          ? AppBar(
              title: Text('Second Page'),
            )
          : null,
      backgroundColor: Colors.tealAccent,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('This page only shows when spanned on 2 screens!'),
          ],
        ),
      ),
    );
  }
}

class SurfaceDuoInfoPage extends StatelessWidget {
  const SurfaceDuoInfoPage();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Surface Duo Info'),
      ),
      body: MultiScreenInfo(
        builder: (info) {
          return TwoPageLayout(
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text('The below information is from the Surface Duo SDK'),
                  Text(
                      'isDualScreenDevice: ${info.surfaceDuoInfoModel.isDualScreenDevice}'),
                  Text('isAppSpanned: ${info.surfaceDuoInfoModel.isSpanned}'),
                  Text('hingeAngle: ${info.surfaceDuoInfoModel.hingeAngle}'),
                ],
              ),
            ),
            secondChild: SecondPage(
              showAppBar: false,
            ),
          );
        },
      ),
    );
  }
}
