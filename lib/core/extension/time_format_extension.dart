import 'package:get/get.dart';
import 'package:intl/intl.dart';

class DateTimeFormatExtension {
  static String displayTimeFromTimestampForPost(DateTime timestamp) {
    var v = DateTime.now().difference(timestamp);
    if (v.inHours < 24) {
      if (v.inMinutes < 60) {
        if (v.inMinutes == 0) {
          return "just_now".tr;
        }
        return "${"agof".tr}${v.inMinutes}${"m".tr}";
      } else {
        return "${"agof".tr}${v.inHours < 1 ? 1 : v.inHours}${"h".tr}";
      }
    } else {
      var time = DateFormat('HH');
      var time2 = DateFormat('mm');
      if (v.inDays == 1) {
        return "${"yesterday".tr} ${time.format(timestamp)}${"honly".tr}${time2.format(timestamp)}";
      } else {
        var outputFormat = DateFormat('dd/MM/yyyy');

        var outputDate = outputFormat.format(timestamp);
        return "$outputDate ${"onlya".tr} ${time.format(timestamp)}${"honly".tr}${time2.format(timestamp)}";
      }
    }
  }
}
