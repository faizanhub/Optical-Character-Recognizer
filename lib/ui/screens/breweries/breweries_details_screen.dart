import 'package:flutter/material.dart';
import 'package:optical_character_recognizer/constants/text_styles.dart';
import 'package:optical_character_recognizer/core/models/brewery.dart';
import 'package:optical_character_recognizer/ui/widgets/breweries_detail_row.dart';

class BreweryDetailsScreen extends StatelessWidget {
  static const String routeName = '/brewery_details_screen';

  final Brewery brewery;

  const BreweryDetailsScreen({Key? key, required this.brewery})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Breweries Details'),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              elevation: 3,
              // color: const Color(0xfff2f2f8),
              color: Colors.white70,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Text(request.patientName, style: titleTextStyle),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 16.0, right: 10.0, top: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          BreweriesDetailsRow(
                              title: 'Name', subtitle: brewery.name ?? ''),
                          const SizedBox(height: 15),
                          BreweriesDetailsRow(
                              title: 'Type',
                              subtitle: brewery.breweryType ?? ''),
                          const SizedBox(height: 15),
                          BreweriesDetailsRow(
                              title: 'Street', subtitle: brewery.street ?? ''),
                          const SizedBox(height: 15),
                          BreweriesDetailsRow(
                              title: 'City', subtitle: brewery.city ?? ''),
                          const SizedBox(height: 15),
                          BreweriesDetailsRow(
                              title: 'Postal Code',
                              subtitle: brewery.postalCode ?? ''),
                          const SizedBox(height: 15),
                          BreweriesDetailsRow(
                              title: 'Country',
                              subtitle: brewery.country ?? ''),
                          const SizedBox(height: 15),
                          BreweriesDetailsRow(
                              title: 'Phone', subtitle: brewery.phone ?? ''),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
