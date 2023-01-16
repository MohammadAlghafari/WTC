import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  int _index = 0;

  int get index => _index;

  set index(int value) {
    _index = value;
    update();
  }
}
