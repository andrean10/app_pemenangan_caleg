import 'dart:io';

import 'package:app_pemenangan_caleg/app/modules/korlap/controllers/pendukung/pendukung_klp_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

import '../../../data/models/jabatan/response/jabatan_model.dart';
import '../../../data/models/jabatan/response/result_jabatan_model.dart';
import '../../../data/models/users/request/request_data_users_model.dart';
import '../../../services/korlap/korlap_services.dart';
import '../../../shared/shared_method.dart';
import 'package:dio/dio.dart' as dio;

enum JenisKelamin { L, P }

class ManagePendukungByKorlapController extends GetxController {
  late KorlapServices _korlapS;
  late PendukungKlpController _korlapKlpC;

  final formKey = GlobalKey<FormState>();
  final noIndukC = TextEditingController();
  final namaC = TextEditingController();
  final noHandphoneC = TextEditingController();
  final emailC = TextEditingController();
  final alamatC = TextEditingController();

  final selectedItemJurusan = Rxn<ResultJabatanModel>();

  final noInduk = 0.obs;
  final nama = ''.obs;
  final jenisKelamin = JenisKelamin.L.obs;
  final noHandphone = ''.obs;
  final email = ''.obs;
  final isAktif = false.obs;
  final alamat = ''.obs;

  final image = RxnString();
  final selectedImage = Rxn<XFile>();

  final isVisiblePassword = false.obs;
  final isVisibleConfirmPassword = false.obs;
  final isLoading = false.obs;

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    _korlapS = KorlapServices();
    if (Get.isRegistered<PendukungKlpController>()) {
      _korlapKlpC = Get.find<PendukungKlpController>();
    }

    noIndukC.addListener(setNoInduk);
    namaC.addListener(setNama);
    noHandphoneC.addListener(setNoHandphone);
    emailC.addListener(setEmail);
    alamatC.addListener(setAlamat);
  }

  String? validateForm({
    required String? value,
    required String titleField,
    bool isEmail = false,
    bool isConfirmPassword = false,
    bool isEdit = false,
    bool isNumberPhone = false,
    bool isNumber = false,
  }) {
    if (value != null) {
      if (value.isEmpty) {
        if (!isEdit) {
          return '$titleField harus di isi!';
        }
      } else if (!GetUtils.isEmail(value) && isEmail) {
        return '$titleField tidak valid!';
      } else if (!GetUtils.isPhoneNumber(value) && isNumberPhone) {
        return '$titleField tidak valid!';
      } else if (!GetUtils.isNumericOnly(value) && isNumber) {
        return '$titleField harus berupa angka!';
      }
    }
    return null;
  }

  void setNoInduk() => noInduk.value = int.parse(noIndukC.text);

  void setNama() => nama.value = namaC.text;

  void setJenisKelamin(JenisKelamin? value) => jenisKelamin.value = value!;

  void setNoHandphone() => noHandphone.value = noHandphoneC.text;

  void setEmail() => email.value = emailC.text;

  void setAlamat() => alamat.value = alamatC.text;

  void setJabatan(ResultJabatanModel? value) =>
      selectedItemJurusan.value = value;

  Future<void> pickImage() async {
    final image = await selectImage();
    if (image != null) {
      selectedImage.value = image;
    }
  }

  void setIsAktif(bool? value) => isAktif.value = value!;

  void confirm() {
    if (formKey.currentState!.validate()) {
      isLoading.value = true;
      addPendukung();
    }
  }

  Future<List<ResultJabatanModel>> fetchJabatan() async {
    try {
      final response = await _korlapS.fetchJabatan();
      if (response.statusCode == HttpStatus.ok) {
        final data = JabatanModel.fromJson(response.data);

        if (data.result != null) {
          return data.result!;
        }
      }
    } on dio.DioException catch (e) {
      logger.e('Error: $e');
    }

    return [];
  }

  Future<void> addPendukung() async {
    var newData = RequestDataUsersModel(
      roleId: 'pendukung',
      emailProfile: email.value,
      isAktif: isAktif.value ? 1 : 0,
      nikProfile: noInduk.value.toString(),
      jabatanId: selectedItemJurusan.value!.id,
      namaProfile: nama.value,
      alamatProfile: alamat.value,
      nohpProfile: noHandphone.value,
      jenisKelaminProfile: jenisKelamin.value.name,
    );

    if (selectedImage.value != null) {
      newData = newData.copyWith(
        gambarProfile: await dio.MultipartFile.fromFile(
          selectedImage.value!.path,
          filename: selectedImage.value!.name,
        ),
      );
    }

    final formData = dio.FormData.fromMap(newData.toJson());

    try {
      final response = await _korlapS.addDataKorlap(formData);

      if (response.statusCode == HttpStatus.created) {
        isLoading.value = false;
        showSnackBar(
          content: const Text('Berhasil menambahkan data pendukung'),
          backgroundColor: Colors.green,
        );
        Get.back();
        _korlapKlpC.pagingC.refresh();
      } else {
        isLoading.value = false;
        showSnackBar(
          content: const Text('Gagal menambahkan data pendukung'),
          backgroundColor: Colors.red,
        );
      }
    } on dio.DioException catch (e) {
      logger.e('Error: ${e.message}');
      isLoading.value = false;
      showSnackBar(
        content: const Text('Gagal menambahkan data pendukung'),
        backgroundColor: Colors.red,
      );
    }
  }
}
