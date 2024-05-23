import 'package:flutter/material.dart';
import 'package:flutter_h5/flutter2js_by_runjs.dart';
import 'package:flutter_h5/js2flutter_by_channel.dart';
import 'package:flutter_h5/jump/flutter_h5_jump_asset.dart';

import 'flutter2js_by_url.dart';
import 'js2flutter_by_url.dart';
import 'jump/flutter_h5_jump_html_file.dart';
import 'login/flutter_h5_login_sync_by_cookie.dart';
import 'login/flutter_h5_sync_by_channel.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            _navButton(
              context,
              JS2Flutter(),
              'JS2Flutter',
            ),
            _navButton(
              context,
              JS2FlutterByChannel(),
              'JS2FlutterByChannel',
            ),
            _navButton(
              context,
              Flutter2JSByUrl(),
              'Flutter2JSByUrl',
            ),
            _navButton(context, Flutter2JSByRunJavascript(), 'Flutter2JSByRunJavascript'),
            _navButton(context, FlutterH5AssetJump(), 'FlutterH5AssetJump'),
            _navButton(context, FlutterH5FileJump(), 'FlutterH5FileJump'),
            _navButton(context, FlutterH5LoginCookie(), 'FlutterH5LoginCookie'),
            _navButton(context, FlutterH5LoginChannel(), 'FlutterH5LoginChannel')
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  _navButton(BuildContext context,Widget page,String title) {
    return FilledButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => page));
    }, child: Text(title));
  }
}
