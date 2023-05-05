import 'package:wallpaper_app/core/mapper/mapper.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/modules/search/domain/repository/search_repository.dart';

import '../../../home/data/model/photo_model.dart';
import '../datasource/remote_datasource/search_remote_datatsource.dart';

class SearchRepositoryImpl extends SearchRepository {
  final SearchRemoteDataSource searchRemoteDataSource;

  SearchRepositoryImpl(this.searchRemoteDataSource);
  @override
  Future<List<PhotoItemEntity>> searchPhotoByKeyword(
      int page, int perPage, String keyword) async {
    try {
      final List<PhotoItemModel> photosModel = await searchRemoteDataSource
          .searchPhotoByKeyword(page, perPage, keyword);
      List<PhotoItemEntity> photosEntity =
          photosModel.map((model) => model.toDomain()).toList();
      return photosEntity;
    } catch (e) {
      rethrow;
    }
  }
}
