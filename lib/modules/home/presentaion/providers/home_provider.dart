import 'package:flutter/foundation.dart';
import 'package:wallpaper_app/core/state_status/provider_state_status.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/modules/home/domain/usecase/get_collections_usecase.dart';
import 'package:wallpaper_app/modules/home/domain/usecase/get_photos_usecase.dart';

import '../../domain/entity/collection_entity.dart';

class HomeProvider extends ChangeNotifier {
  final GetCollectionsUseCase getCollectionsUseCase;
  final GetPhotosUseCase getPhotosUseCase;
  ProviderStateStatus? collectionStatus;
  List<CollectionItemEntity>? collections;
  ProviderStateStatus? photosStatus;
  List<PhotoItemEntity>? photos;
  bool? hasReacMax;
  int? photosPage;
  bool favouriteAdd = false;

  HomeProvider({
    required this.getCollectionsUseCase,
    required this.getPhotosUseCase,
  });

  void getCollection({
    bool showLoading = true,
  }) async {
    if (showLoading) {
      collectionStatus = ProviderStateStatus.loading;
    }
    try {
      final result = await getCollectionsUseCase.call(30);
      if (!showLoading) {
        collectionStatus = ProviderStateStatus.loading;
      }
      collectionStatus = ProviderStateStatus.success;
      collections = result;
    } catch (e) {
      if (!showLoading) {
        collectionStatus = ProviderStateStatus.loading;
      }
      collectionStatus = ProviderStateStatus.error;
    }
    notifyListeners();
  }

  void getPhotos({
    bool showLoading = true,
    int page = 1,
  }) async {
    if (showLoading) {
      photosStatus = ProviderStateStatus.loading;
    }
    try {
      final result = await getPhotosUseCase.call(page, 24);

      if (page == 1) {
        photosPage = page;
        hasReacMax = result.isEmpty;
        photosStatus = ProviderStateStatus.success;
        photos = result;
        notifyListeners();

        return;
      }
      photosPage = page;
      hasReacMax = result.isEmpty;
      photosStatus = ProviderStateStatus.success;
      photos = List.from(photos!)..addAll(result);
    } catch (e) {
      if (!showLoading) {
        photosStatus = ProviderStateStatus.loading;
      }
      photosStatus = ProviderStateStatus.error;
    }
    notifyListeners();
  }

  void getNextPhotos() {
    final nextPage = photosPage! + 1;
    getPhotos(showLoading: false, page: nextPage);
    notifyListeners();
  }

  void toggle() {
    favouriteAdd = !favouriteAdd;
    notifyListeners();
  }
}
