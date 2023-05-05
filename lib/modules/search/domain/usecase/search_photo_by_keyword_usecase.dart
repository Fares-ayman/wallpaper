import 'package:wallpaper_app/modules/search/domain/repository/search_repository.dart';

import '../../../home/domain/entity/photo_entity.dart';

class SearchPhotoByKeywordUsecase {
  final SearchRepository _searchRepository;

  SearchPhotoByKeywordUsecase(this._searchRepository);

  Future<List<PhotoItemEntity>> call(
    int page,
    int perPage,
    String keyword,
  ) async {
    return await _searchRepository.searchPhotoByKeyword(page, perPage, keyword);
  }
}
