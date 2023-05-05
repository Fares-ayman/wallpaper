import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/core/extension/string_extension.dart';
import 'package:wallpaper_app/core/resourses/strings_manager.dart';
import 'package:wallpaper_app/modules/home/domain/entity/photo_entity.dart';
import 'package:wallpaper_app/injection_container.dart' as di;
import 'package:wallpaper_app/modules/detaile_photo/presentaion/providers/detail_photo_provider.dart';

import '../../../../core/component/dialog/loading_dialog.dart';
import '../../../../core/component/dialog/success_dialog.dart';
import '../../../../core/component/snackbar/info_snackbar.dart';
import '../../../../core/resourses/color_manager.dart';
import '../../../../core/resourses/values_manager.dart';
import '../../../../core/state_status/download_state_status.dart';

class DetailPhotoScreen extends StatelessWidget {
  const DetailPhotoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => di.sl<DetailPhotoProvider>(),
      builder: (context, child) {
        return const DetailPhotoLayout();
      },
    );
  }
}

class DetailPhotoLayout extends StatefulWidget {
  const DetailPhotoLayout({super.key});

  @override
  State<DetailPhotoLayout> createState() => _DetailPhotoLayoutState();
}

class _DetailPhotoLayoutState extends State<DetailPhotoLayout> {
  late PhotoItemEntity photo;

  @override
  void didChangeDependencies() {
    photo = ModalRoute.of(context)?.settings.arguments as PhotoItemEntity;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<DetailPhotoProvider>(
      builder: (context, detailPhotoData, child) {
        if (detailPhotoData.favouritStatus == DownloadStatus.downloading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showLoadingDialog(context);
          });
        }
        if (detailPhotoData.favouritStatus == DownloadStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            showSuccessDialog(context, AppStrings.successAddingFavourite);
          });
        }

        if (detailPhotoData.favouritStatus == DownloadStatus.failed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            showInfoSnackBar(
              context,
              AppStrings.somthingWrongAddingFavourite,
            );
          });
        }
        if (detailPhotoData.downloadStatus == DownloadStatus.downloading) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            showLoadingDialog(context);
          });
        }
        if (detailPhotoData.downloadStatus == DownloadStatus.success) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            showSuccessDialog(context, AppStrings.successDownloading);
          });
        }

        if (detailPhotoData.downloadStatus == DownloadStatus.failed) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.pop(context);
            showInfoSnackBar(
              context,
              AppStrings.somthingWrongDownloading,
            );
          });
        }
        return Scaffold(
          appBar: AppBar(
            elevation: AppSize.s0,
            backgroundColor: Colors.transparent,
            systemOverlayStyle: SystemUiOverlayStyle.dark,
            leading: IconButton(
              onPressed: () => Navigator.pop(context),
              splashRadius: AppSize.s20,
              icon: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Theme.of(context).textTheme.headlineLarge?.color,
              ),
            ),
            centerTitle: false,
            title: Text(
              AppStrings.datailPhoto,
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: Column(
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.66,
                child: Image(
                  image: NetworkImage(
                    photo.src.original,
                  ),
                  fit: BoxFit.cover,
                  loadingBuilder: (_, widget, progress) {
                    if (progress == null) {
                      return widget;
                    }

                    return Image(
                      image: NetworkImage(photo.src.portrait),
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        }
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    loadingProgress.expectedTotalBytes!
                                : null,
                          ),
                        );
                      },
                      errorBuilder: (_, __, ___) {
                        return const Center(
                          child: Icon(
                            Icons.broken_image_sharp,
                            color: Colors.blueGrey,
                          ),
                        );
                      },
                    );
                  },
                  errorBuilder: (_, __, ___) {
                    return Center(
                      child: Icon(
                        Icons.broken_image_rounded,
                        color: AppColor.primaryColor,
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: AppSize.s16),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.only(
                    left: AppPadding.p16,
                    right: AppPadding.p16,
                    bottom: MediaQuery.of(context).padding.bottom,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              photo.photographer,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            const SizedBox(height: AppSize.s16),
                            if (photo.alt.isNotEmpty == true) ...[
                              Text(
                                photo.alt,
                                style: Theme.of(context).textTheme.bodyMedium,
                                maxLines: 2,
                              ),
                              const SizedBox(height: AppSize.s16),
                            ],
                            Row(
                              children: [
                                Container(
                                  height: AppSize.s24,
                                  width: AppSize.s24,
                                  decoration: BoxDecoration(
                                    border: Border.all(),
                                    shape: BoxShape.circle,
                                    color: photo.avgColor.toColor(),
                                  ),
                                ),
                                const SizedBox(width: AppSize.s8),
                                Text(
                                  photo.avgColor,
                                  style: Theme.of(context).textTheme.titleSmall,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: AppSize.s16),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            OutlinedButton.icon(
                              onPressed: () {
                                detailPhotoData.insertToFavourite(photo);
                              },
                              style: OutlinedButton.styleFrom(
                                backgroundColor: AppColor.primaryColor,
                                padding: const EdgeInsets.all(AppPadding.p16),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s16),
                                ),
                              ),
                              icon: Icon(
                                CupertinoIcons.heart,
                                color: AppColor.white,
                              ),
                              label: Text(
                                AppStrings.favourite,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: AppSize.s16),
                            OutlinedButton.icon(
                              onPressed: () {
                                detailPhotoData
                                    .downloadPhoto(photo.src.original);
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.all(AppPadding.p16),
                                shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.circular(AppSize.s16),
                                ),
                              ),
                              icon: Icon(
                                CupertinoIcons.cloud_download,
                                color: Theme.of(context)
                                    .textTheme
                                    .headlineLarge
                                    ?.color,
                              ),
                              label: Text(
                                AppStrings.download,
                                style: Theme.of(context).textTheme.titleSmall,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
