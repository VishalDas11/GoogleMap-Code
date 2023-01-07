import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class GooglePlacesApi extends StatefulWidget {
  const GooglePlacesApi({Key? key}) : super(key: key);

  @override
  State<GooglePlacesApi> createState() => _GooglePlacesApiState();
}

class _GooglePlacesApiState extends State<GooglePlacesApi> {
  String _sessionToken  = "12345";
  List<dynamic> _Placelist = [];
  var uuid = Uuid();
  final TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller.addListener(() {
      onChange();
    });
  }

  onChange(){
    if(_sessionToken == null){
      setState((){
        _sessionToken = uuid.v4();
      });
    }
    getSuggestion(_controller.text);
  }

  void getSuggestion(String input)async{
    String _KPlaceApiKey = "AIzaSyBdtSLj-HKHlzMDiC0nTrEVoXsei-nGp4Y";
    String baseURL = 'https://maps.googleapis.com/maps/api/place/autocomplete/json';
    String request = '$baseURL?input=$input&key=$_KPlaceApiKey&sessiontoken=$_sessionToken';

    var response = await http.get(Uri.parse(request));
    var data = jsonDecode(response.body.toString());
    print(data);
    if(response.statusCode == 200){
      setState((){
        _Placelist = jsonDecode(response.body.toString()) ['predictions'];
      });
    }
    else{
      throw Exception("Error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: "Search Places"
              ),
            ),
            Expanded(child: ListView.builder(
                itemCount: _Placelist.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(_Placelist[index]['description'].toString()),
                  );
            }))
          ],
        ),

      ),
    );
  }
}
