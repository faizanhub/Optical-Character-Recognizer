import 'package:get/get.dart';
import 'package:optical_character_recognizer/core/services/breweries_service.dart';

class BreweriesController extends GetxController {
  var isLoading = false.obs;
  var listOfBreweries = [].obs;

  @override
  void onInit() {
    fetchBreweriesList();
    super.onInit();
  }

  toggleIsLoading(bool newValue) {
    isLoading.value = newValue;
  }

  fetchBreweriesList() async {
    toggleIsLoading(true);
    BreweriesService().getData().then(
      (value) {
        toggleIsLoading(false);
        listOfBreweries.value = value;
      },
    ).onError(
      (error, stackTrace) {
        toggleIsLoading(false);
        Get.snackbar(
          'Message',
          "error.toString()",
        );
      },
    );
  }
}
