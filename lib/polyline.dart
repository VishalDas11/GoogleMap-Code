import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class PolyLine extends StatefulWidget {
  const PolyLine({Key? key}) : super(key: key);

  @override
  State<PolyLine> createState() => _PolyLineState();
}

class _PolyLineState extends State<PolyLine> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGooglePlex  = CameraPosition(
      target: LatLng(25.760124, 68.697216),
      zoom: 14
  );

  final Set<Marker> _marker = {};
  final Set<Polyline> _polyline = {};

  List<LatLng> _latLng = [
    LatLng(25.760124, 68.697216),
    LatLng(26.226716, 68.445646),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    for(int i =0; i< _latLng.length; i++){
      _marker.add(
        Marker(
            markerId: MarkerId(i.toString()),
            position: _latLng[i],
            infoWindow: InfoWindow(
              title:"Really Root Place",
              snippet: '5 star Rating'
            ),
          icon: BitmapDescriptor.defaultMarker
        )
      );
      setState(() {
      });
      _polyline.add(
        Polyline(
            polylineId: PolylineId("1"),
            points: _latLng
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("PolyLine"),),
      body: GoogleMap(
        initialCameraPosition: _kGooglePlex,
        myLocationEnabled: true,
        markers: _marker,
        polylines: _polyline,
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },

      ),
    );
  }
}
