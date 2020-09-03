import 'package:flutter/material.dart';
import 'package:surface_duo/surface_duo.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Surface Duo Test 2'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _selectedItem = 'No selection yet.';

  /// Surface Duo stuff
  bool _isDualScreenDevice = false;
  bool _isAppSpanned = false;
  double _hingeAngle = 180.0;
  int _hingeSize = 0;

  @override
  void initState() {
    super.initState();
    SurfaceDuo.isDualScreenDevice.then((value) {
      setState(() {
        _isDualScreenDevice = value;
      });
    });
  }

  // Surface Duo: We'll use this simple function to query the APIs and report their values
  Future<void> _updateDualScreenInfo() async {
    // print("_updateDualScreenInfo() - Start");
    _isDualScreenDevice = await SurfaceDuo.isDualScreenDevice;
    _isAppSpanned = await SurfaceDuo.isAppSpanned;
    _hingeAngle = await SurfaceDuo.getHingeAngle;
    _hingeSize = await SurfaceDuo.getHingeSize;
    // print("_isDualScreenDevice: $_isDualScreenDevice");
    // print("_isAppSpanned: $_isAppSpanned");
    // print("_hingeAngle: $_hingeAngle");
    // print("_hingeSize: $_hingeSize");
    // print("_updateDualScreenInfo() - End");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          return FutureBuilder<void>(
            future: _updateDualScreenInfo(),
            builder: (context, snapshot) {
              return _createPage();
            },
          );
        },
      ),
    );
  }

  Widget _createPage() {
    if (!_isDualScreenDevice || (_isDualScreenDevice && !_isAppSpanned)) {
      // We are not on a dual-screen device or
      // we are but we are not spanned
      return _buildList();
    } else {
      // We are on a dual-screen device and we are spanned
      if (MediaQuery.of(context).orientation == Orientation.portrait) {
        // Portrait is what we get when we have rotated the device
        // and have two "landscape" screens on top of each other,
        // so together they are "portrait"
        return Column(
          children: [
            Flexible(
              flex: 1,
              child: _buildList(),
            ),
            SizedBox(height: _hingeSize.toDouble()),
            Flexible(
              flex: 1,
              child: Center(
                child: _buildDetails(),
              ),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: _buildList(),
            ),
            SizedBox(width: _hingeSize.toDouble()),
            Flexible(
              flex: 1,
              child: Center(
                child: _buildDetails(),
              ),
            ),
          ],
        );
      }
    }
  }

  Widget _buildList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text('List item #${index + 1}'),
          onTap: () {
            /// Currently, if the user selects an item in single screen mode,
            /// and then spans the app across both screens, we do not actually
            /// move into a spanned mode where we have distinct content on each
            /// screen. todo: figure out how to return to the correct spanned mode.
            if (!_isDualScreenDevice ||
                (_isDualScreenDevice && !_isAppSpanned)) {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) {
                    return Scaffold(
                      appBar: AppBar(),
                      body: Center(
                        child: Text('Item #${index + 1}'),
                      ),
                    );
                  },
                ),
              );
            }
            setState(() => _selectedItem = 'Item #${index + 1}');
          },
        );
      },
    );
  }

  Widget _buildDetails() {
    return Center(
      child: Text(_selectedItem),
    );
  }
}
