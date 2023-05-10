import 'package:dio/dio.dart';
import 'package:wallpaper_app/modules/home/data/model/collection_model.dart';
import 'package:wallpaper_app/modules/home/data/model/photo_model.dart';

import '../../../../../core/network/client_utils.dart';
import '../../../../../core/resourses/constants_manager.dart';
import 'home_remote_datasource.dart';

class HomeRemoteDataSourceImpl extends HomeRemoteDataSource {
  final Dio client;

  HomeRemoteDataSourceImpl(this.client);

  @override
  Future<List<CollectionItemModel>> getCollections(int perPage) async {
    final result = await client.get("/collections/featured",
        options: ClientUtils.pexelAuth,
        queryParameters: {
          "per_page": perPage,
        });

    if (result.statusCode == AppConstants.successStatusCode) {
      final resultFromJson = CollectionModel.fromJson(result.data);
      return resultFromJson.collections;
    } else {
      throw Exception();
    }
  }

  @override
  Future<List<PhotoItemModel>> getPhotos(int page, int perPage) async {
    final result = await client.get(
      "/curated",
      options: ClientUtils.pexelAuth,
      queryParameters: {
        "page": page,
        "per_page": perPage,
      },
    );

    if (result.statusCode == AppConstants.successStatusCode) {
      final resultFromJson = PhotoModel.fromJson(result.data);
      return resultFromJson.photos;
    } else {
      throw Exception();
    }
  }
}
