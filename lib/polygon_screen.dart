import 'dart:async';
import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolygonScreen extends StatefulWidget {
  const PolygonScreen({Key? key}) : super(key: key);

  @override
  State<PolygonScreen> createState() => _PolygonScreenState();
}

class _PolygonScreenState extends State<PolygonScreen> {
  Completer<GoogleMapController> _controller = Completer();

  CameraPosition _kGooglePlex  = CameraPosition(
      target: LatLng(25.760124, 68.697216),
      zoom: 14
  );

  final Set<Marker> _marker = {};
  final Set<Polygon> _polygon = HashSet<Polygon>();

  List<LatLng> points= [
    LatLng(25.760124, 68.697216),
    LatLng(26.226716, 68.445646),
    LatLng(25.505067, 67.905127)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _polygon.add(
      Polygon(polygonId: PolygonId("1"),
          points: points,
        fillColor: Colors.red.withOpacity(0.3),
        geodesic: true,
        strokeWidth: 4,
        strokeColor: Colors.deepOrange
      )
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Polygon"), centerTitle: true,),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        mapType: MapType.normal,
        myLocationButtonEnabled: true,
        myLocationEnabled: false,
        polygons: _polygon,

        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },
      ),
    );
  }
}
