import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/state_status/download_state_status.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/download_photo_usecase.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/insert_to_favourite_usecase.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/read_favourite_usecase.dart';

import '../../../../core/state_status/provider_state_status.dart';

class DetailPhotoProvider extends ChangeNotifier {
  final DownloadPhotoUsecase downloadPhotoUsecase;
  final InsertToFavouriteUseCase insertToFavouriteUseCase;
  final ReadFavouriteUseCase readFavouriteUseCase;
  DownloadStatus downloadStatus = DownloadStatus.initial;
  DownloadStatus favouritStatus = DownloadStatus.initial;
  List<PhotoItemEntity> favouritePhotos = [];
  ProviderStateStatus? favouritePhotosStatus = ProviderStateStatus.initial;

  DetailPhotoProvider({
    required this.downloadPhotoUsecase,
    required this.insertToFavouriteUseCase,
    required this.readFavouriteUseCase,
  });

  void downloadPhoto(String photoUrl) async {
    if (downloadStatus == DownloadStatus.downloading) return;

    try {
      downloadStatus = DownloadStatus.downloading;
      notifyListeners();

      await downloadPhotoUsecase.call(photoUrl);
      downloadStatus = DownloadStatus.success;
      notifyListeners();
    } catch (e) {
      downloadStatus = DownloadStatus.failed;
      notifyListeners();
    }
  }

  void insertToFavourite(PhotoItemEntity photoItemEntity) async {
    if (favouritStatus == DownloadStatus.downloading) return;

    try {
      favouritStatus = DownloadStatus.downloading;
      notifyListeners();

      await insertToFavouriteUseCase.call('''
    INSERT INTO 'photos' ('url','photographer','avgColor','original','large','portrait','alt') VALUES ('${photoItemEntity.url}','${photoItemEntity.photographer}','${photoItemEntity.avgColor}','${photoItemEntity.src.original}','${photoItemEntity.src.large}','${photoItemEntity.src.portrait}','${photoItemEntity.alt}')
''');
      favouritStatus = DownloadStatus.success;
      notifyListeners();
    } catch (e) {
      favouritStatus = DownloadStatus.failed;
      notifyListeners();
    }
  }

  void readFavourite() async {
    if (favouritePhotosStatus == ProviderStateStatus.loading) return;

    try {
      favouritePhotosStatus = ProviderStateStatus.loading;
      notifyListeners();

      favouritePhotos = await readFavouriteUseCase.call('''
    SELECT * FROM  'photos'
''');
      favouritePhotosStatus = ProviderStateStatus.success;
      notifyListeners();
    } catch (e) {
      favouritePhotosStatus = ProviderStateStatus.error;
      notifyListeners();
    }
  }
}
