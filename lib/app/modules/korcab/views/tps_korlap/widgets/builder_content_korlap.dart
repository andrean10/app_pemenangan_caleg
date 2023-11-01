import 'package:app_pemenangan_caleg/app/data/models/tps/tps_korlap/response/data_tps_korlap.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/tps_korlap/tps_korlap_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:logger/logger.dart';

import '../../../../../data/models/users/profile_model.dart';
import '../../../../../widgets/infinite_scroll/infinite_scroll.dart';
import 'custom_dialog_fullscreen_korlap.dart';

class BuilderContentKorlap extends GetView<TPSKorlapController> {
  const BuilderContentKorlap({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    Future<Widget> showCustomFullDialog({
      required BuildContext context,
      required String title,
      required int id,
    }) async {
      return await showDialog(
        context: context,
        builder: (context) => CustomDialogFullscreenKorlap(
          title: title,
          isEdit: true,
          id: id,
        ),
      ).whenComplete(
        () => controller.clearDataSelected(),
      );
    }

    Widget builderImage(ProfileModel? profile) {
      return Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            height: double.infinity,
            imageUrl: '${profile?.gambarProfile}',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Image.asset(
              'assets/img/placeholder_no_photo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget builderInfo(ProfileModel? profile) {
      return Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              '${profile?.namaProfile}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const SizedBox(height: 8),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: theme.colorScheme.outline.withOpacity(0.5),
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('NIK:', style: theme.textTheme.labelMedium),
                  const SizedBox(width: 2),
                  Text(
                    '${profile?.nikProfile}',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(
                  Icons.location_on_rounded,
                  size: 14,
                  color: theme.colorScheme.primary,
                ),
                const SizedBox(width: 2),
                Expanded(
                  child: Text(
                    '${profile?.alamatProfile}',
                    style: theme.textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    return LiquidPullToRefresh(
      color: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.primaryContainer,
      showChildOpacityTransition: false,
      onRefresh: () async => controller.pagingC.refresh(),
      child: PagedListView<int, DataTpsKorlap>.separated(
        scrollController: controller.scrollC,
        pagingController: controller.pagingC,
        builderDelegate: PagedChildBuilderDelegate(
          firstPageProgressIndicatorBuilder: (context) =>
              InfiniteScroll.builderFirstPageProgress(),
          firstPageErrorIndicatorBuilder: (context) =>
              InfiniteScroll.builderFirstPageError(
            context: context,
            controller: controller.pagingC,
          ),
          newPageProgressIndicatorBuilder: (context) =>
              InfiniteScroll.builderNewPageProgress(size),
          newPageErrorIndicatorBuilder: (context) =>
              InfiniteScroll.builderNewPageError(controller.pagingC),
          noItemsFoundIndicatorBuilder: (context) =>
              InfiniteScroll.builderNoItemsFound(),
          animateTransitions: true,
          itemBuilder: (context, item, index) {
            final profile = item.users?.profile;

            return Dismissible(
              key: Key(item.id.toString()),
              background: Container(
                color: Colors.green,
                alignment: Alignment.centerLeft,
                padding: const EdgeInsets.only(left: 21),
                child: const Icon(
                  Icons.edit_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              secondaryBackground: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: const EdgeInsets.only(right: 21),
                child: const Icon(
                  Icons.delete_rounded,
                  color: Colors.white,
                  size: 32,
                ),
              ),
              confirmDismiss: (direction) {
                if (direction == DismissDirection.endToStart) {
                  Get.defaultDialog(
                    title: 'Hapus Koordinator',
                    middleText:
                        'Apakah anda yakin ingin menghapus koordinator?',
                    textConfirm: 'Ya',
                    textCancel: 'Tidak',
                    onConfirm: () => controller.deleteCo(item.id!),
                  );
                } else {
                  Logger().d('debug: id ${item.id}');
                  showCustomFullDialog(
                    context: context,
                    title: 'Pilih Pengganti Koordinator',
                    id: item.id!,
                  );
                }
                return Future.value(false);
              },
              child: GestureDetector(
                onTap: () => controller.moveToDetail(item),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: size.height * 0.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      builderImage(profile),
                      const SizedBox(width: 21),
                      builderInfo(profile),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 32),
      ),
    );
  }
}
