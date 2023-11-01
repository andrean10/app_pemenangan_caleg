import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../../../../data/models/korcab/tps/response/data_tps_korcab.dart';
import '../../../../widgets/infinite_scroll/infinite_scroll.dart';
import '../../controllers/data_tps_korcab/data_tps_korcab_controller.dart';

class DataTpsKorcabView extends GetView<DataTpsKorcabController> {
  const DataTpsKorcabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);

    Widget builderContent() {
      return LiquidPullToRefresh(
        color: theme.colorScheme.primary,
        backgroundColor: theme.colorScheme.primaryContainer,
        showChildOpacityTransition: false,
        onRefresh: () async => controller.pagingC.refresh(),
        child: PagedListView<int, DataTpsKorcab>(
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
            animateTransitions: true,
            itemBuilder: (context, item, index) {
              return ListTile(
                onTap: () => controller.manageTPS(isEdit: true, data: item),
                title: Text(
                  '${item.namaTps}',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                subtitle: Container(
                  margin: const EdgeInsets.only(top: 6),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.location_pin,
                            size: 16,
                          ),
                          const SizedBox(width: 2),
                          Expanded(
                            child: Text(
                              '${item.alamatTps}, ${GetUtils.capitalizeFirst(item.villages?.name ?? '')}',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton.icon(
                            onPressed: () => controller.moveToKorlap(item),
                            icon: const Icon(
                              Icons.group_rounded,
                              size: 16,
                            ),
                            label: Text('${item.totalcoTps ?? 0} Koordinator'),
                            style: TextButton.styleFrom(
                              foregroundColor: Colors.red,
                            ),
                          ),
                          TextButton.icon(
                            onPressed: () {
                              if (item.totalPendukung != null) {
                                controller.moveToPendukung(item.id!);
                              }
                            },
                            icon: const Icon(
                              Icons.group_rounded,
                              size: 16,
                            ),
                            label: (item.totalPendukung != null)
                                ? Text('${item.totalPendukung} Pendukung')
                                : const SizedBox(
                                    width: 15,
                                    height: 15,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                shape: Border(
                  bottom: BorderSide(
                    color: theme.colorScheme.outline.withOpacity(0.2),
                  ),
                ),
              );
            },
          ),
        ),
      );
    }

    Widget builderFAB() {
      return Obx(
        () => AnimatedOpacity(
          duration: 300.milliseconds,
          opacity: controller.isScrolling.value ? 0 : 1,
          child: FloatingActionButton(
            onPressed: () => controller.manageTPS(),
            child: const Icon(Icons.add_rounded),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Data TPS'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: builderContent(),
      floatingActionButton: builderFAB(),
    );
  }
}
