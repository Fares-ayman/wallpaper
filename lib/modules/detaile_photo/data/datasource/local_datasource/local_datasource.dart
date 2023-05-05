abstract class LocalDatasource {
  Future<void> downloadPhoto(String photoUrl);
  Future<void> insertToFavourite(String sql);
  Future<List<Map>> readFavourites(String sql);
}
