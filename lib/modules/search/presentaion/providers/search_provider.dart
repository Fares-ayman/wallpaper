import 'package:flutter/material.dart';
import 'package:wallpaper_app/core/state_status/provider_state_status.dart';
import 'package:wallpaper_app/modules/search/domain/usecase/search_photo_by_keyword_usecase.dart';

import '../../../home/domain/entity/photo_entity.dart';

class SearchProvider extends ChangeNotifier {
  final SearchPhotoByKeywordUsecase searchPhotoByKeywordUsecase;

  String keyword = "";
  int? photosPage;
  bool? hasReacMax;
  ProviderStateStatus photosStatus = ProviderStateStatus.initial;
  List<PhotoItemEntity> photos = [];

  SearchProvider({
    required this.searchPhotoByKeywordUsecase,
  });

  void onKeywordChange(String value) {
    keyword = value;
    notifyListeners();
  }

  void clearKeyword() {
    keyword = "";
    notifyListeners();
  }

  void searchPhotos({
    bool showLoading = true,
    int page = 1,
  }) async {
    if (showLoading) {
      photosStatus = ProviderStateStatus.loading;
    }
    try {
      final result = await searchPhotoByKeywordUsecase.call(page, 24, keyword);

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
      photos = List.from(photos)..addAll(result);
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
    searchPhotos(showLoading: false, page: nextPage);
  }
}
