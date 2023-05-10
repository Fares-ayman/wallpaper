import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:wallpaper_app/core/database/sql_db.dart';
import 'package:wallpaper_app/modules/detaile_photo/data/datasource/local_datasource/local_datasource.dart';

import '../../../../../core/resourses/constants_manager.dart';

class LocalDatasourceImpl extends LocalDatasource {
  final Dio dio;
  final SqlDb sqlDb;

  LocalDatasourceImpl(this.dio, this.sqlDb);

  @override
  Future<void> downloadPhoto(String photoUrl) async {
    if (Platform.isAndroid) {
      var storage = await Permission.storage.isGranted;

      if (!storage) {
        PermissionStatus permissionStatus = await Permission.storage.request();
        if (permissionStatus.isGranted) {
          var response = await dio.get(photoUrl,
              options: Options(responseType: ResponseType.bytes));
          if (response.statusCode == AppConstants.successStatusCode) {
            await ImageGallerySaver.saveImage(
              Uint8List.fromList(response.data),
              quality: AppConstants.qualityOfPhoto,
            );
          } else {
            throw Exception();
          }
        } else {
          throw Exception();
        }
      }
    }
  }

  @override
  Future<void> insertToFavourite(String sql) async {
    int response = await sqlDb.insertData(sql);
    if (response == AppConstants.databaseErrorStatusCode) {
      throw Exception();
    }
  }

  @override
  Future<List<Map>> readFavourites(String sql) async {
    List<Map> response = await sqlDb.readData(sql);
    return response;
  }

  @override
  Future<void> deleteToFavourite(String sql) async {
    int response = await sqlDb.deleteData(sql);
    if (response == AppConstants.databaseErrorStatusCode) {
      throw Exception();
    }
  }
}
