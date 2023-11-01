import 'package:app_pemenangan_caleg/app/data/models/korlap/pendukung/response/data_pendukung_korlap.dart';
import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/pendukung/pendukung_klp_controller.dart';
import 'package:app_pemenangan_caleg/app/utils/constants_status_verification_tps.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../../data/models/users/profile_model.dart';
import '../../../../../widgets/infinite_scroll/infinite_scroll.dart';

class BuilderContentPendukungKlp extends GetView<PendukungKlpController> {
  const BuilderContentPendukungKlp({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    Widget builderImage(ProfileModel? item) {
      return Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: CachedNetworkImage(
            height: double.infinity,
            imageUrl: '${item?.gambarProfile}',
            fit: BoxFit.cover,
            errorWidget: (context, url, error) => Image.asset(
              'assets/img/placeholder_no_photo.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
      );
    }

    Widget builderBuktiLapangan(DataPendukungKorlap item) {
      var iconVerifyStatus = Icons.broken_image_rounded;
      var colorVerifyStatus = Colors.grey;
      var verifyStatus = 'Belum ada data';

      if (item.pendukungcoblosTps != null) {
        if (item.verificationcoblosTps != null) {
          if (item.verificationcoblosTps ==
              ConstantsStatusVerificationTPS.verified) {
            iconVerifyStatus = Icons.verified_rounded;
            colorVerifyStatus = Colors.green;
            verifyStatus = 'Diverifikasi';
          } else if (item.verificationcoblosTps ==
              ConstantsStatusVerificationTPS.rejected) {
            iconVerifyStatus = Icons.cancel_rounded;
            colorVerifyStatus = Colors.red;
            verifyStatus = 'Ditolak';
          }
        } else {
          iconVerifyStatus = Icons.hourglass_bottom_rounded;
          colorVerifyStatus = Colors.purple;
          verifyStatus = 'Menunggu Verifikasi';
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bukti Lapangan',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: colorVerifyStatus,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  iconVerifyStatus,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  verifyStatus,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget builderBuktiCoblos(DataPendukungKorlap item) {
      var iconVerifyStatus = Icons.broken_image_rounded;
      var colorVerifyStatus = Colors.grey;
      var verifyStatus = 'Belum Mencoblos';

      if (item.tpsCoblos != null) {
        if (item.tpsStatus != null &&
            item.tpsStatus == ConstantsStatusVerificationTPS.verified) {
          iconVerifyStatus = Icons.verified_rounded;
          colorVerifyStatus = Colors.green;
          verifyStatus = 'Sudah Mencoblos';
        }
      } else {
        if (item.tpsStatus != null &&
            item.tpsStatus == ConstantsStatusVerificationTPS.rejected) {
          iconVerifyStatus = Icons.cancel_rounded;
          colorVerifyStatus = Colors.orange;
          verifyStatus = 'Belum Diverifikasi';
        }
      }

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Bukti Lapangan',
            style: theme.textTheme.titleSmall,
          ),
          const SizedBox(height: 2),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 4,
            ),
            decoration: BoxDecoration(
              color: colorVerifyStatus,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  iconVerifyStatus,
                  color: Colors.white,
                  size: 14,
                ),
                const SizedBox(width: 4),
                Text(
                  verifyStatus,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    Widget builderInfo(DataPendukungKorlap item) {
      final users = item.users;

      return Expanded(
        flex: 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AutoSizeText(
              '${users?.profile?.namaProfile}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
            const Spacer(),
            builderBuktiLapangan(item),
            const SizedBox(height: 4),
            builderBuktiCoblos(item),
          ],
        ),
      );
    }

    return LiquidPullToRefresh(
      color: theme.colorScheme.primary,
      backgroundColor: theme.colorScheme.primaryContainer,
      showChildOpacityTransition: false,
      onRefresh: () async => controller.pagingC.refresh(),
      child: PagedListView<int, DataPendukungKorlap>.separated(
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
                onTap: () => controller.moveToDetail(item),
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
