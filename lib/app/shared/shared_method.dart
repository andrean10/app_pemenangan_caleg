import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';

import '../data/models/region/data_region_model.dart';
import '../modules/manage_tps_korcab/views/custom_dropdown_paginated.dart';

void showSnackBar({
  required Widget content,
  SnackBarAction? action,
  Color? backgroundColor,
  Duration? duration = const Duration(seconds: 3),
  SnackBarBehavior? behavior = SnackBarBehavior.floating,
  DismissDirection dismissDirection = DismissDirection.down,
  bool showCloseIcon = false,
}) {
  ScaffoldMessenger.of(Get.context!).showSnackBar(
    SnackBar(
      content: content,
      action: action,
      backgroundColor: backgroundColor,
      duration: duration!,
      behavior: behavior,
      showCloseIcon: showCloseIcon,
      dismissDirection: dismissDirection,
    ),
  );
}

void showCustomBottomSheet({
  required BuildContext context,
  required PagingController<int, DataRegionModel> pagingController,
  required String title,
  required void Function(DataRegionModel) itemTap,
}) {
  showModalBottomSheet(
    context: context,
    isDismissible: false,
    useSafeArea: true,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (context) {
      return DraggableScrollableSheet(
        initialChildSize: 0.75,
        minChildSize: 0.5,
        expand: false,
        snap: true,
        snapSizes: const [0.5, 0.75, 1],
        builder: (context, scrollController) => CustomDropdownPaginated(
          scrollController,
          pagingController,
          title: title,
          itemTap: itemTap,
        ),
      );
    },
  );
}

String checkDayMessage() {
  final hoursNow = DateTime.now().hour;
  var messageDay = "";

  if (hoursNow >= 05 && hoursNow <= 10) {
    messageDay = 'Pagi';
  } else if (hoursNow >= 11 && hoursNow <= 14) {
    messageDay = 'Siang';
  } else if (hoursNow >= 15 && hoursNow <= 17) {
    messageDay = 'Sore';
  } else {
    messageDay = 'Malam';
  }
  return messageDay;
}

String capitalizeEachWords(String str) {
  return str
      .toLowerCase()
      .split(' ')
      .map((e) => e[0].toUpperCase() + e.substring(1))
      .join(' ');
}

String formatedDateToString({
  String? oldPattern,
  required String newPattern,
  required String? value,
}) {
  if (value == null) return '-';

  DateTime inputDate;

  if (oldPattern != null) {
    final inputFormat = DateFormat(oldPattern);
    inputDate = inputFormat.parse(value);
  } else {
    inputDate = DateTime.parse(value);
  }

  final outputFormat = DateFormat(newPattern, 'id_ID');
  return outputFormat.format(inputDate);
}

void detailPicture(
  BuildContext context,
  String url,
) {
  showDialog(
    context: context,
    builder: (context) => Dialog.fullscreen(
      backgroundColor: Colors.transparent,
      child: Stack(
        children: [
          InteractiveViewer(
            clipBehavior: Clip.none,
            maxScale: 5,
            child: Center(
              child: CachedNetworkImage(
                imageUrl: url,
                imageBuilder: (context, imageProvider) => Image(
                  image: imageProvider,
                ),
                errorWidget: (context, url, error) => Image.asset(
                  'assets/img/no_image.png',
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                IconButton(
                  onPressed: () => Get.back(),
                  icon: const Icon(
                    Icons.close_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}

Future<XFile?> selectImage() async {
  XFile? selectedImage = await ImagePicker().pickImage(
    source: ImageSource.gallery,
  );
  return selectedImage;
}

String generateRandomFileName() {
  var now = DateTime.now();
  var random = Random();
  var randomString = random.nextInt(10000).toString();
  return 'file_${now.year.toString().padLeft(4, '0')}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}_${now.hour.toString().padLeft(2, '0')}${now.minute.toString().padLeft(2, '0')}${now.second.toString().padLeft(2, '0')}_$randomString';
}
