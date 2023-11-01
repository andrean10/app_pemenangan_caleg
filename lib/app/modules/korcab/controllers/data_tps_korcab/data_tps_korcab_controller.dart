import 'package:get/get.dart';

import 'dart:io';

import 'package:app_pemenangan_caleg/app/data/models/korcab/tps/response/data_tps_korcab.dart';
import 'package:app_pemenangan_caleg/app/data/models/tps/tps_pendukung/response/result_tps_pendukung_model.dart';
import 'package:app_pemenangan_caleg/app/services/korcab/tps_korcab_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/korcab/tps/response/tps_korcab_model.dart';
import '../../../../routes/app_pages.dart';

class DataTpsKorcabController extends GetxController {
  late final TpsKorcabServices _tpsKorcabS;
  final pagingC = PagingController<int, DataTpsKorcab>(firstPageKey: 1);

  final logger = Logger();

  var isScrolling = false.obs;

  final scrollC = ScrollController();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _tpsKorcabS = TpsKorcabServices();

    scrollC.addListener(listenScroll);
    debounce(
      isScrolling,
      (callback) => isScrolling.value = false,
      time: 1.seconds,
    );

    pagingC.addPageRequestListener((pageKey) => fetchTPS(pageKey));
  }

  void listenScroll() {
    isScrolling.value =
        scrollC.position.userScrollDirection == ScrollDirection.forward ||
            scrollC.position.userScrollDirection == ScrollDirection.reverse;
  }

  void fetchTPS(int page) async {
    try {
      final response = await _tpsKorcabS.fetchTPS(page: page);
      if (response.statusCode == HttpStatus.ok) {
        final data = TpsKorcabModel.fromJson(response.data);
        final isLastPage = page == data.result!.lastPage;

        final newData = data.result!.data!.map((e) {
          fetchPendukung(e.id!).then(
            (value) => e.totalPendukung = value,
          );
          return e;
        }).toList();

        if (isLastPage) {
          pagingC.appendLastPage(newData);
        } else {
          pagingC.appendPage(newData, page + 1);
        }
      }
    } on DioException catch (e) {
      logger.e('Error: ${e.message}');
      pagingC.error = e;
    }
  }

  Future<int?> fetchPendukung(int id) async {
    try {
      final response = await _tpsKorcabS.fetchPendukung(id);
      if (response.statusCode == HttpStatus.ok) {
        final data = ResultTpsPendukungModel.fromJson(response.data);
        return data.total;
      }
    } on DioException catch (e) {
      logger.e('Error: ${e.message}');
    }
    return null;
  }

  void manageTPS({
    isEdit = false,
    DataTpsKorcab? data,
  }) {
    if (isEdit) {
      Get.toNamed(
        Routes.MANAGE_TPS_KORCAB,
        arguments: data,
      );
    } else {
      Get.toNamed(Routes.MANAGE_TPS_KORCAB);
    }
  }

  void moveToKorlap(DataTpsKorcab item) => Get.toNamed(
        '${Get.currentRoute}${Routes.TPS_KORLAP}',
        arguments: item,
      );

  void moveToPendukung(int tpsId) => Get.toNamed(
        '${Get.currentRoute}${Routes.TPS_PENDUKUNG}',
        arguments: tpsId,
      );
}
