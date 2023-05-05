import 'package:wallpaper_app/modules/detaile_photo/domain/repository/detail_photo_repository.dart';

class DownloadPhotoUsecase {
  final DetailPhotoRepository _detailPhotoRepository;

  DownloadPhotoUsecase(this._detailPhotoRepository);

  Future<void> call(String photoUrl) async {
    return await _detailPhotoRepository.downloadPhoto(photoUrl);
  }
}
