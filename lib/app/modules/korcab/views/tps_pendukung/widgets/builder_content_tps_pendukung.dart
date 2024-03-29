import 'package:app_pemenangan_caleg/app/data/models/tps/tps_pendukung/response/data_tps_pendukung.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/tps_pendukung/tps_pendukung_controller.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/views/tps_pendukung/widgets/custom_dialog_fullscreen_tps_pendukung.dart';
import 'package:app_pemenangan_caleg/app/utils/constants_status_verification_tps.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../../data/models/users/profile_model.dart';
import '../../../../../widgets/infinite_scroll/infinite_scroll.dart';

class BuilderContentTpsPendukung extends GetView<TPSPendukungKcbController> {
  const BuilderContentTpsPendukung({super.key});

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
        builder: (context) => CustomDialogFullscreenTpsPendukung(
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

    Widget builderInfo(DataTpsPendukung? item) {
      final profile = item?.users?.profile;

      final iconVerifStatus = switch (item!.verificationcoblosTps) {
        ConstantsStatusVerificationTPS.verified => Icons.verified_rounded,
        ConstantsStatusVerificationTPS.rejected => Icons.cancel_rounded,
        _ => Icons.pending_rounded,
      };
      final colorVerifStatus = switch (item.verificationcoblosTps) {
        ConstantsStatusVerificationTPS.verified => Colors.green,
        ConstantsStatusVerificationTPS.rejected => Colors.red,
        _ => Colors.purple,
      };
      final verifStatus = switch (item.verificationcoblosTps) {
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
      child: PagedListView<int, DataTpsPendukung>.separated(
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
                    title: 'Hapus Pendukung',
                    middleText: 'Apakah anda yakin ingin menghapus pendukung?',
                    textConfirm: 'Ya',
                    textCancel: 'Tidak',
                    onConfirm: () => controller.deletePendukung(item.id!),
                  );
                } else {
                  showCustomFullDialog(
                    context: context,
                    title: 'Pilih Pengganti Pendukung',
                    id: item.id!,
                  );
                }
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
                      builderImage(profile),
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
