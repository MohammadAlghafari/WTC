import 'package:wtc/ui/screens/photo_preview/model/car_feature_model.dart';

class CustomCarDetailModel {
  final String makeName;
  final String? year;
  final String modelName;
  final String? generationName;
  final String? color;
  final int? id;
  final List<OtherCar> otherCarList;
  final dynamic probability;
  final dynamic image;
  final Map<String, Map<String, dynamic>> catTabData;
  bool isFileImage;

  CustomCarDetailModel(
      {this.probability, this.year,
      this.image,
      this.id,
      this.generationName,
      required this.otherCarList,
      this.color,
      this.isFileImage = true,
      required this.makeName,
      required this.modelName,
      required this.catTabData});
}
