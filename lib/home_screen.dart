import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GetUserCurrentLocation extends StatefulWidget {
  const GetUserCurrentLocation({Key? key}) : super(key: key);

  @override
  State<GetUserCurrentLocation> createState() => _GetUserCurrentLocationState();
}

class _GetUserCurrentLocationState extends State<GetUserCurrentLocation> {
  //TODO instance of google map
  final Completer<GoogleMapController> _controller = Completer();

  // TODO CameraPosition is the poistion of camera when we move
  static const CameraPosition _kGooglePlex = CameraPosition(
      target: LatLng(25.7681734,  68.6558788),
      zoom: 14
  );

  List<Marker> _marker = [];
  List<Marker> _list = [
    Marker(
        markerId: MarkerId("1"),
        position:  LatLng(25.7681734,  68.6558788),
       infoWindow: InfoWindow(
         title: "My Position"
       ),

    ),
    // Marker(
    //     markerId: MarkerId("2"),
    //     position: LatLng(17.385044,  78.486671),
    // )
  ];

  // TODO Here position is the latitude and latiutde
  Future<Position> getUserCurrentLocation () async{
    await Geolocator.requestPermission().then((value){

    }).onError((error, stackTrace) {
      print("error"+ error.toString());
    });
    return await Geolocator.getCurrentPosition();
  }
  // TODO Get Current Location
  loadData(){
    getUserCurrentLocation().then((value) async {
      print("Current Location");
      print(value.longitude.toString() +" "+ value.latitude.toString());
      _marker.add(
        Marker(markerId: MarkerId("3"),
            position: LatLng(value.latitude , value.longitude),
            infoWindow: InfoWindow(
                title: "My Current Position"
            )
        ),
      );
      CameraPosition cameraposition = CameraPosition(
          target:LatLng(value.latitude , value.longitude),
          zoom: 14
      );
      final GoogleMapController controller = await _controller.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
      setState((){

      });
    });
  }
  @override
  void initState(){
    super.initState();
    loadData();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // TODO   Google map has also controller that observe the locate when we move
      body: SafeArea(
        child: GoogleMap(
          initialCameraPosition: _kGooglePlex,
          mapType: MapType.normal,
          myLocationEnabled: true,
          myLocationButtonEnabled: true,
          markers: Set<Marker>.of(_marker),
          onMapCreated: (GoogleMapController controller){
            _controller.complete(controller);
          },

        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()async{
          // // TODO animated from one loction to other
          loadData();
        },
        child: (Icon(Icons.location_on_outlined)),
      ),
    );
  }
}
