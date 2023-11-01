import 'dart:io';

import 'package:app_pemenangan_caleg/app/data/models/korcab/tps/response/data_tps_korcab.dart';
import 'package:app_pemenangan_caleg/app/data/models/tps/tps_korlap/response/data_tps_korlap.dart';
import 'package:app_pemenangan_caleg/app/data/models/tps/tps_korlap/response/tps_korlap_model.dart';
import 'package:app_pemenangan_caleg/app/data/models/users/result_users2_model/data_users2.dart';
import 'package:app_pemenangan_caleg/app/services/korlap/korlap_services.dart';
import 'package:app_pemenangan_caleg/app/shared/shared_method.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';

import '../../../../data/models/users/result_users2_model/users2_model.dart';
import '../../../../routes/app_pages.dart';

class TPSKorlapController extends GetxController {
  late DataTpsKorcab args;
  late KorlapServices _tpsKorlapS;

  final scrollC = ScrollController();
  final pagingC = PagingController<int, DataTpsKorlap>(firstPageKey: 1);
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
    args = Get.arguments as DataTpsKorcab;
    _tpsKorlapS = KorlapServices();

    scrollC.addListener(listenScroll);
    debounce(
      isScrolling,
      (callback) => isScrolling.value = false,
      time: 1.seconds,
    );

    pagingC.addPageRequestListener((pageKey) => fetchTPSKorlap(pageKey));
    paging2C.addPageRequestListener((pageKey) => fetchListTPSKorlap(pageKey));
  }

  void listenScroll() {
    isScrolling.value =
        scrollC.position.userScrollDirection == ScrollDirection.forward ||
            scrollC.position.userScrollDirection == ScrollDirection.reverse;
  }

  Future<void> fetchTPSKorlap(int page) async {
    try {
      final response = await _tpsKorlapS.fetchTPSKorlap(
        page: page,
        tpsId: args.id!,
      );
      if (response.statusCode == HttpStatus.ok) {
        final data = KorlapModel.fromJson(response.data);
        final isLastPage = page == data.result!.lastPage;

        if (isLastPage) {
          pagingC.appendLastPage(data.result!.data!);
        } else {
          pagingC.appendPage(data.result!.data!, page + 1);
        }
      }
    } on DioException catch (e) {
      logger.e('Error: ${e.message}');
      pagingC.error = e;
    }
  }

  Future<void> fetchListTPSKorlap(int page) async {
    try {
      final response = await _tpsKorlapS.fetchListTPSKorlap(page: page);
      if (response.statusCode == HttpStatus.ok) {
        final data = Users2Model.fromJson(response.data);
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

  Future<void> addCo(int id) async {
    if (dataUsersSelected.isNotEmpty) {
      final data =
          dataUsersSelected.map((element) => '${element.id}').join(',');
      final body = {
        'tps_id': id,
        'save_koordinator': data,
      };

      try {
        final response = await _tpsKorlapS.addTPSKorlap(body);
        if (response.statusCode == HttpStatus.ok) {
          showSnackBar(
            content: const Text('Berhasil tambah koordinator'),
            backgroundColor: Colors.green,
          );
          Get.back();
          refreshPaging();
        } else {
          showSnackBar(
            content: const Text('Gagal tambah koordinator'),
            backgroundColor: Colors.red,
          );
        }
      } on DioException catch (e) {
        logger.e('Error: $e');
        showSnackBar(
          content: const Text('Gagal tambah koordinator'),
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> editCo(int id, int userId) async {
    if (dataUsersSelected.isNotEmpty) {
      final body = {
        'users_id_select': userId,
      };

      try {
        final response = await _tpsKorlapS.updateTPSKorlap(id: id, model: body);
        if (response.statusCode == HttpStatus.ok) {
          showSnackBar(
            content: const Text('Update data koordinator'),
            backgroundColor: Colors.green,
          );
          Get.back();
          refreshPaging();
        } else {
          showSnackBar(
            content: const Text('Gagal update data koordinator'),
            backgroundColor: Colors.red,
          );
        }
      } on DioException catch (e) {
        logger.e('Error: $e');
        showSnackBar(
          content: const Text('Gagal update data koordinator'),
          backgroundColor: Colors.red,
        );
      }
    }
  }

  Future<void> deleteCo(int id) async {
    try {
      final response = await _tpsKorlapS.deleteTPSKorlap(id);
      if (response.statusCode == HttpStatus.ok) {
        showSnackBar(
          content: const Text('Hapus koordinator berhasil'),
          backgroundColor: Colors.green,
        );
        Get.back();
        refreshPaging();
      } else {
        showSnackBar(
          content: const Text('Gagal hapus koordinator'),
          backgroundColor: Colors.red,
        );
      }
    } on DioException catch (e) {
      logger.e('Error: $e');
      showSnackBar(
        content: const Text('Gagal hapus koordinator'),
        backgroundColor: Colors.red,
      );
    }
  }

  void refreshPaging() {
    pagingC.refresh();
    paging2C.refresh();
  }

  void clearDataSelected() {
    dataUsersSelected.clear();
    isLongPressed.value = false;
  }

  void moveToDetail(DataTpsKorlap item) {
    Get.toNamed(
      Routes.DETAIL_KORLAP,
      arguments: item,
    );
  }
}
