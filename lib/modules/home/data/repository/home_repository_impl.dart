import 'package:wallpaper_app/core/mapper/mapper.dart';
import 'package:wallpaper_app/modules/home/domain/entity/collection_entity.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/modules/home/domain/repository/home_repository.dart';

import '../datasource/remote_datasource/home_remote_datasource.dart';
import '../model/collection_model.dart';
import '../model/photo_model.dart';

class HomeRepositoryImpl extends HomeRepository {
  final HomeRemoteDataSource homeRemoteDataSource;

  HomeRepositoryImpl(this.homeRemoteDataSource);
  @override
  Future<List<CollectionItemEntity>> getCollections(int perPage) async {
    try {
      final List<CollectionItemModel> collectionsModel =
          await homeRemoteDataSource.getCollections(perPage);
      List<CollectionItemEntity> collectionsEntity =
          collectionsModel.map((model) => model.toDomain()).toList();
      return collectionsEntity;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<List<PhotoItemEntity>> getPhotos(int page, int perPage) async {
    try {
      final List<PhotoItemModel> photosModel =
          await homeRemoteDataSource.getPhotos(page, perPage);
      List<PhotoItemEntity> photosEntity =
          photosModel.map((model) => model.toDomain()).toList();
      return photosEntity;
    } catch (e) {
      rethrow;
    }
  }
}
