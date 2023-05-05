import '../../model/collection_model.dart';
import '../../model/photo_model.dart';

abstract class HomeRemoteDataSource {
  Future<List<CollectionItemModel>> getCollections(int perPage);
  Future<List<PhotoItemModel>> getPhotos(int page, int perPage);
}
