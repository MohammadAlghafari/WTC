///---debug
// const String url = "http://fd40-122-173-24-14.ngrok.io/api/";
// const String url = "http://cb52-122-173-30-17.ngrok.io/api/";

// const String socketBaseUrl = "http://fd40-122-173-24-14.ngrok.io/";

///---development
// const String url = "https://demo2.itfaq.cloud/wtc-web/api/";
// const String imageUrl =
//     "https://demo2.itfaq.cloud/wtc-web/public/uploads/profile_images/";
// const String otherImageUrl =
//     "https://demo2.itfaq.cloud/wtc-web/public/uploads/scan_car/";

///---production
const String url = "https://admin.whatsthiscar.fr/api/";
const String imageUrl =
    "https://admin.whatsthiscar.fr/public/uploads/profile_images/";
const String otherImageUrl =
    "https://admin.whatsthiscar.fr/public/uploads/scan_car/";

///--same for all build
const String carNetAIUrl =
    "http://api.carnet.ai/v2/mmg/detect?box_offset=0&box_min_width=180&box_min_height=180&box_min_ratio=1&box_max_ratio=3.15&box_select=all&features=mm,mmg,color,angle&region=CIS";

class APIRoutes {
  static const String userLogin = url + "login";
  static const String socialLogin = url + "social_login";
  static const String logOut = url + "logout";
  static const String deleteAccount = url + "delete_user";
  static const String register = url + "register";
  static const String forgotPassword = url + "forgot_password";
  static const String changePassword = url + "profile/update_password";
  static const String resetPassword = url + "reset-password";
  static const String updateProfile = url + "profile/update_profile";
  static const String profileRemove = url + "profile/removed_profile";
  static const String carSpecification = url + "car_specification";
  static const String userHistory = url + "scan_histroy";
  static const String otherUserHistory = url + "recent_histroy";
  static const String undetected = url + "undetected";
  static const String saveHistory = url + "save_history";
  static const String reviewStatus = url + "review_status";
  static const String notifications = url+'notifications';
}

enum ContentType { jsonType }
