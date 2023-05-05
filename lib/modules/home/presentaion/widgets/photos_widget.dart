import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/resourses/color_manager.dart';
import '../../../../core/resourses/routes_manager.dart';
import '../../../../core/state_status/provider_state_status.dart';
import '../providers/home_provider.dart';

class PhotosWidget extends StatelessWidget {
  const PhotosWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeProvider>(
      builder: (context, homeData, child) {
        if (homeData.photosStatus != ProviderStateStatus.success) {
          return const PhotosLoading();
        }
        final photos = homeData.photos;
        return SliverGrid(
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
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutesName.detailPhoto,
                    arguments: homeData.photos![index],
                  );
                  homeData.toggle();
                },
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image(
                      image: NetworkImage(
                        photos[index].src.portrait,
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
                        photos[index].photographer,
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
            childCount: photos!.length,
          ),
        );
      },
    );
  }
}

class PhotosLoading extends StatelessWidget {
  const PhotosLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverGrid(
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
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.white,
            child: Container(
              color: Colors.white,
            ),
          );
        },
        childCount: 4,
      ),
    );
  }
}
