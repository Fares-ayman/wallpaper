import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:wallpaper_app/core/resourses/strings_manager.dart';
import 'package:wallpaper_app/core/state_status/provider_state_status.dart';
import 'package:wallpaper_app/injection_container.dart' as di;
import 'package:wallpaper_app/modules/home/presentaion/providers/home_provider.dart';

import '../../../../core/component/snackbar/info_snackbar.dart';
import '../../../../core/resourses/color_manager.dart';
import '../../../../core/resourses/routes_manager.dart';
import '../../../../core/resourses/values_manager.dart';
import '../../../detaile_photo/presentaion/providers/detail_photo_provider.dart';
import '../widgets/collection_widget.dart';
import '../widgets/photos_widget.dart';

class HomeScreen extends StatelessWidget {
  final refreshController = RefreshController();

  HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<DetailPhotoProvider>.value(
          value: context.read<DetailPhotoProvider>()..readFavourite(),
        ),
        ChangeNotifierProvider<HomeProvider>.value(
          value: context.read<HomeProvider>()
            ..getCollection()
            ..getPhotos(),
          builder: (context, child) {
            return Consumer2<DetailPhotoProvider, HomeProvider>(
              builder: (context, detailePhotoData, homeData, child) {
                if (homeData.collectionStatus == ProviderStateStatus.success &&
                    homeData.photosStatus == ProviderStateStatus.success) {
                  if (refreshController.isRefresh) {
                    refreshController.refreshCompleted();
                  }
                  if (refreshController.isLoading) {
                    refreshController.loadComplete();
                  }
                }

                if (homeData.collectionStatus == ProviderStateStatus.error ||
                    homeData.photosStatus == ProviderStateStatus.error) {
                  if (refreshController.isRefresh) {
                    refreshController.refreshCompleted();
                  }
                  if (refreshController.isLoading) {
                    refreshController.loadComplete();
                  }

                  showInfoSnackBar(context, AppStrings.somthingwrong);
                }
                return HomeScreenLayout(refreshController: refreshController);
              },
            );
          },
        ),
      ],
    );
  }
}

// ignore: must_be_immutable
class HomeScreenLayout extends StatelessWidget {
  RefreshController refreshController = RefreshController();

  HomeScreenLayout({super.key, required this.refreshController});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SmartRefresher(
          controller: refreshController,
          header: CustomHeader(
            builder: (context, mode) {
              if (mode == RefreshStatus.idle) {
                return const SizedBox();
              }
              return Center(
                child: SizedBox(
                  width: AppSize.s32,
                  height: AppSize.s32,
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
          ),
          footer: CustomFooter(
            builder: (context, mode) {
              if (mode == LoadStatus.idle) {
                return const SizedBox();
              }
              return Center(
                child: SizedBox(
                  width: AppSize.s32,
                  height: AppSize.s32,
                  child: CircularProgressIndicator(
                    color: AppColor.primaryColor,
                    strokeWidth: 2,
                  ),
                ),
              );
            },
          ),
          enablePullUp: true,
          onRefresh: () {
            context.read<HomeProvider>().getCollection(showLoading: false);
            context.read<HomeProvider>().getPhotos(showLoading: false);
          },
          enablePullDown: true,
          onLoading: () {
            context.read<HomeProvider>().getNextPhotos();
          },
          child: CustomScrollView(slivers: [
            SliverAppBar(
              actions: [
                Stack(
                  children: [
                    IconButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, AppRoutesName.favouritePhoto);
                        /* context.read<HomeProvider>().makeFavouriteAddFalse(); */
                      },
                      splashRadius: AppSize.s20,
                      icon: Icon(
                        CupertinoIcons.heart,
                        color: Theme.of(context).textTheme.headlineLarge?.color,
                      ),
                    ),
                    context.read<DetailPhotoProvider>().favouriteAdded
                        ? const Positioned(
                            bottom: 35.0,
                            left: 28.0,
                            child: CircleAvatar(
                              backgroundColor: Colors.red,
                              radius: AppSize.s4,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ],
              automaticallyImplyLeading: false,
              floating: true,
              centerTitle: false,
              title: Text(
                AppStrings.discover,
                textAlign: TextAlign.left,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              elevation: 0,
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(76),
                child: Container(
                  height: AppSize.s76,
                  alignment: Alignment.center,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, AppRoutesName.search);
                    },
                    child: Container(
                      height: AppSize.s76,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: AppPadding.p16),
                      margin:
                          const EdgeInsets.symmetric(horizontal: AppMargin.m16),
                      child: Row(
                        children: [
                          const Icon(
                            CupertinoIcons.search,
                            color: Colors.black,
                          ),
                          const SizedBox(width: AppSize.s8),
                          Text(
                            AppStrings.searchKeyword,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(color: Colors.black),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SliverPersistentHeader(
              pinned: true,
              delegate: CollectionWidget(),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(AppPadding.p16),
              sliver: SliverToBoxAdapter(
                child: Text(
                  AppStrings.popularImages,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
            ),
            const SliverPadding(
              padding: EdgeInsets.fromLTRB(AppPadding.p16, AppPadding.p0,
                  AppPadding.p16, AppPadding.p16),
              sliver: PhotosWidget(),
            ),
          ]),
        ),
      ),
    );
  }
}
