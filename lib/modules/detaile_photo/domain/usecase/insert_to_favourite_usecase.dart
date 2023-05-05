import 'package:wallpaper_app/modules/detaile_photo/domain/repository/detail_photo_repository.dart';

class InsertToFavouriteUseCase {
  final DetailPhotoRepository _detailPhotoRepository;

  InsertToFavouriteUseCase(this._detailPhotoRepository);

  Future<void> call(String sql) {
    return _detailPhotoRepository.insertToFavourite(sql);
  }
}
