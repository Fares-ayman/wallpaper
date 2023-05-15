import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shimmer/shimmer.dart';
import 'package:wallpaper_app/core/resourses/strings_manager.dart';
import 'package:wallpaper_app/core/resourses/values_manager.dart';
import 'package:wallpaper_app/core/state_status/provider_state_status.dart';
import 'package:wallpaper_app/modules/search/presentaion/providers/search_provider.dart';

import '../../../../core/component/snackbar/info_snackbar.dart';
import '../../../../core/resourses/color_manager.dart';
import '../../../../core/resourses/routes_manager.dart';

class SearchScreen extends StatelessWidget {
  final refreshController = RefreshController();

  SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SearchLayout(refreshController: refreshController);
  }
}

// ignore: must_be_immutable
class SearchLayout extends StatefulWidget {
  RefreshController refreshController = RefreshController();

  SearchLayout({super.key, required this.refreshController});

  @override
  State<SearchLayout> createState() => _SearchLayoutState();
}

class _SearchLayoutState extends State<SearchLayout> {
  final refreshController = RefreshController();
  final keywordController = TextEditingController();
  String? initialKeyword;

  @override
  void didChangeDependencies() {
    initialKeyword = ModalRoute.of(context)?.settings.arguments as String?;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (initialKeyword == null) return;
      if (initialKeyword?.isNotEmpty ?? false) {
        keywordController.text = initialKeyword ?? "";
        context.read<SearchProvider>().onKeywordChange(keywordController.text);
        context.read<SearchProvider>().searchPhotos();
      }
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBarMethod(context),
      body: Consumer<SearchProvider>(
        builder: (context, searchData, child) {
          if (searchData.photosStatus == ProviderStateStatus.initial) {
            return const SizedBox();
          }
          if (searchData.photosStatus != ProviderStateStatus.success &&
              searchData.photos.isEmpty) {
            return const PhotosLoading();
          }
          if (searchData.photosStatus == ProviderStateStatus.success) {
            if (refreshController.isRefresh) {
              refreshController.refreshCompleted();
            }
            if (refreshController.isLoading) {
              refreshController.loadComplete();
            }
          }
          if (searchData.photosStatus == ProviderStateStatus.error) {
            if (refreshController.isRefresh) {
              refreshController.refreshCompleted();
            }
            if (refreshController.isLoading) {
              refreshController.loadComplete();
            }

            showInfoSnackBar(
              context,
              AppStrings.somthingwrong,
            );
          }
          return SmartRefresher(
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
                      strokeWidth: AppSize.s2,
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
                      strokeWidth: AppSize.s2,
                    ),
                  ),
                );
              },
            ),
            enablePullUp: true,
            onRefresh: () {
              context.read<SearchProvider>().searchPhotos(showLoading: false);
            },
            enablePullDown: true,
            onLoading: () {
              context.read<SearchProvider>().getNextPhotos();
            },
            child: _bodyMethod(searchData),
          );
        },
      ),
    );
  }

  Widget _bodyMethod(SearchProvider searchData) {
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
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                AppRoutesName.detailPhoto,
                arguments: searchData.photos[index],
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image(
                  image: NetworkImage(
                    searchData.photos[index].src.portrait,
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
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [AppColor.black, AppColor.transparent],
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
                    searchData.photos[index].photographer,
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium
                        ?.copyWith(color: AppColor.white),
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          );
        },
        childCount: searchData.photos.length,
      ),
    );
  }

  AppBar _appBarMethod(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          context.read<SearchProvider>().clearList();

          Navigator.pop(context);
        },
        iconSize: AppSize.s20,
        icon: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: Theme.of(context).textTheme.headlineLarge?.color,
        ),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      title: TextField(
        controller: keywordController,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: AppStrings.hintSearchTextField,
          hintStyle: Theme.of(context).textTheme.bodyMedium,
        ),
        style: Theme.of(context).textTheme.bodyLarge,
        autofocus: initialKeyword != null ? false : true,
        textInputAction: TextInputAction.search,
        onChanged: context.read<SearchProvider>().onKeywordChange,
        onSubmitted: (_) {
          context.read<SearchProvider>().searchPhotos();
        },
      ),
      actions: [
        context.read<SearchProvider>().keyword.isEmpty
            ? const SizedBox()
            : IconButton(
                onPressed: () {
                  keywordController.clear();
                  context.read<SearchProvider>().clearKeyword();
                },
                icon: Icon(
                  Icons.close,
                  color: Theme.of(context).textTheme.headlineLarge?.color,
                ),
              ),
      ],
      elevation: 1,
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
            highlightColor: AppColor.white,
            child: Container(
              color: AppColor.white,
            ),
          );
        },
        childCount: 8,
      ),
    );
  }
}
