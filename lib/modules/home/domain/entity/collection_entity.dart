class CollectionEntity {
  final List<CollectionItemEntity> collections;

  CollectionEntity(this.collections);
}

class CollectionItemEntity {
  final String id;
  final String title;

  CollectionItemEntity(this.id, this.title);
}
