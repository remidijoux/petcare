import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:async';  // Ajoutez ceci en haut du fichier
import 'dart:convert';
import 'package:http/http.dart' as http;


class FindVet extends StatefulWidget {
  const FindVet({Key? key}) : super(key: key);

  @override
  _FindVetState createState() => _FindVetState();
}

class _FindVetState extends State<FindVet> {
  BitmapDescriptor markerIcon = BitmapDescriptor.defaultMarker;
  late GoogleMapController _mapController;
  Position? _currentPosition;
  Set<Marker> _markers = {};
  GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyAiAicJJVzhh7pwoy2O14gWhKWbErAws9k');
  List<PlacesSearchResult> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  void _getCurrentLocation() async {
    final position = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = position;
    });
    if (_mapController == null) {
      return;
    }
    _mapController!.animateCamera(
      CameraUpdate.newLatLngZoom(
        LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
        12,
      ),
    );
    _searchVetsNearby();
  }




  void _searchVetsNearby() async {
    final url =
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=${_currentPosition!.latitude},${_currentPosition!.longitude}&radius=5000&type=veterinary_care&keyword=Veterinaire&key=AIzaSyAiAicJJVzhh7pwoy2O14gWhKWbErAws9k';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      final results = data['results'] as List;

      setState(() {
        _searchResults = results
            .map((result) => PlacesSearchResult.fromJson(result))
            .toList();
      });

      _addMarkersToMap();
    } else {
      // Handle error
      print('Failed to fetch data');
    }
  }

  void _addMarkersToMap() {
    for (var result in _searchResults) {
      final marker = Marker(
        markerId: MarkerId(result.placeId!),
        position: LatLng(
          result.geometry!.location.lat,
          result.geometry!.location.lng,
        ),
        infoWindow: InfoWindow(
          title: result.name!,
        ),
      );
      _markers.add(marker);
    }

    setState(() {
      _markers = {..._markers};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Trouver un vétérinaire'),
      ),
      body: GoogleMap(
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
          _getCurrentLocation();
        },

        initialCameraPosition: CameraPosition(
          target: LatLng(37.7749, -122.4194),
          zoom: 12,
        ),
        markers: _markers,
      ),
    );
  }
}