class CarFeatureModel {
  CarFeatureModel({
    required this.success,
  });

  Success success;

  factory CarFeatureModel.fromJson(Map<String, dynamic> json) =>
      CarFeatureModel(
        success: Success.fromJson(json["success"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success.toJson(),
      };
}

class Success {
  Success(
      {required this.message,
      required this.userId,
      required this.userEmail,
      required this.carMakeModelGeneration,
      required this.carBasicSpecification,
      required this.carSpecificationFeature,
      required this.otherCars});

  String message;
  int userId;
  String userEmail;
  CarMakeModelGeneration carMakeModelGeneration;
  CarBasicSpecification carBasicSpecification;
  List<CarSpecificationFeature> carSpecificationFeature;
  List<OtherCar> otherCars;

  factory Success.fromJson(Map<String, dynamic> json) => Success(
        message: json["message"] ?? "",
        userId: json["user_id"] ?? 0,
        userEmail: json["user_email"] ?? "",
        carMakeModelGeneration:
            CarMakeModelGeneration.fromJson(json["car_make_model_generation"]),
        carBasicSpecification:
            CarBasicSpecification.fromJson(json["car_basic_specification"]),
        carSpecificationFeature: List<CarSpecificationFeature>.from(
            (json["car_specification_feature"] ?? [])
                .map((x) => CarSpecificationFeature.fromJson(x))),
        otherCars: List<OtherCar>.from(
            (json["other_cars"] ?? []).map((x) => OtherCar.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "user_id": userId,
        "user_email": userEmail,
        "car_make_model_generation": carMakeModelGeneration.toJson(),
        "car_basic_specification": carBasicSpecification.toJson(),
        "car_specification_feature":
            List<dynamic>.from(carSpecificationFeature.map((x) => x.toJson())),
        "other_cars": List<dynamic>.from(otherCars.map((x) => x.toJson())),
      };
}

class OtherCar {
  OtherCar({
    required this.makeName,
    required this.modelName,
    this.year,
  });

  String makeName;
  String modelName;
  String? year;

  factory OtherCar.fromJson(Map<String, dynamic> json) => OtherCar(
        makeName: json["make_name"] ?? "",
        modelName: json["model_name"] ?? "",
        year: json["year"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "make_name": makeName,
        "model_name": modelName,
      };
}

class CarBasicSpecification {
  CarBasicSpecification({
    required this.idCarGeneration,
    required this.generationName,
    required this.idCarSerie,
    required this.serieName,
    required this.idCarTrim,
    required this.trimName,
    required this.idCarEquipment,
    required this.carEquipmentName,
    required this.idCarOptionValue,
    required this.idCarOption,
    required this.isBase,
    required this.carOptionName,
  });

  int idCarGeneration;
  String generationName;
  int idCarSerie;
  String serieName;
  int idCarTrim;
  String trimName;
  int idCarEquipment;
  String carEquipmentName;
  int idCarOptionValue;
  int idCarOption;
  int isBase;
  String carOptionName;

  factory CarBasicSpecification.fromJson(Map<String, dynamic> json) =>
      CarBasicSpecification(
        idCarGeneration: json["id_car_generation"] ?? 0,
        generationName: json["generation_name"] ?? "",
        idCarSerie: json["id_car_serie"] ?? 0,
        serieName: json["serie_name"] ?? "",
        idCarTrim: json["id_car_trim"] ?? 0,
        trimName: json["trim_name"] ?? "",
        idCarEquipment: json["id_car_equipment"] ?? 0,
        carEquipmentName: json["car_equipment_name"] ?? "",
        idCarOptionValue: json["id_car_option_value"] ?? 0,
        idCarOption: json["id_car_option"] ?? 0,
        isBase: json["is_base"] ?? 0,
        carOptionName: json["car_option_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id_car_generation": idCarGeneration,
        "generation_name": generationName,
        "id_car_serie": idCarSerie,
        "serie_name": serieName,
        "id_car_trim": idCarTrim,
        "trim_name": trimName,
        "id_car_equipment": idCarEquipment,
        "car_equipment_name": carEquipmentName,
        "id_car_option_value": idCarOptionValue,
        "id_car_option": idCarOption,
        "is_base": isBase,
        "car_option_name": carOptionName,
      };
}

class CarMakeModelGeneration {
  CarMakeModelGeneration({
    required this.idCarMake,
    required this.makeName,
    required this.idCarModel,
    required this.modelName,
    required this.idCarGeneration,
    required this.generationName,
  });

  int idCarMake;
  String makeName;
  int idCarModel;
  String modelName;
  int idCarGeneration;
  String generationName;

  factory CarMakeModelGeneration.fromJson(Map<String, dynamic> json) =>
      CarMakeModelGeneration(
        idCarMake: json["id_car_make"] ?? 0,
        makeName: json["make_name"] ?? "",
        idCarModel: json["id_car_model"] ?? 0,
        modelName: json["model_name"] ?? "",
        idCarGeneration: json["id_car_generation"] ?? 0,
        generationName: json["generation_name"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id_car_make": idCarMake,
        "make_name": makeName,
        "id_car_model": idCarModel,
        "model_name": modelName,
        "id_car_generation": idCarGeneration,
        "generation_name": generationName,
      };
}

class CarSpecificationFeature {
  CarSpecificationFeature({
    required this.carSpecificationName,
    required this.value,
    required this.unit,
  });

  String carSpecificationName;
  String value;
  String unit;

  factory CarSpecificationFeature.fromJson(Map<String, dynamic> json) =>
      CarSpecificationFeature(
        carSpecificationName: json["car_specification_name"] ?? "",
        value: json["value"] ?? "",
        unit: json["unit"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "car_specification_name": carSpecificationName,
        "value": value,
        "unit": unit,
      };
}
