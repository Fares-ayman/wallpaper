import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';

import '../repository/detail_photo_repository.dart';

class ReadFavouriteUseCase {
  final DetailPhotoRepository _detailPhotoRepository;

  ReadFavouriteUseCase(this._detailPhotoRepository);

  Future<List<PhotoItemEntity>> call(String sql) {
    return _detailPhotoRepository.readFavourites(sql);
  }
}
