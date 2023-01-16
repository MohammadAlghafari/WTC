import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class GalleryImagePicker extends GetxController {
  List<AssetEntity> assets = [];
  Future fetchAssets() async {
    // Set onlyAll to true, to fetch only the 'Recent' album
    // which contains all the photos/videos in the storage
    try {
      final albums = await PhotoManager.getAssetPathList(
        onlyAll: true,
        type: RequestType.image,
      );
      final recentAlbum = albums.first;
      // Now that we got the album, fetch all the assets it contains
      final recentAssets = await recentAlbum.getAssetListRange(
        start: 0, // start at index 0
        end: 1000000, // end at a very big index (to get all the assets)
      );

      // Update the state and notify UI
      assets = recentAssets;
      update();
    } on Exception catch (e) {
      return Future.error(e);
    }
  }
}
