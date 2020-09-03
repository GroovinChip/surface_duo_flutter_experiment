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
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
  int _counter = 0;

  /// Surface Duo stuff
  bool _isDualScreenDevice = false;
  bool _isAppSpanned = false;
  double _hingeAngle = 180.0;
  int _hingeSize = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  Widget _createPage() {
    if (!_isDualScreenDevice || (_isDualScreenDevice && !_isAppSpanned)) {
      // We are not on a dual-screen device or
      // we are but we are not spanned
      return _buildBody();
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
              child: _buildBody(),
            ),
            SizedBox(height: _hingeSize.toDouble()),
            Flexible(
              flex: 1,
              child: Center(child: FlutterLogo(size: 200.0)),
            ),
          ],
        );
      } else {
        return Row(
          children: [
            Flexible(
              flex: 1,
              child: _buildBody(),
            ),
            SizedBox(width: _hingeSize.toDouble()),
            Flexible(
              flex: 1,
              child: Center(child: FlutterLogo(size: 200.0)),
            ),
          ],
        );
      }
    }
  }

  Widget _buildBody() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'You have pushed the button this many times:',
          ),
          Text(
            '$_counter',
            style: Theme.of(context).textTheme.headline4,
          ),
        ],
      ),
    );
  }
}
