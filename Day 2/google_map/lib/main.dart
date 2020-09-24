import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
    );
  }
}

class MapsState extends StatefulWidget {
  @override
  _My
}

class _MyMapsPage extends State<MapsState> {
  Completer<GoogleMapController> _controller = Completer();

  static final daeMaGo = CameraPosition(target: LatLng(36.3917, 127.3631), zoom: 3.0);
}