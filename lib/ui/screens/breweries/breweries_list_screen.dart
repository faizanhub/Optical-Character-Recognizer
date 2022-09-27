import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:optical_character_recognizer/core/controllers/breweries_controller.dart';
import 'package:optical_character_recognizer/core/models/brewery.dart';
import 'package:optical_character_recognizer/core/services/breweries_service.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';
import 'package:optical_character_recognizer/ui/screens/breweries/breweries_details_screen.dart';

class BreweriesListScreen extends StatelessWidget {
  static const String routeName = '/breweries_list_screen';

  @override
  Widget build(BuildContext context) {
    final BreweriesController breweryC = Get.put(BreweriesController());

    return SafeArea(
      child: Obx(() {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Breweries List'),
          ),
          body: breweryC.isLoading.value
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ListView.builder(
                      itemCount: breweryC.listOfBreweries.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushNamed(
                                context, BreweryDetailsScreen.routeName,
                                arguments: breweryC.listOfBreweries[index]);
                          },
                          child: Card(
                            color: Colors.white70,
                            child: ListTile(
                              title: Text(
                                  breweryC.listOfBreweries[index].name ?? ''),
                              subtitle: Text(
                                  breweryC.listOfBreweries[index].country ??
                                      ''),
                              trailing: Text(
                                  breweryC.listOfBreweries[index].city ?? ''),
                            ),
                          ),
                        );
                      }),
                ),
        );
      }),
    );
  }
}
