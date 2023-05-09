import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/state_status/download_state_status.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/delete_to_favourite_usecase.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/download_photo_usecase.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/insert_to_favourite_usecase.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/read_favourite_usecase.dart';

import '../../../../core/state_status/provider_state_status.dart';

class DetailPhotoProvider extends ChangeNotifier {
  final DownloadPhotoUsecase downloadPhotoUsecase;
  final InsertToFavouriteUseCase insertToFavouriteUseCase;
  final DeleteToFavouriteUseCase deleteToFavouriteUseCase;
  final ReadFavouriteUseCase readFavouriteUseCase;
  DownloadStatus downloadStatus = DownloadStatus.initial;
  DownloadStatus insertFavouritStatus = DownloadStatus.initial;
  DownloadStatus deleteFavouritStatus = DownloadStatus.initial;
  List<PhotoItemEntity> favouritePhotos = [];
  ProviderStateStatus? favouritePhotosStatus = ProviderStateStatus.initial;
  bool isDownloading = false;
  bool favouriteAdded = false;

  DetailPhotoProvider({
    required this.downloadPhotoUsecase,
    required this.insertToFavouriteUseCase,
    required this.readFavouriteUseCase,
    required this.deleteToFavouriteUseCase,
  });

  void downloadPhoto(String photoUrl) async {
    if (downloadStatus == DownloadStatus.downloading) return;

    try {
      isDownloading = true;
      notifyListeners();

      downloadStatus = DownloadStatus.downloading;
      notifyListeners();

      await downloadPhotoUsecase.call(photoUrl);
      downloadStatus = DownloadStatus.success;
      notifyListeners();
    } catch (e) {
      downloadStatus = DownloadStatus.failed;
      notifyListeners();
    }

    /* notifyListeners(); */
  }

  void insertToFavourite(PhotoItemEntity photoItemEntity) async {
    if (insertFavouritStatus == DownloadStatus.downloading) return;

    try {
      isDownloading = false;
      /* favouriteAdded = true; */
      notifyListeners();
      insertFavouritStatus = DownloadStatus.downloading;
      notifyListeners();

      await insertToFavouriteUseCase.call('''
    INSERT INTO 'photos' ('photo_id','url','photographer','avgColor','original','large','portrait','alt') VALUES ('${photoItemEntity.id}','${photoItemEntity.url}','${photoItemEntity.photographer}','${photoItemEntity.avgColor}','${photoItemEntity.src.original}','${photoItemEntity.src.large}','${photoItemEntity.src.portrait}','${photoItemEntity.alt}')
''');
      favouritePhotos.add(photoItemEntity);
      insertFavouritStatus = DownloadStatus.success;
      notifyListeners();
    } catch (e) {
      insertFavouritStatus = DownloadStatus.failed;
      notifyListeners();
    }
  }

  void deleteToFavourite(PhotoItemEntity photoItemEntity) async {
    if (deleteFavouritStatus == DownloadStatus.downloading) return;

    try {
      isDownloading = false;
      /* favouriteAdded = true; */
      notifyListeners();
      deleteFavouritStatus = DownloadStatus.downloading;
      notifyListeners();

      await deleteToFavouriteUseCase.call('''
        DELETE FROM 'photos' WHERE photo_id = ${photoItemEntity.id}
''');

      favouritePhotos.remove(photoItemEntity);
      deleteFavouritStatus = DownloadStatus.success;
      notifyListeners();
    } catch (e) {
      deleteFavouritStatus = DownloadStatus.failed;
      notifyListeners();
    }
  }

  void readFavourite() async {
    if (favouritePhotosStatus == ProviderStateStatus.loading) return;

    try {
      favouritePhotosStatus = ProviderStateStatus.loading;
      /* notifyListeners(); */

      favouritePhotos = await readFavouriteUseCase.call('''
    SELECT * FROM  'photos'
''');
      favouritePhotosStatus = ProviderStateStatus.success;
      /* notifyListeners(); */
    } catch (e) {
      favouritePhotosStatus = ProviderStateStatus.error;
      /* notifyListeners(); */
    }
    notifyListeners();
  }

  void makeFavouriteAddFalse() {
    if (favouriteAdded != false) {
      favouriteAdded = false;
      notifyListeners();
    }
  }

  void makeFavouriteAddTrue() {
    if (favouriteAdded != true) {
      favouriteAdded = true;
      notifyListeners();
    }
  }

  void isInFavouritePhotos(List<PhotoItemEntity> favouritesPhotos, int id) {
    for (PhotoItemEntity photo in favouritesPhotos) {
      if (photo.id == id) {
        favouriteAdded = true;
        notifyListeners();
        return;
      }
    }
    favouriteAdded = false;
    notifyListeners();
  }
}
