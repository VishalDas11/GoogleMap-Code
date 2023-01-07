
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';


class ConvertLatLangToAddress extends StatefulWidget {
  const ConvertLatLangToAddress({Key? key}) : super(key: key);

  @override
  State<ConvertLatLangToAddress> createState() =>
      _ConvertLatLangToAddressState();
}

class _ConvertLatLangToAddressState extends State<ConvertLatLangToAddress> {
   String stAddress = "";
   String adderess = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Google Map"),
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(stAddress.toString()),
          Text(adderess.toString()),
          Padding(
            padding: EdgeInsets.all(20),
            child: GestureDetector(
              onTap: () async {
                List<Location> location = await locationFromAddress("Mirpurkhas");
                List<Placemark> placemark = await placemarkFromCoordinates(25.7681734,  68.6558788);
                setState((){
                  stAddress = location.last.latitude.toString() +"  "+ location.last.longitude.toString();
                  adderess = placemark.reversed.last.country.toString()+" "+ placemark.reversed.last.locality.toString();
                });
              },
              child: Container(
                height: 50,
                decoration: BoxDecoration(color: Colors.green),
                child: Center(
                  child: Text("Convert"),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
