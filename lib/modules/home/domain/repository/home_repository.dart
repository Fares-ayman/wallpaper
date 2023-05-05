import 'package:wallpaper_app/modules/home/domain/entity/collection_entity.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';

abstract class HomeRepository {
  Future<List<CollectionItemEntity>> getCollections(int perPage);
  Future<List<PhotoItemEntity>> getPhotos(int page, int perPage);
}
