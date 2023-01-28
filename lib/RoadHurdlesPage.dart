import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class RoadHurdlesApp extends StatefulWidget {
  @override
  _RoadHurdlesAppState createState() => _RoadHurdlesAppState();
}

class _RoadHurdlesAppState extends State<RoadHurdlesApp> {
  late GoogleMapController mapController;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  late String mapStyle;
  late String TrafficEnabled;
  bool _showHurdles = false;
  bool _showTraffic = false;

  @override
  void initState() {
    super.initState();
    rootBundle.loadString("assets/map_style.json").then((string) {
      mapStyle = string;
    });
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onHurdlesButtonPressed() {
    setState(() {
      _showHurdles = !_showHurdles;
    });
    if (_showHurdles) {
      mapController.setMapStyle(mapStyle);
    } else {
      mapController.setMapStyle(null);
    }
  }

  void _onTrafficButtonPressed() {
    setState(() {
      _showTraffic = !_showTraffic;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Road Hurdles App'),
      ),
      body: Stack(
        children: <Widget>[
          GoogleMap(
            onMapCreated: _onMapCreated,
            initialCameraPosition: CameraPosition(
              target: _center,
              zoom: 11.0,
            ),
            mapType: MapType.normal,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomLeft,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: _onHurdlesButtonPressed,
                    child: Icon(
                        _showHurdles ? Icons.remove_circle : Icons.add_circle),
                  ),
                  SizedBox(height: 16.0),
                  FloatingActionButton(
                    onPressed: _onTrafficButtonPressed,
                    child: Icon(
                        _showTraffic ? Icons.traffic : Icons.not_interested),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
