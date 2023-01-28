import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class MyMapPage extends StatefulWidget {
  @override
  _MyMapPageState createState() => _MyMapPageState();
}

class _MyMapPageState extends State<MyMapPage> {
  late LocationData _currentLocation;
  Location _locationService = new Location();
  late String error;

  @override
  void initState() {
    super.initState();
    _locationService.onLocationChanged.listen((LocationData result) {
      setState(() {
        _currentLocation = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(37.42796133580664, -122.085749655962),
          zoom: 14.0,
        ),
        polylines: _createPolylines(),
      ),
    );
  }

  Set<Polyline> _createPolylines() {
    return <Polyline>[
      Polyline(
        polylineId: PolylineId("Road 1"),
        color: Colors.green,
        points: _road1Coordinates,
      ),
      Polyline(
        polylineId: PolylineId("Road 2"),
        color: Colors.red,
        points: _road2Coordinates,
      ),
    ].toSet();
  }

  List<LatLng> _road1Coordinates = [
    LatLng(37.4219999, -122.0840575),
    LatLng(37.4629101, -122.0853674),
    LatLng(37.4779496, -122.0844088),
  ];

  List<LatLng> _road2Coordinates = [
    LatLng(37.4219999, -122.0840575),
    LatLng(37.4629101, -122.0853674),
    LatLng(37.4779496, -122.0844088),
  ];
}
