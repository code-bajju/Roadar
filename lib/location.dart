// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class LocationPage extends StatefulWidget {
//   @override
//   _LocationPageState createState() => _LocationPageState();
// }

// class _LocationPageState extends State<LocationPage> {
//   LocationData _currentLocation;
//   Location _locationService = new Location();
//   String error;

//   @override
//   void initState() {
//     super.initState();
//     _locationService.onLocationChanged().listen((LocationData result) {
//       setState(() {
//         _currentLocation = result;
//       });
//     });
//     _locationService.getLocation().then((result) {
//       setState(() {
//         _currentLocation = result;
//       });
//     }).catchError((error) {
//       setState(() {
//         this.error = error.toString();
//       });
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("My Location"),
//       ),
//       body: _currentLocation == null
//           ? Center(child: Text(error))
//           : GoogleMap(
//               initialCameraPosition: CameraPosition(
//                 target: LatLng(
//                     _currentLocation.latitude, _currentLocation.longitude),
//                 zoom: 14.0,
//               ),
//               markers: _createMarkers(),
//             ),
//     );
//   }

//   Set<Marker> _createMarkers() {
//     return <Marker>[
//       Marker(
//         markerId: MarkerId("My Location"),
//         position: LatLng(_currentLocation.latitude, _currentLocation.longitude),
//         infoWindow: InfoWindow(title: "My Location"),
//       ),
//     ].toSet();
//   }
// }
