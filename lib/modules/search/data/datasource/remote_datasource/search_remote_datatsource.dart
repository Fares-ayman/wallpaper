import '../../../../home/data/model/photo_model.dart';

abstract class SearchRemoteDataSource {
  Future<List<PhotoItemModel>> searchPhotoByKeyword(
    int page,
    int perPage,
    String keyword,
  );
}
