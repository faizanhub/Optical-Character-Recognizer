import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Utils {
  static void showAlertDialog(BuildContext context, String title, desc) {
    showDialog(
        context: context,
        builder: (_) {
          return AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Text(desc),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Ok')),
            ],
          );
        });
  }

  static void showSnackBar(BuildContext context, String text) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(text),
      ),
    );
  }
}

List<Marker> listOfMarkers = <Marker>[
  const Marker(
    markerId: MarkerId('1'),
    position: LatLng(34.00071633839738, 71.47126574276727),
  ),
  const Marker(
    markerId: MarkerId('2'),
    position: LatLng(34.00157020927566, 71.49478335127888),
  ),
  const Marker(
    markerId: MarkerId('3'),
    position: LatLng(34.00527021739366, 71.50130648388038),
  ),
  const Marker(
    markerId: MarkerId('4'),
    position: LatLng(34.008300152241134, 71.50864720337856),
  ),
  const Marker(
    markerId: MarkerId('5'),
    position: LatLng(34.01000773292577, 71.51929020869039),
  ),
  const Marker(
    markerId: MarkerId('6'),
    position: LatLng(34.00132717474774, 71.53370976427415),
  ),
  const Marker(
    markerId: MarkerId('7'),
    position: LatLng(33.9983385805704, 71.53817296005006),
  ),
  const Marker(
    markerId: MarkerId('8'),
    position: LatLng(33.993215031655104, 71.56134724603238),
  ),
  const Marker(
    markerId: MarkerId('9'),
    position: LatLng(34.00075792682889, 71.5548241137445),
  ),
  const Marker(
    markerId: MarkerId('10'),
    position: LatLng(34.008157852231726, 71.55757069576907),
  ),
  const Marker(
    markerId: MarkerId('11'),
    position: LatLng(34.011857573270134, 71.5668404101532),
  ),
  const Marker(
    markerId: MarkerId('12'),
    position: LatLng(34.01740685253872, 71.57147526738062),
  ),
  const Marker(
    markerId: MarkerId('13'),
    position: LatLng(33.98766417131118, 71.44942402780703),
  ),
  const Marker(
    markerId: MarkerId('14'),
    position: LatLng(33.98837584029287, 71.44272923414313),
  ),
  const Marker(
    markerId: MarkerId('15'),
    position: LatLng(33.98780650558428, 71.4271080489274),
  ),
  const Marker(
    markerId: MarkerId('16'),
    position: LatLng(33.96759265253305, 71.4332878584633),
  ),
];
