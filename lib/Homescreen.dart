import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

late GoogleMapController mapController;

const LatLng SOURCE_LOCATION = LatLng(30.248009, 77.046394);
const LatLng DEST_LOCATION = LatLng(30.248009, 77.046394);
double tst = 0.4;
double tstt = 0.4;
double tstb = 0.4;
double tstd = 0.4;
const double Zoom = 16;
const double Tilt = 40;
const double Bearing = 30;
double hue1 = 350;
double hue2 = 95;
double hue3 = 180;
double hue4 = 250;
bool animal = false;
bool trafficlight = false;
bool toxicwaste = false;
bool pothole = false;

class Map extends StatefulWidget {
  const Map({super.key});

  @override
  State<Map> createState() => MapState();
}

class MapState extends State<Map> {
  late LatLng currentLocation;
  String mapTheme = '';
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> _markers = Set<Marker>();
  var _currentItemSelected = MapType.normal;
  var address = '';
  var cordinate1 = 'cordinate';
  static double lat = 30.248009;
  static double long = 77.046394;

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(30.248009, 77.046394),
    zoom: 14.4746,
    tilt: 45.0,
    bearing: 30.0,
  );

  @override
  void initState() {
    super.initState();
    //this.setIntialLocation();

    DefaultAssetBundle.of(context)
        .loadString('assets/maptheme/normal_theme.json')
        .then((value) {
      mapTheme = value;
    });
  }

  Future<void> getAddress(latt, longg) async {
    List<Placemark> placemark = await placemarkFromCoordinates(latt, longg);
    print(
        '-----------------------------------------------------------------------------------------');
    //here you can see your all the relevent information based on latitude and logitude no.
    print(placemark);
    print(
        '-----------------------------------------------------------------------------------------');
    Placemark place = placemark[0];
    setState(() {
      address =
          '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    });
  }

  void _WildAnimalMarker() {
    if (animal == true) {
      setState(() {
        _markers.add(Marker(
            markerId: MarkerId('id-1'),
            infoWindow: InfoWindow(
                title: 'Wild Animal Reported',
                snippet: 'Warning:Be cautious when in sourounding Area'),
            icon: BitmapDescriptor.defaultMarkerWithHue(hue1),
            position: LatLng(lat, long)));
      });
    }
  }

  void _TrafficlMarker() {
    if (trafficlight == true) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('traffic'),
          infoWindow: InfoWindow(
              title: 'Traffic Light Broken',
              snippet:
                  'Warning:Be patient and aware of your sourding while approaching intersection'),
          icon: BitmapDescriptor.defaultMarkerWithHue(hue2),
          position: LatLng(lat, long),
        ));
      });
    }
  }

  void _Pothole() {
    if (pothole == true) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('pothole'),
          infoWindow: InfoWindow(
              title: 'Pothole',
              snippet:
                  'Warning:drive slow and avoid pothole while on the road'),
          icon: BitmapDescriptor.defaultMarkerWithHue(hue3),
          position: LatLng(lat, long),
        ));
      });
    }
  }

  void _Toxicwaste() {
    if (toxicwaste == true) {
      setState(() {
        _markers.add(Marker(
          markerId: MarkerId('toxic waste'),
          infoWindow: InfoWindow(
              title: 'Toxic Waste',
              snippet:
                  'Warning:Proceed with catuion and avoid approaching unknown substances in area'),
          icon: BitmapDescriptor.defaultMarkerWithHue(hue4),
          position: LatLng(lat, long),
        ));
      });
    }
  }

  void serSourceAndDestinationMarkerIcons() async {}
  void setInitialLocation() {
    currentLocation =
        LatLng(SOURCE_LOCATION.latitude, SOURCE_LOCATION.longitude);
  }

  void intailCameraPosition() {}
  @override
  Widget build(BuildContext context) {
    CameraPosition intailCameraPosition = CameraPosition(
            zoom: Zoom, tilt: Tilt, bearing: Bearing, target: SOURCE_LOCATION),
        map;

    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: GoogleMap(
              myLocationButtonEnabled: true,
              compassEnabled: false,
              tiltGesturesEnabled: false,
              markers: _markers,
              mapType: MapType.normal,
              initialCameraPosition: intailCameraPosition,
              onMapCreated: (GoogleMapController controller) {
                controller.setMapStyle(mapTheme);
                _controller.complete(controller);
              },
              onTap: (cordinate) {
                setState(() {
                  lat = cordinate.latitude;
                  long = cordinate.longitude;
                  getAddress(lat, long);
                  cordinate1 = cordinate.toString();
                  _WildAnimalMarker();
                  _TrafficlMarker();
                  _Pothole();
                  _Toxicwaste();
                });
              },
            ),
          ),
          Positioned(
            top: 700,
            left: 10,
            right: 210,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(tstb),
                          blurRadius: 20,
                          offset: Offset.zero)
                    ]),
                child: IconButton(
                    icon: Image.asset('images/paw.jpg'),
                    onPressed: () {
                      animal = true;
                      trafficlight = false;
                      pothole = false;
                      toxicwaste = false;
                      setState(() {
                        tstb = 0.9;
                        tstt = 0.2;
                        tst = 0.2;
                        tstd = 0.2;
                      });
                    })),
          ),
          Positioned(
            top: 700,
            left: 210,
            right: 10,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(tstd),
                          blurRadius: 20,
                          offset: Offset.zero)
                    ]),
                child: IconButton(
                    icon: Image.asset('images/electrical-hazard.jpg'),
                    onPressed: () {
                      animal = false;
                      trafficlight = true;
                      pothole = false;
                      toxicwaste = false;
                      setState(() {
                        tstd = 0.9;
                        tstt = 0.2;
                        tst = 0.2;
                        tstb = 0.2;
                      });
                    })),
          ),
          Positioned(
            top: 650,
            left: 10,
            right: 210,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(tstt),
                          blurRadius: 20,
                          offset: Offset.zero)
                    ]),
                child: IconButton(
                    icon: Image.asset('images/pothole.jpg'),
                    onPressed: () {
                      animal = false;
                      trafficlight = false;
                      pothole = true;
                      toxicwaste = false;
                      setState(() {
                        tstt = 0.9;
                        tst = 0.2;
                        tstb = 0.2;
                        tstd = 0.2;
                      });
                    })),
          ),
          Positioned(
            top: 650,
            left: 210,
            right: 10,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(90),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.red.withOpacity(tst),
                          blurRadius: 20,
                          offset: Offset.zero)
                    ]),
                child: IconButton(
                    icon: Image.asset('images/toxic-waste.jpg'),
                    onPressed: () {
                      animal = false;
                      trafficlight = false;
                      pothole = false;
                      toxicwaste = true;
                      setState(() {
                        tst = 0.9;
                        tstt = 0.2;
                        tstb = 0.2;
                        tstd = 0.2;
                      });
                    })),
          ),
        ],
      ),
    );
  }
}
