import 'package:wallpaper_app/modules/home/data/model/collection_model.dart';
import 'package:wallpaper_app/modules/home/data/model/photo_model.dart';
import 'package:wallpaper_app/modules/home/domain/entity/collection_entity.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';

extension CollectionItemModelMapper on CollectionItemModel? {
  CollectionItemEntity toDomain() {
    return CollectionItemEntity(
      this?.id ?? "",
      this?.title ?? "",
    );
  }
}

extension PhotoSrcModelMapper on PhotoSrcModel? {
  PhotoSrcEntity toDomain() {
    return PhotoSrcEntity(
      this?.original ?? "",
      this?.large ?? "",
      this?.portrait ?? "",
    );
  }
}

extension PhotoItemModelMapper on PhotoItemModel? {
  PhotoItemEntity toDomain() {
    return PhotoItemEntity(
      this?.id ?? 0,
      this?.url ?? "",
      this?.photographer ?? "",
      this?.avgColor ?? "",
      this?.src.toDomain() ?? PhotoSrcEntity("", "", ""),
      this?.alt ?? "",
    );
  }
}
