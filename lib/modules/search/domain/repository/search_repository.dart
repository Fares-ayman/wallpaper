import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';

abstract class SearchRepository {
  Future<List<PhotoItemEntity>> searchPhotoByKeyword(
    int page,
    int perPage,
    String keyword,
  );
}
