import 'dart:io';

import 'package:app_pemenangan_caleg/app/data/models/korlap/pendukung/response/data_pendukung_korlap.dart';
import 'package:app_pemenangan_caleg/app/data/models/korlap/pendukung/response/pendukung_korlap_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../routes/app_pages.dart';
import '../../../../services/pendukung/pendukung_services.dart';

class PendukungKlpController extends GetxController {
  // late InitController _initC;
  late PendukungServices _pendukungS;

  final scrollC = ScrollController();
  final pagingC = PagingController<int, DataPendukungKorlap>(firstPageKey: 1);

  final isScrolling = false.obs;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    // if (Get.isRegistered<InitController>()) {
    //   _initC = Get.find<InitController>();
    // }

    _pendukungS = PendukungServices();

    scrollC.addListener(listenScroll);
    debounce(
      isScrolling,
      (callback) => isScrolling.value = false,
      time: 1.seconds,
    );

    pagingC
        .addPageRequestListener((pageKey) => fetchPendukungByKorlap(pageKey));
  }

  void listenScroll() {
    isScrolling.value =
        scrollC.position.userScrollDirection == ScrollDirection.forward ||
            scrollC.position.userScrollDirection == ScrollDirection.reverse;
  }

  Future<void> fetchPendukungByKorlap(int page) async {
    try {
      final response = await _pendukungS.fetchPendukungByKorlap(page: page);
      if (response.statusCode == HttpStatus.ok) {
        final data = PendukungKorlapModel.fromJson(response.data);
        final result = data.result;
        final isLastPage = page == result?.lastPage;

        if (isLastPage) {
          pagingC.appendLastPage(result!.data!);
        } else {
          pagingC.appendPage(result!.data!, page + 1);
        }
      }
    } on DioException catch (e) {
      logger.e('Error: ${e.message}');
      pagingC.error = e;
    }
  }

  void moveToDetail(DataPendukungKorlap item) {
    Get.toNamed(
      '${Get.currentRoute}${Routes.DETAIL_PENDUKUNG_KLP}',
      arguments: item,
    );
  }
}
