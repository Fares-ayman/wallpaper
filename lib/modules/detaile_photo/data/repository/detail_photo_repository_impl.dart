import 'package:wallpaper_app/modules/detaile_photo/data/datasource/local_datasource/local_datasource.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/repository/detail_photo_repository.dart';

class DetailPhotoRepositoryImpl extends DetailPhotoRepository {
  final LocalDatasource localDatasource;

  DetailPhotoRepositoryImpl(this.localDatasource);

  @override
  Future<void> downloadPhoto(String photoUrl) async {
    try {
      await localDatasource.downloadPhoto(photoUrl);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> insertToFavourite(String sql) async {
    try {
      await localDatasource.insertToFavourite(sql);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> deleteToFavourite(String sql) async {
    try {
      await localDatasource.deleteToFavourite(sql);
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PhotoItemEntity>> readFavourites(String sql) async {
    try {
      List<Map> responseAsMap = await localDatasource.readFavourites(sql);
      List<PhotoItemEntity> responseAsEntity = responseAsMap
          .map((item) => PhotoItemEntity(
              item['photo_id'],
              item['url'],
              item['photographer'],
              item['avgColor'],
              PhotoSrcEntity(
                item['original'],
                item['large'],
                item['portrait'],
              ),
              item['alt']))
          .toList();
      return responseAsEntity;
    } catch (e) {
      throw Exception();
    }
  }
}
