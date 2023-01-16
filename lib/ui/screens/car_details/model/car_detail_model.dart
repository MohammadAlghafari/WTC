class CarDetailModel {
  int? carId;
  String makeName;
  String modelName;
  double? probability;
  bool? isSuccess;
  String? year;
  String? color;
  String? generationName;

  CarDetailModel(
      {required this.makeName,
      required this.modelName,
      this.isSuccess,
      this.year,
      this.generationName,
      this.color,
      this.carId,
      this.probability});

  factory CarDetailModel.fromJson(Map<String, dynamic> json) => CarDetailModel(
      makeName: json["makeName"],
      modelName: json["modelName"],
      carId: json["carId"],
      probability: json["probability"],
      color: json["color"],
      generationName: json["generationName"],
      isSuccess: json["isSuccess"],
      year: json["year"]);

  Map<String, dynamic> toJson() => {
        "makeName": makeName,
        "modelName": modelName,
        "carId": carId,
        "probability": probability,
        "color": color,
        "generationName": generationName,
        "isSuccess": isSuccess,
        "year": year,
      };
}
