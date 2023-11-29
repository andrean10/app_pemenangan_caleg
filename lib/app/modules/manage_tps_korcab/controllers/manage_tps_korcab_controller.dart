import 'dart:io';

import 'package:app_pemenangan_caleg/app/data/models/region/data_region_model.dart';
import 'package:app_pemenangan_caleg/app/modules/korcab/controllers/data_tps_korcab/data_tps_korcab_controller.dart';
import 'package:app_pemenangan_caleg/app/services/korcab/tps_korcab_services.dart';
import 'package:app_pemenangan_caleg/app/services/profile/profile_services.dart';
import 'package:app_pemenangan_caleg/app/shared/shared_method.dart';
import 'package:app_pemenangan_caleg/app/utils/constants_lottie.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:logger/logger.dart';
import 'package:lottie/lottie.dart';

import '../../../data/models/korcab/tps/response/data_tps_korcab.dart';
import '../../../data/models/region/province/region_model.dart';
import '../../../data/models/users/response_users_model.dart';
import '../../init/controller/init_controller.dart';

class ManageDataTpsKorcabController extends GetxController {
  // late final InitController _initC;
  late final DataTpsKorcabController _tpsKorcabC;
  late final TpsKorcabServices _tpsKorcabS;
  late final ProfileServices _profileS;
  late DataTpsKorcab? args;

  // final pagingProvinceC =
  //     PagingController<int, DataRegionModel>(firstPageKey: 1);
  // final pagingRegenciesC =
  //     PagingController<int, DataRegionModel>(firstPageKey: 1);
  // final pagingDistrictC =
  //     PagingController<int, DataRegionModel>(firstPageKey: 1);
  final pagingVillagesC =
      PagingController<int, DataRegionModel>(firstPageKey: 1);

  // final selectedItemProvince = Rxn<DataRegionModel>();
  // final selectedItemRegencies = Rxn<DataRegionModel>();
  // final selectedItemDistrict = Rxn<DataRegionModel>();
  final selectedItemVillages = Rxn<DataRegionModel>();

  // var currentLengthProvince = 0;
  // var currentLengthRegencies = 0;
  // var currentLengthDistrict = 0;
  var currentLengthVillages = 0;

  var title = '';

  final formKey = GlobalKey<FormState>();
  // final provinceC = TextEditingController();
  // final regenciesC = TextEditingController();
  // final districtsC = TextEditingController();
  final villagesC = TextEditingController();
  final tpsNameC = TextEditingController();
  final tpsAddressC = TextEditingController();
  final tpsMinCoC = TextEditingController();
  final tpsSupportC = TextEditingController();
  final tpsCoQuotaC = TextEditingController();

  // final List<DataRegionModel> currentDataProvince = [];
  // final List<DataRegionModel> currentDataRegencies = [];
  // final List<DataRegionModel> currentDataDistricts = [];
  final List<DataRegionModel> currentDataVillages = [];

  var provincesId = 0;
  var regenciesId = 0;
  var districtsId = 0;
  final tpsName = ''.obs;
  final tpsSupport = 0.obs;
  final tpsMinCo = 0.obs;
  final tpsCoQuota = 0.obs;
  final tpsAddress = ''.obs;

  final isLoading = false.obs;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  void _init() {
    // if (Get.isRegistered<InitController>()) {
    //   _initC = Get.find<InitController>();
    // }

    if (Get.isRegistered<DataTpsKorcabController>()) {
      _tpsKorcabC = Get.find<DataTpsKorcabController>();
    }

    args = Get.arguments as DataTpsKorcab?;

    title = (args != null) ? 'Edit Form TPS' : 'Tambah Form TPS';

    _tpsKorcabS = TpsKorcabServices();
    _profileS = ProfileServices();
    // pagingProvinceC.addPageRequestListener((pageKey) => fetchProvince(pageKey));
    // pagingRegenciesC
    //     .addPageRequestListener((pageKey) => fetchRegencies(page: pageKey));
    // pagingDistrictC.addPageRequestListener((pageKey) => fetchDistrict(pageKey));
    pagingVillagesC.addPageRequestListener((pageKey) => fetchVillages(pageKey));

    tpsNameC.addListener(setNameTPS);
    tpsSupportC.addListener(setSupport);
    tpsMinCoC.addListener(setMinCo);
    tpsCoQuotaC.addListener(setCoQuota);
    tpsAddressC.addListener(setAddress);
  }

