import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/core/resourses/strings_manager.dart';
import 'package:wallpaper_app/core/resourses/values_manager.dart';
import 'package:wallpaper_app/modules/detaile_photo/presentaion/providers/detail_photo_provider.dart';

import '../../../../core/resourses/color_manager.dart';
import '../../../../core/resourses/routes_manager.dart';
import '../../../../core/state_status/provider_state_status.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const FavouriteLayout();
  }
}

class FavouriteLayout extends StatelessWidget {
  const FavouriteLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
            context.read<DetailPhotoProvider>().makeFavouriteAddFalse();
          },
          iconSize: AppSize.s20,
          icon: Icon(
            Icons.arrow_back_ios_new_rounded,
            color: Theme.of(context).textTheme.headlineLarge?.color,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        centerTitle: false,
        title: Text(
          AppStrings.favouritePhoto,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: Consumer<DetailPhotoProvider>(
          builder: (context, detailPhotoData, child) {
        return detailPhotoData.favouritePhotos.isEmpty
            ? Center(
                child: Text(
                  AppStrings.emptyFavouriteList,
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              )
            : GridView.custom(
                padding: const EdgeInsets.all(AppPadding.p16),
                gridDelegate: SliverQuiltedGridDelegate(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  repeatPattern: QuiltedGridRepeatPattern.inverted,
                  pattern: const [
                    QuiltedGridTile(2, 1),
                    QuiltedGridTile(1, 1),
                  ],
                ),
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          AppRoutesName.detailPhoto,
                          arguments: detailPhotoData.favouritePhotos[index],
                        );
                      },
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image(
                            image: NetworkImage(
                              detailPhotoData
                                  .favouritePhotos[index].src.portrait,
                            ),
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) {
                              return Center(
                                child: Icon(
                                  Icons.broken_image_rounded,
                                  color: AppColor.primaryColor,
                                ),
                              );
                            },
                          ),
                          Container(
                            decoration: const BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Colors.black, Colors.transparent],
                                begin: Alignment.bottomCenter,
                                end: Alignment.center,
                              ),
                            ),
                          ),
                          Positioned(
                            left: 16,
                            right: 16,
                            bottom: 16,
                            child: Text(
                              detailPhotoData
                                  .favouritePhotos[index].photographer,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(color: Colors.white),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  childCount: detailPhotoData.favouritePhotos.length,
                ),
              );
      }),
    );
  }
}

class PhotosLoading extends StatelessWidget {
  const PhotosLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      padding: const EdgeInsets.all(AppPadding.p16),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 2,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 1),
          QuiltedGridTile(1, 1),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              color: Colors.white,
            ),
          );
        },
        childCount: 8,
      ),
    );
  }
}
