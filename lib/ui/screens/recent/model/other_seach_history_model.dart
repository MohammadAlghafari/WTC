import 'package:wtc/ui/screens/recent/model/search_history_model.dart';

class OtherSearchHistoryModel {
  OtherSearchHistoryModel({
    required this.otherSearchData,
  });

  OtherSearchData otherSearchData;

  factory OtherSearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      OtherSearchHistoryModel(
        otherSearchData: OtherSearchData.fromJson(json["success"]),
      );
}

class OtherSearchData {
  OtherSearchData({
    required this.message,
    required this.otherScanHistory,
  });

  String message;
  List<MyScanHistory> otherScanHistory;

  factory OtherSearchData.fromJson(Map<String, dynamic> json) =>
      OtherSearchData(
        message: json["message"] ?? "",
        otherScanHistory: List<MyScanHistory>.from(
            (json["recent_search_history"] ?? [])
                .map((x) => MyScanHistory.fromJson(x))),
      );
}
