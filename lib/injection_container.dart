import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:wallpaper_app/core/database/sql_db.dart';
import 'package:wallpaper_app/core/network/client.dart';
import 'package:wallpaper_app/core/resourses/constants_manager.dart';
import 'package:wallpaper_app/modules/detaile_photo/data/datasource/local_datasource/local_datasource.dart';
import 'package:wallpaper_app/modules/detaile_photo/data/datasource/local_datasource/local_datasource_impl.dart';
import 'package:wallpaper_app/modules/detaile_photo/data/repository/detail_photo_repository_impl.dart';
import 'package:wallpaper_app/modules/home/data/repository/home_repository_impl.dart';
import 'package:wallpaper_app/modules/search/data/repository/search_repository_impl.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/repository/detail_photo_repository.dart';
import 'package:wallpaper_app/modules/home/domain/repository/home_repository.dart';
import 'package:wallpaper_app/modules/search/domain/repository/search_repository.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/download_photo_usecase.dart';
import 'package:wallpaper_app/modules/home/domain/usecase/get_collections_usecase.dart';
import 'package:wallpaper_app/modules/home/domain/usecase/get_photos_usecase.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/insert_to_favourite_usecase.dart';
import 'package:wallpaper_app/modules/detaile_photo/domain/usecase/read_favourite_usecase.dart';
import 'package:wallpaper_app/modules/search/domain/usecase/search_photo_by_keyword_usecase.dart';
import 'package:wallpaper_app/modules/detaile_photo/presentaion/providers/detail_photo_provider.dart';
import 'package:wallpaper_app/modules/home/presentaion/providers/home_provider.dart';
import 'package:wallpaper_app/modules/search/presentaion/providers/search_provider.dart';

import 'modules/home/data/datasource/remote_datasource/home_remote_datasource.dart';
import 'modules/home/data/datasource/remote_datasource/home_remote_datatsource_impl.dart';
import 'modules/search/data/datasource/remote_datasource/search_remote_datasource_impl.dart';
import 'modules/search/data/datasource/remote_datasource/search_remote_datatsource.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
      () => HomeProvider(getCollectionsUseCase: sl(), getPhotosUseCase: sl()));
  sl.registerFactory(() => SearchProvider(searchPhotoByKeywordUsecase: sl()));
  sl.registerFactory(
    () => DetailPhotoProvider(
      downloadPhotoUsecase: sl(),
      insertToFavouriteUseCase: sl(),
      readFavouriteUseCase: sl(),
    ),
  );

  sl.registerLazySingleton(
    () => Dio().initClient(AppConstants.baseUrl),
  );
  sl.registerLazySingleton(() => GetCollectionsUseCase(sl()));
  sl.registerLazySingleton(() => GetPhotosUseCase(sl()));
  sl.registerLazySingleton(() => SearchPhotoByKeywordUsecase(sl()));
  sl.registerLazySingleton(() => DownloadPhotoUsecase(sl()));
  sl.registerLazySingleton(() => InsertToFavouriteUseCase(sl()));
  sl.registerLazySingleton(() => ReadFavouriteUseCase(sl()));
  sl.registerLazySingleton<HomeRepository>(() => HomeRepositoryImpl(sl()));
  sl.registerLazySingleton<SearchRepository>(() => SearchRepositoryImpl(sl()));
  sl.registerLazySingleton<DetailPhotoRepository>(
      () => DetailPhotoRepositoryImpl(sl()));
  sl.registerLazySingleton<HomeRemoteDataSource>(
      () => HomeRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<SearchRemoteDataSource>(
      () => SearchRemoteDataSourceImpl(sl()));
  sl.registerLazySingleton<LocalDatasource>(
      () => LocalDatasourceImpl(Dio(), SqlDb()));
}
