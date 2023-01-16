
import 'package:wtc/ui/global.dart';

import '../api_handler.dart';
import '../api_routes.dart';

class ReviewRepo {
  static Future reviewOfScan({
    required bool reviewPositive,
    required int id,
  }) async {
    var responseBody = await API.apiHandler(
        url: APIRoutes.reviewStatus,
        showToast: false,
        showLoader: false,
        header: {
          "Authorization": "Bearer " + userController.token
        },
        body: {
          "review_status": reviewPositive ? "Yes" : "No",
          "id": id.toString()
        });
    if (responseBody != null) {
      return responseBody;
    } else {
      return null;
    }
  }
}
