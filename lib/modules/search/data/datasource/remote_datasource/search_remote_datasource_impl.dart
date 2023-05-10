import 'package:dio/dio.dart';
import 'package:wallpaper_app/modules/home/data/model/photo_model.dart';
import 'package:wallpaper_app/modules/search/data/datasource/remote_datasource/search_remote_datatsource.dart';

import '../../../../../core/network/client_utils.dart';
import '../../../../../core/resourses/constants_manager.dart';

class SearchRemoteDataSourceImpl extends SearchRemoteDataSource {
  final Dio client;

  SearchRemoteDataSourceImpl(this.client);

  @override
  Future<List<PhotoItemModel>> searchPhotoByKeyword(
      int page, int perPage, String keyword) async {
    final result = await client.get(
      "/search",
      options: ClientUtils.pexelAuth,
      queryParameters: {
        "page": page,
        "per_page": perPage,
        "query": keyword,
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