  Future<void> _initData() async {
    await fetchProfile();

    if (args != null) {
      tpsNameC.text = args!.namaTps.toString();
      tpsSupportC.text = args!.pendukungTps.toString();
      tpsMinCoC.text = args!.minimalTps.toString();
      tpsCoQuotaC.text = args!.kuotaTps.toString();
      tpsAddressC.text = args!.alamatTps.toString();

      showDialog(
        context: Get.context!,
        builder: (context) => Dialog(
          child: LottieBuilder.asset(ConstantsLottie.loading),
        ),
        barrierDismissible: false,
      );

      try {
        // await fetchAllProvince(args!);
        // await fetchAllRegencies(args!);
        // await fetchAllDistricts(args!);
        await fetchAllVillages(districtsId, args!.villagesId!);
      } on dio.DioException catch (e) {
        logger.e('Error: ${e.message}');
      } finally {
        Get.back();
      }
    }
  }

  String? validateForm({
    required String? value,
    required String titleField,
    bool isNumber = false,
    bool isMinCo = false,
  }) {
    if (value != null) {
      if (value.isEmpty) {
        return '$titleField harus di isi!';
      } else if (!GetUtils.isNumericOnly(value) && isNumber) {
        return '$titleField harus berupa angka!';
      } else if (isMinCo && tpsMinCo.value > tpsCoQuota.value) {
        return 'Minimal Koordinator tidak boleh lebih besar dari Kuota Koordinator!';
      }
    }

    return null;
  }

  // void setProvince(DataRegionModel data) {
  //   if (data != selectedItemProvince.value) {
  //     clearFieldRegion(isProvince: true);
  //   }

  //   provinceC.text = capitalizeEachWords(data.value!);
  //   selectedItemProvince.value = data;
  // }

  // void setRegencies(DataRegionModel data) {
  //   if (data != selectedItemRegencies.value) {
  //     clearFieldRegion(isRegencies: true);
  //   }

  //   regenciesC.text = capitalizeEachWords(data.value!);
  //   selectedItemRegencies.value = data;
  // }

  // void setDistrict(DataRegionModel data) {
  //   if (data != selectedItemDistrict.value) {
  //     clearFieldRegion(isDistrict: true);
  //   }

  //   districtsC.text = capitalizeEachWords(data.value!);
  //   selectedItemDistrict.value = data;
  // }

  void setVillages(DataRegionModel data) {
    villagesC.text = capitalizeEachWords(data.value!);
    selectedItemVillages.value = data;
  }

  void clearFieldRegion({
    bool isProvince = false,
    bool isRegencies = false,
    bool isDistrict = false,
  }) {
    if (isProvince) {
      // regenciesC.clear();
      // districtsC.clear();
      villagesC.clear();

      // currentLengthRegencies = 0;
      // currentLengthDistrict = 0;
      currentLengthVillages = 0;

      // pagingRegenciesC.refresh();
      // pagingDistrictC.refresh();
      pagingVillagesC.refresh();
      return;
    }

    if (isRegencies) {
      // districtsC.clear();
      villagesC.clear();

      // currentLengthDistrict = 0;
      currentLengthVillages = 0;

      // pagingDistrictC.refresh();
      pagingVillagesC.refresh();
      return;
    }

    if (isDistrict) {
      villagesC.clear();
      currentLengthVillages = 0;
      pagingVillagesC.refresh();
      return;
    }
  }

  void setNameTPS() => tpsName.value = tpsNameC.text;

  void setSupport() => tpsSupport.value = int.parse(tpsSupportC.text);

  void setMinCo() => tpsMinCo.value = int.parse(tpsMinCoC.text);

  void setCoQuota() => tpsCoQuota.value = int.parse(tpsCoQuotaC.text);

  void setAddress() => tpsAddress.value = tpsAddressC.text;

  void confirm() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;

