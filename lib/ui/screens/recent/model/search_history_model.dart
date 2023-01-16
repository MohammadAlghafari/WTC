class SearchHistoryModel {
  SearchHistoryModel({
    required this.searchData,
  });

  SearchData searchData;

  factory SearchHistoryModel.fromJson(Map<String, dynamic> json) =>
      SearchHistoryModel(
        searchData: SearchData.fromJson(json["success"]),
      );
}

class SearchData {
  SearchData({
    required this.message,
    required this.myScanHistory,
  });

  String message;
  List<MyScanHistory> myScanHistory;

  factory SearchData.fromJson(Map<String, dynamic> json) => SearchData(
        message: json["message"] ?? "",
        myScanHistory: List<MyScanHistory>.from((json["my_scan_history"] ?? [])
            .map((x) => MyScanHistory.fromJson(x))),
      );
}

class MyScanHistory {
  MyScanHistory({
    required this.id,
    required this.useProfile,
    required this.carName,
    required this.carMake,
    required this.carModel,
    required this.userId,
    required this.color,
    required this.foundDate,
    required this.carImg,
    required this.year,
    required this.probability,
    this.generation,
    required this.createdAt,
    required this.updatedAt,
  });

  int id;
  String carName;
  String carMake;
  String carModel;
  String color;
  String useProfile;
  int userId;
  DateTime foundDate;
  String carImg;
  String probability;
  String? generation;
  String? year;
  DateTime createdAt;
  DateTime updatedAt;

  factory MyScanHistory.fromJson(Map<String, dynamic> json) => MyScanHistory(
        id: json["id"] ?? 0,
        carName: json["car_name"] ?? "",
        useProfile: json["user_profile_img"] ?? "",
        carMake: json["car_make"] ?? "",
        carModel: json["car_model"] ?? "",
        userId: json["user_id"] ?? 0,
        foundDate: DateTime.parse(
            json["found_date"] ?? DateTime.now().toIso8601String()),
        carImg: json["car_img"] ?? "",
        probability: json["probability"] ?? "",
        color: json["color"] ?? "",
        generation: json["generation"],
        createdAt: DateTime.parse(
            json["created_at"] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            json["updated_at"] ?? DateTime.now().toIso8601String()),
        year: json["year"],
      );
}
