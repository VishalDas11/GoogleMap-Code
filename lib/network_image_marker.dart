import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:ui';
import 'dart:ui'as ui;

class NetworkImageMarker extends StatefulWidget {
  const NetworkImageMarker({Key? key}) : super(key: key);

  @override
  State<NetworkImageMarker> createState() => _NetworkImageMarkerState();
}

class _NetworkImageMarkerState extends State<NetworkImageMarker> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition _kGoogleMap = CameraPosition(
      target: LatLng(25.760124, 68.697216),
      zoom: 14
  );

  final List<Marker> _marker = [];

  final List<LatLng> _latlang = <LatLng> [
    LatLng(25.760124, 68.697216),
    LatLng(26.226716, 68.445646),
    LatLng(25.505067, 67.905127)
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() async {
    for(int i=0; i< _latlang.length; i++){

      Uint8List? image = await loadNetworkImage('https://images.pexels.com/photos/7776854/pexels-photo-7776854.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1');
      // TODO  set image size
      final ui.Codec markerImageCodec = await ui.instantiateImageCodec(
        image!.buffer.asUint8List(),
        targetHeight: 100,
        targetWidth: 100
      );
      final ui.FrameInfo frameInfo = await markerImageCodec.getNextFrame();
      final ByteData? byteData = await frameInfo.image.toByteData(
        format: ImageByteFormat.png
      );
      final Uint8List  resizeImageMarker = byteData!.buffer.asUint8List();

      _marker.add(
        Marker(
            markerId: MarkerId("1"),
            position: _latlang[i],
            icon: BitmapDescriptor.fromBytes(resizeImageMarker),
            infoWindow: InfoWindow(
              snippet: "title"+i.toString(),
              
            )
        )
      );
      setState(() {

      });
    }
  }
   Future<Uint8List?>  loadNetworkImage(String path) async {
    final completer = Completer<ImageInfo>();
    var image  = NetworkImage(path);
    image.resolve(ImageConfiguration()).addListener(
      ImageStreamListener((info, _)=> completer.complete(info))
    );
    final imageInfo = await completer.future;
    final byteData = await imageInfo.image.toByteData(format: ui.ImageByteFormat.png);

    return byteData!.buffer.asUint8List();
   }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Network Image Marker"),),
      body: GoogleMap(
        initialCameraPosition: _kGoogleMap,
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        markers: Set<Marker>.of(_marker),
        onMapCreated: (GoogleMapController controller){
          _controller.complete(controller);
        },

      ),
    );
  }
}
