import 'dart:io';

import 'package:app_pemenangan_caleg/app/data/models/tps/tps_pendukung/response/list/list_pendukung_model.dart';
import 'package:app_pemenangan_caleg/app/data/models/tps/tps_pendukung/response/result_tps_pendukung_model.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/data_tps_korcab/data_tps_korcab_controller.dart';
import 'package:app_pemenangan_caleg/app/services/pendukung/pendukung_services.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/tps/tps_pendukung/response/data_tps_pendukung.dart';
import '../../../../data/models/users/result_users2_model/data_users2.dart';
import '../../../../shared/shared_method.dart';

class TPSPendukungKcbController extends GetxController {
  late int? tpsId;
  late DataTpsKorcabController _tpsKorcabC;
  late PendukungServices _pendukungS;

  final scrollC = ScrollController();
  final pagingC = PagingController<int, DataTpsPendukung>(firstPageKey: 1);
  final paging2C = PagingController<int, DataUsers2>(firstPageKey: 1);

  final logger = Logger();

  final isScrolling = false.obs;
  final isLongPressed = false.obs;

  final dataUsersSelected = <DataUsers2>[].obs;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<DataTpsKorcabController>()) {
      _tpsKorcabC = Get.find<DataTpsKorcabController>();
    }

    tpsId = Get.arguments as int;
    _pendukungS = PendukungServices();

    scrollC.addListener(listenScroll);
    debounce(
      isScrolling,
      (callback) => isScrolling.value = false,
      time: 1.seconds,
    );

    pagingC.addPageRequestListener((pageKey) => fetchPendukungByTPS(pageKey));
    paging2C.addPageRequestListener((pageKey) => fetchListPendukung(pageKey));
  }

  void listenScroll() {
    isScrolling.value =
        scrollC.position.userScrollDirection == ScrollDirection.forward ||
            scrollC.position.userScrollDirection == ScrollDirection.reverse;
  }

  Future<void> fetchPendukungByTPS(int page) async {
    logger.d('debug: tpsId = $tpsId');
    try {
      final response = await _pendukungS.fetchPendukungByTPS(
        page: page,
        tpsId: tpsId!,
      );
      if (response.statusCode == HttpStatus.ok) {
        final data = ResultTpsPendukungModel.fromJson(response.data);
        final isLastPage = page == data.lastPage;

        if (isLastPage) {
          pagingC.appendLastPage(data.data!);
        } else {
          pagingC.appendPage(data.data!, page + 1);
        }
      }
    } on DioException catch (e) {
      logger.e('Error: ${e.message}');
      pagingC.error = e;
    }
  }

  Future<void> fetchListPendukung(int page) async {
    try {
      final response = await _pendukungS.fetchListPendukung(page);
      if (response.statusCode == HttpStatus.ok) {
        final data = ListPendukungModel.fromJson(response.data);
        final isLastPage = page == data.result!.lastPage;

        if (isLastPage) {
          paging2C.appendLastPage(data.result!.data!);
        } else {
          paging2C.appendPage(data.result!.data!, page + 1);
        }
      }
    } on DioException catch (e) {
      logger.e('Error: ${e.message}');
      paging2C.error = e;
    }
  }

  void setDataUsersSelected(DataUsers2 item, bool isEdit) {
    if (isEdit) {
      dataUsersSelected.clear();
      dataUsersSelected.add(item);
    } else {
      if (dataUsersSelected.contains(item)) {
        dataUsersSelected.remove(item);
      } else {
        dataUsersSelected.add(item);
      }
    }
  }

  Future<void> addPendukung() async {
    if (dataUsersSelected.isNotEmpty) {
      final data =
          dataUsersSelected.map((element) => '${element.id}').join(',');
      final body = {
        'tps_id': tpsId,
        'save_pendukung': data,
      };

      try {
        final response = await _pendukungS.addPendukung(body);
        if (response.statusCode == HttpStatus.ok) {
          showSnackBar(
            content: const Text('Berhasil tambah pendukung'),
            backgroundColor: Colors.green,
          );
          Get.back();
          refreshPaging();
        } else {
          showSnackBar(
            content: const Text('Gagal tambah pendukung'),
            backgroundColor: Colors.red,
          );
        }
      } on DioException catch (e) {
        logger.e('Error: $e');
        showSnackBar(
          content: const Text('Gagal tambah pendukung'),
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> editPendukung({required int id, required int userId}) async {
    if (dataUsersSelected.isNotEmpty) {
      final body = {
        'users_id_select': userId,
      };

      try {
        final response = await _pendukungS.updatePendukung(id: id, model: body);
        if (response.statusCode == HttpStatus.ok) {
          showSnackBar(
            content: const Text('Update data pendukung'),
            backgroundColor: Colors.green,
          );
          Get.back();
          refreshPaging();
        } else {
          showSnackBar(
            content: const Text('Gagal update data pendukung'),
            backgroundColor: Colors.red,
          );
        }
      } on DioException catch (e) {
        logger.e('Error: $e');
        showSnackBar(
          content: const Text('Gagal update data pendukung'),
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> deletePendukung(int id) async {
    try {
      final response = await _pendukungS.deletePendukung(id);
      if (response.statusCode == HttpStatus.ok) {
        showSnackBar(
          content: const Text('Hapus pendukung berhasil'),
          backgroundColor: Colors.green,
        );
        Get.back();
        refreshPaging();
      } else {
        showSnackBar(
          content: const Text('Gagal hapus pendukung'),
          backgroundColor: Colors.red,
        );
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
      showSnackBar(
        content: const Text('Gagal hapus pendukung'),
        backgroundColor: Colors.red,
      );
    }
  }

  void refreshPaging() {
    _tpsKorcabC.pagingC.refresh();
    pagingC.refresh();
    paging2C.refresh();
  }

  void clearDataSelected() {
    dataUsersSelected.clear();
    isLongPressed.value = false;
  }

  // void moveToDetail(DataKorlap item) {
  //   Get.toNamed(
  //     Routes.DETAIL_KORLAP,
  //     arguments: item,
  //   );
  // }
}
