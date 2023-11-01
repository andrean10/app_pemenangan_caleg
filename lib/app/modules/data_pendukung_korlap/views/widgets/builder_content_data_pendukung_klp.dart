import 'package:app_pemenangan_caleg/app/data/models/korlap/pendukung/response/data_pendukung_korlap.dart';
import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/pendukung/pendukung_klp_controller.dart';
import 'package:app_pemenangan_caleg/app/utils/constants_status_verification_tps.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../data/models/users/profile_model.dart';
import '../../../../widgets/infinite_scroll/infinite_scroll.dart';

class BuilderContentDataPendukungKlp extends GetView<PendukungKlpController> {
  const BuilderContentDataPendukungKlp({super.key});

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
            'Status',
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
                    '${users?.profile?.nikProfile}',
                    style: theme.textTheme.labelMedium,
                  ),
                ],
              ),
            ),
            const Spacer(),
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

            return Container(
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
            );
          },
        ),
        separatorBuilder: (context, index) => const SizedBox(height: 32),
      ),
    );
  }
}
