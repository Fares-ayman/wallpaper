import 'package:freezed_annotation/freezed_annotation.dart';

part 'photo_model.freezed.dart';
part 'photo_model.g.dart';

@freezed
class PhotoModel with _$PhotoModel {
  const factory PhotoModel({
    /// collections
    // ignore: invalid_annotation_target
    @JsonKey(name: "photos") @Default([]) List<PhotoItemModel> photos,

    /// paging property
    // ignore: invalid_annotation_target
    @JsonKey(name: "page") int? page,
    // ignore: invalid_annotation_target
    @JsonKey(name: "per_page") int? perPage,
    // ignore: invalid_annotation_target
    @JsonKey(name: "total_results") int? totalResult,
  }) = _PhotoModel;

  factory PhotoModel.fromJson(Map<String, Object?> json) =>
      _$PhotoModelFromJson(json);
}

@freezed
class PhotoItemModel with _$PhotoItemModel {
  const factory PhotoItemModel({
    // ignore: invalid_annotation_target
    @JsonKey(name: "id") required int id,
    // ignore: invalid_annotation_target

    // ignore: invalid_annotation_target
    @JsonKey(name: "url") required String url,

    // ignore: invalid_annotation_target
    @JsonKey(name: "photographer") required String photographer,
    // ignore: invalid_annotation_target
    @JsonKey(name: "avg_color") required String avgColor,
    // ignore: invalid_annotation_target
    @JsonKey(name: "src") required PhotoSrcModel src,
    // ignore: invalid_annotation_target
    @JsonKey(name: "alt") String? alt,
  }) = _PhotoItemModel;

  factory PhotoItemModel.fromJson(Map<String, Object?> json) =>
      _$PhotoItemModelFromJson(json);
}

@freezed
class PhotoSrcModel with _$PhotoSrcModel {
  const factory PhotoSrcModel({
    // ignore: invalid_annotation_target
    @JsonKey(name: "original") required String original,
    // ignore: invalid_annotation_target
    @JsonKey(name: "large") required String large,
    // ignore: invalid_annotation_target
    @JsonKey(name: "portrait") required String portrait,
  }) = _PhotoSrcModel;

  factory PhotoSrcModel.fromJson(Map<String, Object?> json) =>
      _$PhotoSrcModelFromJson(json);
}
