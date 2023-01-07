import 'dart:async';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomMarkerScreen extends StatefulWidget {
  const CustomMarkerScreen({Key? key}) : super(key: key);

  @override
  State<CustomMarkerScreen> createState() => _CustomMarkerScreenState();
}

class _CustomMarkerScreenState extends State<CustomMarkerScreen> {
  // TODO  Google map controller
  final Completer _controller= Completer();

  Uint8List? markerImage;

  List<String> images = ['assets/icon/car.png', 'assets/icon/car1.png','assets/icon/car2.png',
                        'assets/icon/bike1.png','assets/icon/bike2.png','assets/icon/bike3.png'];

  final List<Marker> _marker = [ Marker(markerId: MarkerId('1'), position: LatLng(33.6941, 72.9734),)];
  final List<LatLng> _latlang = [
    LatLng(33.6941, 72.9734), LatLng(33.7008, 72.9682), LatLng(33.6992, 72.9744),
    LatLng(33.6939, 72.9771), LatLng(33.6910, 72.9807), LatLng(33.7036, 72.9785)
  ];

  @override
  initState(){
    super.initState();
    loadData();
  }

  loadData()async{
    for(int i=0; i<images.length; i++){
      final Uint8List markicon= await getBytesFromAssets(images[i], 50);
      _marker.add(Marker(markerId: MarkerId(i.toString()),
       position: _latlang[i],
        icon: BitmapDescriptor.fromBytes(markicon),
        infoWindow: InfoWindow(title: "This is title number" +i.toString())
      ),
      );
      setState((){});
    }
  }

  static CameraPosition _KgooglePostion = CameraPosition(
      target: LatLng(33.6910, 72.98072), zoom: 15);

  Future<Uint8List> getBytesFromAssets (String path, int width)async{
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(), targetHeight: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))!.buffer.asUint8List();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _KgooglePostion,
          markers: Set<Marker>.of(_marker),
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },
        ),
      ),
    );
  }
}
