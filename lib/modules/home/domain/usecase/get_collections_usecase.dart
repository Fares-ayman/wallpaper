import 'package:wallpaper_app/modules/home/domain/repository/home_repository.dart';

import '../entity/collection_entity.dart';

class GetCollectionsUseCase {
  final HomeRepository _homeRepository;

  GetCollectionsUseCase(this._homeRepository);

  Future<List<CollectionItemEntity>> call(int perPage) async {
    return await _homeRepository.getCollections(perPage);
  }
}
