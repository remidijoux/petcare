import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class LocalisationAnimal extends StatefulWidget {
  final String petName;

  @override
  const LocalisationAnimal({Key? key, required this.petName}) : super(key: key);
  _LocalisationAnimalState createState() => _LocalisationAnimalState();
}

class _LocalisationAnimalState extends State<LocalisationAnimal> {
  late GoogleMapController mapController;
  late Position currentPosition;
  Set<Marker> animalLocations = Set<Marker>();



  void _getCurrentLocation() async {
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    setState(() {
      currentPosition = position;
    });
  }

  void _addAnimalLocations(String petName) {
    final List<LatLng> animalCoordinates = [
      LatLng(45.832384, 1.264467), // Halles Centrales
      LatLng(45.832482, 1.255361), // Pl. de la Motte
      LatLng(45.838335, 1.271404), // 1B Font Pinot
    ];


    for (int i = 0; i < animalCoordinates.length; i++) {
      animalLocations.add(
        Marker(
          markerId: MarkerId('Animal $i'),
          position: animalCoordinates[i],
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: widget.petName),
        ),
      );

      // Store the animal coordinates in Firestore
      final animalCollection = FirebaseFirestore.instance.collection('locatePets');
      animalCollection.add({
        'latitude': animalCoordinates[i].latitude,
        'longitude': animalCoordinates[i].longitude,
        'name': widget.petName,
      });
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
