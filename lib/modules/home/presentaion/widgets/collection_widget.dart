import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/core/resourses/values_manager.dart';
import 'package:wallpaper_app/core/state_status/provider_state_status.dart';
import 'package:wallpaper_app/modules/home/presentaion/providers/home_provider.dart';

import '../../../../core/resourses/color_manager.dart';
import '../../../../core/resourses/routes_manager.dart';

class CollectionWidget extends SliverPersistentHeaderDelegate {
  @override
  double get maxExtent => 80;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.background,
        boxShadow: [
          if (shrinkOffset == 80)
            const BoxShadow(
              color: Colors.black12,
              spreadRadius: 1,
              blurRadius: 1,
              offset: Offset.zero,
            ),
        ],
      ),
      child: Consumer<HomeProvider>(
        builder: (context, homeData, child) {
          if (homeData.collectionStatus != ProviderStateStatus.success) {
            return const CollectionLoading();
          }
          final collections = homeData.collections;
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(
                horizontal: AppPadding.p16, vertical: AppPadding.p16),
            itemCount: collections?.length ?? 0,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    AppRoutesName.search,
                    arguments: collections[index].title,
                  );
                },
                child: Container(
                  margin: EdgeInsets.only(
                      left: index == 0 ? AppMargin.m0 : AppMargin.m16),
                  padding:
                      const EdgeInsets.symmetric(horizontal: AppPadding.p16),
                  decoration: BoxDecoration(
                    color: AppColor.primaryColor,
                    borderRadius: BorderRadius.circular(AppSize.s8),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    collections![index].title,
                    style: Theme.of(context)
                        .textTheme
                        .titleSmall
                        ?.copyWith(color: Colors.white),
                    maxLines: 1,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class CollectionLoading extends StatelessWidget {
  const CollectionLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.white,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.all(16),
        itemBuilder: (context, index) {
          return Container(
            width: 100,
            margin: EdgeInsets.only(
                left: index == 0 ? AppMargin.m0 : AppMargin.m16),
            padding: const EdgeInsets.all(AppPadding.p16),
            decoration: BoxDecoration(
              color: AppColor.white,
              borderRadius: BorderRadius.circular(AppSize.s8),
            ),
            alignment: Alignment.center,
          );
        },
      ),
    );
  }
}
