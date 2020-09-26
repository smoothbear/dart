import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Webview app',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomeApp(),
    );
  }
}

class MyHomeApp extends StatefulWidget {
  MyHomeApp({Key key}) : super(key: key);

  @override
  _MyHomeAppState createState() => _MyHomeAppState();
}

class _MyHomeAppState extends State<MyHomeApp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: WebView(
          initialUrl: 'https://dsm-dms.com',
          javascriptMode: JavascriptMode.unrestricted,
        )
      ),
    );
  }
}