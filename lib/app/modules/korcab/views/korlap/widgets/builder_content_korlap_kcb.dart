import 'package:app_pemenangan_caleg/app/data/models/users/result_users2_model/data_users2.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/korlap/korlap_kcb_controller.dart';
import 'package:app_pemenangan_caleg/app/utils/constants_status_verification_tps.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../../widgets/infinite_scroll/infinite_scroll.dart';

class BuilderContentKorlapKcb extends GetView<KorlapKcbController> {
  const BuilderContentKorlapKcb({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    // Future<Widget> showCustomFullDialog({
    //   required BuildContext context,
    //   required String title,
    //   required int id,
    // }) async {
    //   return await showDialog(
    //     context: context,
    //     builder: (context) => CustomDialogFullscreenPendukung(
    //       title: title,
    //       isEdit: true,
    //       id: id,
    //     ),
    //   ).whenComplete(
    //     () => controller.clearDataSelected(),
    //   );
    // }

    Widget builderImage(DataUsers2 item) {
      return Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            height: double.infinity,
            imageUrl: '${item.gambarProfile}',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Image.asset(
              'assets/img/placeholder_no_photo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget builderInfo(DataUsers2 item) {
      final iconVerifStatus = switch (item.isAktif) {
        ConstantsStatusVerificationTPS.verified => Icons.verified_rounded,
        ConstantsStatusVerificationTPS.rejected => Icons.cancel_rounded,
        _ => Icons.pending_rounded,
      };
      final colorVerifStatus = switch (item.isAktif) {
        ConstantsStatusVerificationTPS.verified => Colors.green,
        ConstantsStatusVerificationTPS.rejected => Colors.red,
        _ => Colors.purple,
      };
      final verifStatus = switch (item.isAktif) {
        ConstantsStatusVerificationTPS.verified => 'Verifikasi',
        ConstantsStatusVerificationTPS.rejected => 'Ditolak',
        _ => 'Menunggu Verifikasi',
      };

      return Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              '${item.namaProfile}',
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
                  Text('No. HP:', style: theme.textTheme.labelMedium),
                  const SizedBox(width: 2),
                  Text(
                    '${item.nohpProfile}',
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
                    '${item.alamatProfile}',
                    style: theme.textTheme.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 8,
                vertical: 4,
              ),
              decoration: BoxDecoration(
                color: colorVerifStatus,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    iconVerifStatus,
                    color: Colors.white,
                    size: 14,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    verifStatus,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
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
      child: PagedListView<int, DataUsers2>.separated(
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
                // if (direction == DismissDirection.endToStart) {
                //   Get.defaultDialog(
                //     title: 'Hapus Pendukung',
                //     middleText: 'Apakah anda yakin ingin menghapus pendukung?',
                //     textConfirm: 'Ya',
                //     textCancel: 'Tidak',
                //     onConfirm: () => controller.deletePendukung(item.id!),
                //   );
                // } else {
                //   showCustomFullDialog(
                //     context: context,
                //     title: 'Pilih Pengganti Pendukung',
                //     id: item.id!,
                //   );
                // }
                return Future.value(false);
              },
              child: GestureDetector(
                // onTap: () => controller.moveToDetail(item),
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  height: size.height * 0.2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      builderImage(item),
                      const SizedBox(width: 21),
                      builderInfo(item),
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
