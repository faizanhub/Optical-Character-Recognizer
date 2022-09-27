import 'package:flutter/material.dart';
import 'package:optical_character_recognizer/core/models/brewery.dart';
import 'package:optical_character_recognizer/core/services/breweries_service.dart';
import 'package:optical_character_recognizer/core/utils/utils.dart';
import 'package:optical_character_recognizer/ui/screens/breweries/breweries_details_screen.dart';

class BreweriesListScreen extends StatefulWidget {
  static const String routeName = '/breweries_list_screen';

  const BreweriesListScreen({Key? key}) : super(key: key);

  @override
  State<BreweriesListScreen> createState() => _BreweriesListScreenState();
}

class _BreweriesListScreenState extends State<BreweriesListScreen> {
  bool isLoading = false;
  List<Brewery> listOfBreweries = [];

  toggleIsLoading(bool newValue) {
    setState(() {
      isLoading = newValue;
    });
  }

  fetchBreweriesList() async {
    toggleIsLoading(true);
    BreweriesService().getData().then((value) {
      toggleIsLoading(false);
      listOfBreweries = value;
      setState(() {});
    }).onError((error, stackTrace) {
      toggleIsLoading(false);
      Utils.showSnackBar(context, error.toString());
      print(error);
    });
  }

  @override
  void initState() {
    fetchBreweriesList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text('Breweries List'),
        ),
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(12.0),
                child: ListView.builder(
                    itemCount: listOfBreweries.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, BreweryDetailsScreen.routeName,
                              arguments: listOfBreweries[index]);
                        },
                        child: Card(
                          color: Colors.white70,
                          child: ListTile(
                            title: Text(listOfBreweries[index].name ?? ''),
                            subtitle:
                                Text(listOfBreweries[index].country ?? ''),
                            trailing: Text(listOfBreweries[index].city ?? ''),
                          ),
                        ),
                      );
                    }),
              ),
      ),
    );
  }
}