      if (args != null) {
        updateTps();
      } else {
        addTPS();
      }
    }
  }

  Future<void> fetchProfile() async {
    try {
      final response = await _profileS.fetchProfile();
      if (response.statusCode == HttpStatus.ok) {
        final data = ResponseUsersModel.fromJson(response.data);
        provincesId = data.result?.provincesId ?? 0;
        regenciesId = data.result?.regenciesId ?? 0;
        districtsId = data.result?.districtsId ?? 0;
      }
    } catch (e) {
      logger.e('Error: $e');
    }
  }

  // Future<void> fetchAllProvince(DataTpsKorcab args, {int page = 1}) async {
  //   try {
  //     final response = await _tpsKorcabS.fetchProvince(page: page);

  //     if (response.statusCode == HttpStatus.ok) {
  //       final region = RegionModel.fromJson(response.data);
  //       if (region.result != null) {
  //         final result = region.result;
  //         currentDataProvince.addAll(result!.results!.map((e) => e));

  //         final dataFilter = currentDataProvince
  //             .firstWhere((element) => element.id == args.provincesId);

  //         if (dataFilter.value != null) {
  //           setProvince(dataFilter);
  //         } else {
  //           fetchAllProvince(args, page: page + 1);
  //         }
  //       }
  //     }
  //   } on dio.DioException catch (e) {
  //     logger.e('Error: ${e.message}');
  //   }
  // }

  // Future<void> fetchAllRegencies(DataTpsKorcab args, {int page = 1}) async {
  //   try {
  //     final response = await _tpsKorcabS.fetchRegencies(
  //       page: page,
  //       provinceId: args.provincesId!,
  //     );

  //     if (response.statusCode == HttpStatus.ok) {
  //       final region = RegionModel.fromJson(response.data);
  //       if (region.result != null) {
  //         final result = region.result;
  //         currentDataRegencies.addAll(result!.results!.map((e) => e));

  //         final dataFilter = currentDataRegencies
  //             .firstWhere((element) => element.id == args.regenciesId);

  //         if (dataFilter.value != null) {
  //           setRegencies(dataFilter);
  //         } else {
  //           fetchAllRegencies(args, page: page + 1);
  //         }
  //       }
  //     }
  //   } on dio.DioException catch (e) {
  //     logger.e('Error: ${e.message}');
  //   }
  // }

  // Future<void> fetchAllDistricts(DataTpsKorcab args, {int page = 1}) async {
  //   try {
  //     final response = await _tpsKorcabS.fetchDistrict(
  //       page: page,
  //       regenciesId: args.regenciesId!,
  //     );

  //     if (response.statusCode == HttpStatus.ok) {
  //       final region = RegionModel.fromJson(response.data);
  //       if (region.result != null) {
  //         final result = region.result;
  //         currentDataDistricts.addAll(result!.results!.map((e) => e));

  //         final dataFilter = currentDataDistricts
  //             .firstWhere((element) => element.id == args.districtsId);

  //         if (dataFilter.value != null) {
  //           setDistrict(dataFilter);
  //         } else {
  //           fetchAllDistricts(args, page: page + 1);
  //         }
  //       }
  //     }
  //   } on dio.DioException catch (e) {
  //     logger.e('Error: ${e.message}');
  //   }
  // }

  Future<void> fetchAllVillages(
    int districtsId,
    int villagesId, {
    int page = 1,
  }) async {
    try {
      final response = await _tpsKorcabS.fetchVillages(
        page: page,
        distrcitId: districtsId,
      );

      if (response.statusCode == HttpStatus.ok) {
        final region = RegionModel.fromJson(response.data);
        if (region.result != null) {
          final result = region.result;
          currentDataVillages.addAll(result!.results!.map((e) => e));

          final dataFilter = currentDataVillages
              .firstWhere((element) => element.id == villagesId);

          if (dataFilter.value != null) {
            setVillages(dataFilter);
          } else {
            fetchAllVillages(
              districtsId,
              villagesId,
              page: page + 1,
            );
          }
        }
      }
    } on dio.DioException catch (e) {
      logger.e('Error: ${e.message}');
    }
  }

  // void fetchProvince(int page) async {
  //   try {
  //     final response = await _tpsKorcabS.fetchProvince(page: page);
  //     if (response.statusCode == HttpStatus.ok) {
  //       final region = RegionModel.fromJson(response.data);
  //       final result = region.result;
  //       currentLengthProvince += result!.results!.length;
  //       final isLastPage = currentLengthProvince == result.countFiltered!;

  //       if (isLastPage) {
  //         pagingProvinceC.appendLastPage(result.results!);
  //       } else {
  //         pagingProvinceC.appendPage(result.results!, page + 1);
  //       }
  //     } else {
  //       pagingProvinceC.error = response.statusMessage;
  //     }
  //   } on dio.DioException catch (e) {
  //     logger.e('Error: ${e.message}');
  //     pagingProvinceC.error = e;
  //   }
  // }

  // void fetchRegencies({required int page}) async {
  //   try {
  //     final response = await _tpsKorcabS.fetchRegencies(
  //       page: page,
  //       provinceId: selectedItemProvince.value!.id!,
  //     );

  //     if (response.statusCode == HttpStatus.ok) {
  //       final region = RegionModel.fromJson(response.data);
  //       final result = region.result;
  //       currentLengthRegencies += result!.results!.length;
  //       final isLastPage = currentLengthRegencies == result.countFiltered!;

  //       if (isLastPage) {
  //         pagingRegenciesC.appendLastPage(result.results!);
  //       } else {
  //         pagingRegenciesC.appendPage(result.results!, page + 1);
  //       }
  //     } else {
  //       pagingRegenciesC.error = response.statusMessage;
  //     }
  //   } on dio.DioException catch (e) {
  //     logger.e('Error: ${e.message}');
  //     pagingRegenciesC.error = e;
  //   }
  // }

  // void fetchDistrict(int page) async {
  //   try {
  //     final response = await _tpsKorcabS.fetchDistrict(
  //       page: page,
  //       regenciesId: selectedItemRegencies.value!.id!,
  //     );
  //     if (response.statusCode == HttpStatus.ok) {
  //       final region = RegionModel.fromJson(response.data);
  //       final result = region.result;
  //       currentLengthDistrict += result!.results!.length;
  //       final isLastPage = currentLengthDistrict == result.countFiltered!;

  //       if (isLastPage) {
  //         pagingDistrictC.appendLastPage(result.results!);
  //       } else {
  //         pagingDistrictC.appendPage(result.results!, page + 1);
  //       }
  //     } else {
  //       pagingDistrictC.error = response.statusMessage;
  //     }
  //   } on dio.DioException catch (e) {
  //     logger.e('Error: ${e.message}');
  //     pagingDistrictC.error = e;
  //   }
  // }

  void fetchVillages(int page) async {
    try {
      final response = await _tpsKorcabS.fetchVillages(
        page: page,
        distrcitId: districtsId,
      );
      if (response.statusCode == HttpStatus.ok) {
        final region = RegionModel.fromJson(response.data);
        final result = region.result;
        currentLengthVillages += result!.results!.length;
        final isLastPage = currentLengthVillages == result.countFiltered!;

        if (isLastPage) {
          pagingVillagesC.appendLastPage(result.results!);
        } else {
          pagingVillagesC.appendPage(result.results!, page + 1);
        }
      } else {
        pagingVillagesC.error = response.statusMessage;
      }
    } on dio.DioException catch (e) {
      logger.e('Error: ${e.message}');
      pagingVillagesC.error = e;
    }
  }

  Future<void> addTPS() async {
    final model = DataTpsKorcab(
      provincesId: provincesId,
      regenciesId: regenciesId,
      districtsId: districtsId,
      villagesId: selectedItemVillages.value?.id,
      namaTps: tpsName.value,
      alamatTps: tpsAddress.value,
      pendukungTps: tpsSupport.value,
      minimalTps: tpsMinCo.value,
      kuotaTps: tpsCoQuota.value,
    );

    try {
      final response = await _tpsKorcabS.addTPS(model);

      if (response.statusCode == HttpStatus.created) {
        actionSuccess('Berhasil menambahkan data TPS');
      } else {
        isLoading.value = false;
        showSnackBar(
          content: const Text('Gagal menambahkan data TPS'),
          backgroundColor: Get.theme.colorScheme.error,
        );
      }
    } on dio.DioException catch (e) {
      logger.e('Error: ${e.message}');
      isLoading.value = false;
      showSnackBar(
        content: const Text('Gagal menambahkan data TPS'),
        backgroundColor: Get.theme.colorScheme.error,
      );
    }
  }

  Future<void> updateTps() async {
    final model = DataTpsKorcab(
      // provincesId: selectedItemProvince.value?.id,
      // regenciesId: selectedItemRegencies.value?.id,
      // districtsId: selectedItemDistrict.value?.id,
      villagesId: selectedItemVillages.value?.id,
      namaTps: tpsName.value,
      alamatTps: tpsAddress.value,
      pendukungTps: tpsSupport.value,
      minimalTps: tpsMinCo.value,
      kuotaTps: tpsCoQuota.value,
    );

    try {
      final response = await _tpsKorcabS.updateTPS(id: args!.id!, model: model);

      if (response.statusCode == HttpStatus.ok) {
        actionSuccess('Berhasil mengubah data TPS');
      } else {
        showSnackBar(
          content: const Text('Gagal mengubah data TPS'),
          backgroundColor: Get.theme.colorScheme.error,
        );
      }
    } on dio.DioException catch (e) {
      logger.e('Error: ${e.message}');
      showSnackBar(
        content: const Text('Gagal mengubah data TPS'),
        backgroundColor: Get.theme.colorScheme.error,
      );
    }
  }

  Future<void> deleteTps() async {
    try {
      final response = await _tpsKorcabS.deleteTPS(args!.id!);

      if (response.statusCode == HttpStatus.ok) {
        Get.back();
        actionSuccess('Berhasil menghapus data TPS');
      } else {
        showSnackBar(
          content: const Text('Gagal menghapus data TPS'),
          backgroundColor: Get.theme.colorScheme.error,
        );
      }
    } on dio.DioException catch (e) {
      logger.e('Error: ${e.message}');
      showSnackBar(
        content: const Text('Gagal menghapus data TPS'),
        backgroundColor: Get.theme.colorScheme.error,
      );
    }
  }

  void actionSuccess(String message) {
    showSnackBar(
      content: Text(message),
      backgroundColor: Colors.green,
    );
    _tpsKorcabC.pagingC.refresh();
    Get.back();
  }
}
