class PhotoEntity {
  final int page;
  final int perPage;
  final int totalResult;

  PhotoEntity(this.page, this.perPage, this.totalResult);
}

class PhotoItemEntity {
  final int id;
  final String url;
  final String photographer;
  final String avgColor;
  final PhotoSrcEntity src;
  final String alt;

  PhotoItemEntity(
      this.id, this.url, this.photographer, this.avgColor, this.src, this.alt);
}

class PhotoSrcEntity {
  final String original;
  final String large;
  final String portrait;

  PhotoSrcEntity(this.original, this.large, this.portrait);
}
