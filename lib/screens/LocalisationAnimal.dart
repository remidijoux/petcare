import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';

void main() => runApp(LocalisationAnimal());

class LocalisationAnimal extends StatefulWidget {
  @override
  _LocalisationAnimalState createState() => _LocalisationAnimalState();
}

class _LocalisationAnimalState extends State<LocalisationAnimal> {
  late GoogleMapController mapController;
  late Position currentPosition;
  Set<Marker> animalLocations = Set<Marker>();

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
    _addAnimalLocations();
  }

  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
    });
  }

  void _addAnimalLocations() {
    final List<LatLng> animalCoordinates = [
      LatLng(45.75, 4.85),
      LatLng(45.76, 4.85),
      LatLng(45.77, 4.85),
    ];

    final List<String> animalNames = [
      "Chien 1",
      "Chat 1",
      "Chien 2",
    ];

    for (int i = 0; i < animalCoordinates.length; i++) {
      animalLocations.add(
        Marker(
          markerId: MarkerId('Animal $i'),
          position: animalCoordinates[i],
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: animalNames[i]),
        ),
      );
    }
  }

  @override
  void dispose() {
    mapController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Localisation de mon animal'),
        ),
        body: Stack(
          children: [
            GoogleMap(
              onMapCreated: (GoogleMapController controller) {
                mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: LatLng(
                  currentPosition?.latitude ?? 0.0,
                  currentPosition?.longitude ?? 0.0,
                ),
                zoom: 14.0,
              ),
              markers: animalLocations,
            ),
            Positioned(
              top: 16.0,
              right: 16.0,
              child: FloatingActionButton(
                onPressed: _getCurrentLocation,
                child: Icon(Icons.my_location),
              ),
            ),
          ],
        ),
      ),
    );
  }
}