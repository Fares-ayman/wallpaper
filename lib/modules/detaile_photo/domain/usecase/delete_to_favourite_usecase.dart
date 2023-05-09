import 'package:wallpaper_app/modules/detaile_photo/domain/repository/detail_photo_repository.dart';

class DeleteToFavouriteUseCase {
  final DetailPhotoRepository _detailPhotoRepository;

  DeleteToFavouriteUseCase(this._detailPhotoRepository);

  Future<void> call(String sql) {
    return _detailPhotoRepository.deleteToFavourite(sql);
  }
}
