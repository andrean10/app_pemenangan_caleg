import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

import '../../../data/models/region/data_region_model.dart';

class CustomDropdownUsersPaginated extends StatelessWidget {
  final ScrollController _scrollController;
  final PagingController<int, DataRegionModel> _pagingController;
  final String title;
  final void Function(DataRegionModel) itemTap;

  const CustomDropdownUsersPaginated(
    this._scrollController,
    this._pagingController, {
    required this.title,
    required this.itemTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SingleChildScrollView(
          controller: _scrollController,
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.only(
              left: 12,
              right: 12,
              bottom: 8,
            ),
            decoration: BoxDecoration(
              border: Border(bottom: BorderSide(color: theme.dividerColor)),
            ),
            child: Row(
              children: [
                Expanded(
                  child: AutoSizeText(
                    title,
                    style: theme.textTheme.titleLarge,
                  ),
                ),
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(Icons.close_rounded),
                ),
              ],
            ),
          ),
        ),
        Expanded(
          child: PagedListView<int, DataRegionModel>(
            pagingController: _pagingController,
            builderDelegate: PagedChildBuilderDelegate(
              itemBuilder: (context, item, index) {
                // final isSelected = (_controller.currentIdProvince ==
                //     int.parse(data[index].id ?? '0'));

                return ListTile(
                  title: Text(
                    item.value!,
                    style: const TextStyle(
                        // fontSize: isSelected ? 18 : null,
                        // fontWeight:
                        //     (isSelected) ? FontWeight.bold : FontWeight.normal,
                        ),
                  ),
                  // selected: isSelected,
                  onTap: () => itemTap(item),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
