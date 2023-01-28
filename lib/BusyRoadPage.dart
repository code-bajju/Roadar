import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class BusyRoadPage extends StatefulWidget {
  @override
  _BusyRoadPageState createState() => _BusyRoadPageState();
}

class _BusyRoadPageState extends State<BusyRoadPage> {
  late GoogleMapController mapController;
  int _selectedIndex = 0;
  final LatLng _center = const LatLng(45.521563, -122.677433);
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Busy Road',
      style: optionStyle,
    ),
    Text(
      'Index 1: Accidents',
      style: optionStyle,
    ),
  ];

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Busy Road'),
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car),
            label: ('Busy Road'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.warning),
            label: ("Accidents"),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
