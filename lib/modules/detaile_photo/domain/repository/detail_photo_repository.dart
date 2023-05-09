import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';

abstract class DetailPhotoRepository {
  Future<void> downloadPhoto(String photoUrl);
  Future<void> insertToFavourite(String sql);
  Future<void> deleteToFavourite(String sql);
  Future<List<PhotoItemEntity>> readFavourites(String sql);
}
