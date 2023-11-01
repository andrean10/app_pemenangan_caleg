import 'package:app_pemenangan_caleg/app/data/models/users/result_users2_model/data_users2.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/tps_pendukung/tps_pendukung_controller.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../../widgets/infinite_scroll/infinite_scroll.dart';

class BuilderListContentTpsPendukung
    extends GetView<TPSPendukungKcbController> {
  final bool isEdit;

  const BuilderListContentTpsPendukung({
    required this.isEdit,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    Widget builderImage(DataUsers2? profile) {
      return Expanded(
        flex: 2,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Stack(
            children: [
              CachedNetworkImage(
                height: double.infinity,
                imageUrl: '${profile?.gambarProfile}',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/img/placeholder_no_photo.png',
                  fit: BoxFit.cover,
                ),
              ),
              if (controller.dataUsersSelected.contains(profile))
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.primary,
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Icon(
                      Icons.check_rounded,
                      size: 14,
                      color: theme.colorScheme.onPrimary,
                    ),
                  ),
                ),
            ],
          ),
        ),
      );
    }

    Widget builderInfo(DataUsers2? profile) {
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
      child: PagedListView<int, DataUsers2>.separated(
        pagingController: controller.paging2C,
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
            return Obx(
              () => InkWell(
                onLongPress: () {
                  controller.isLongPressed.value = true;
                  controller.setDataUsersSelected(item, isEdit);
                },
                onTap: () {
                  if (controller.isLongPressed.value || isEdit) {
                    controller.setDataUsersSelected(item, isEdit);
                  }
                },
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
