// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collection_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

// ignore: non_constant_identifier_names
_$_CollectionModel _$$_CollectionModelFromJson(Map<String, dynamic> json) =>
    _$_CollectionModel(
      collections: (json['collections'] as List<dynamic>?)
              ?.map((e) =>
                  CollectionItemModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_CollectionModelToJson(_$_CollectionModel instance) =>
    <String, dynamic>{
      'collections': instance.collections,
    };

// ignore: non_constant_identifier_names
_$_CollectionItemModel _$$_CollectionItemModelFromJson(
        Map<String, dynamic> json) =>
    _$_CollectionItemModel(
      id: json['id'] as String,
      title: json['title'] as String,
    );

// ignore: non_constant_identifier_names
Map<String, dynamic> _$$_CollectionItemModelToJson(
        _$_CollectionItemModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
    };
