import 'package:flutter/material.dart';
import 'package:one/custom_marker_screen.dart';
import 'package:one/google_places_api.dart';
import 'package:one/polygon_screen.dart';
import 'package:one/polyline.dart';

import 'convert_latlang_to_address.dart';
import 'home_screen.dart';
import 'network_image_marker.dart';

void main() {
  runApp( MyApp());
}

// TODO        Google Map

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: NetworkImageMarker()
    );
  }
}



