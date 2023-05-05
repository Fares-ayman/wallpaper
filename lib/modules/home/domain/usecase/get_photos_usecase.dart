import 'package:wallpaper_app/modules/home/domain/repository/home_repository.dart';

import '../entity/photo_entity.dart';

class GetPhotosUseCase {
  final HomeRepository _homeRepository;

  GetPhotosUseCase(this._homeRepository);

  Future<List<PhotoItemEntity>> call(int page, int perPage) async {
    return await _homeRepository.getPhotos(page, perPage);
  }
}
