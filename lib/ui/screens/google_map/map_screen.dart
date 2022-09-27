import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:optical_character_recognizer/core/services/location.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = '/map_screen';

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Completer<GoogleMapController> _controller = Completer();

  final CameraPosition kGooglePlex = const CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  getCurrentLocation() async {
    Position pos = await Location().getCurrentLocation();

    final GoogleMapController mapController = await _controller.future;

    mapController.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          target: LatLng(pos.latitude, pos.longitude),
          zoom: 14.4746,
        ),
      ),
    );
  }

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: GoogleMap(
          initialCameraPosition: kGooglePlex,
          myLocationButtonEnabled: true,
          myLocationEnabled: true,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: Set<Marker>.of(listOfMarkers),
        ),
      ),
    );
  }
}
