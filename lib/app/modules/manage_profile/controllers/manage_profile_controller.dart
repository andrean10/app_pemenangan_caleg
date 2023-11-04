import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';
import 'package:dio/dio.dart' as dio;

import '../../../data/models/jabatan/response/jabatan_model.dart';
import '../../../data/models/jabatan/response/result_jabatan_model.dart';
import '../../../data/models/users/request/request_data_users_model.dart';
import '../../../data/models/users/users_model.dart';
import '../../../services/profile/profile_services.dart';
import '../../../shared/shared_method.dart';
import '../../detail_profile/controllers/detail_profile_controller.dart';

enum JenisKelamin { L, P }

class ManageProfileController extends GetxController {
  late UsersModel? args;
  late ProfileServices _profileS;
  late DetailProfileKorcabController _detailProfileKorcabC;

  final formKey = GlobalKey<FormState>();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();
  final confirmPasswordC = TextEditingController();
  final noIndukC = TextEditingController();
  final namaC = TextEditingController();
  final noHandphoneC = TextEditingController();
  final emailC = TextEditingController();
  final alamatC = TextEditingController();

  final selectedItemJurusan = Rxn<ResultJabatanModel>();

  final username = ''.obs;
  final password = ''.obs;
  final confirmPassword = ''.obs;
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
    args = Get.arguments as UsersModel?;
    _profileS = ProfileServices();

    if (Get.isRegistered<DetailProfileKorcabController>()) {
      _detailProfileKorcabC = Get.find<DetailProfileKorcabController>();
    }

    usernameC.addListener(setUsername);
    passwordC.addListener(setPassword);
    confirmPasswordC.addListener(setConfirmPassword);
    noIndukC.addListener(setNoInduk);
    namaC.addListener(setNama);
    noHandphoneC.addListener(setNoHandphone);
    emailC.addListener(setEmail);
    alamatC.addListener(setAlamat);
  }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  Future<void> _initData() async {
    if (args != null) {
      usernameC.text = args!.username.toString();
      noIndukC.text = args!.profile!.nikProfile!.toString();
      namaC.text = args!.profile!.namaProfile.toString();
      noHandphoneC.text = args!.profile!.nohpProfile.toString();
      emailC.text = args!.profile!.emailProfile.toString();
      alamatC.text = args!.profile!.alamatProfile.toString();
      jenisKelamin.value = args!.profile!.jenisKelaminProfile == 'L'
          ? JenisKelamin.L
          : JenisKelamin.P;
      isAktif.value = args!.isAktif == 1 ? true : false;
      image.value = args!.profile!.gambarProfile.toString();

      selectedItemJurusan.value = await filterJabatanById();
    }
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
      } else if (isConfirmPassword && value != password.value) {
        return 'Password tidak sama!';
      } else if (!GetUtils.isPhoneNumber(value) && isNumberPhone) {
        return '$titleField tidak valid!';
      } else if (!GetUtils.isNumericOnly(value) && isNumber) {
        return '$titleField harus berupa angka!';
      }
    }
    return null;
  }

  void setUsername() => username.value = usernameC.text;

  void setPassword() => password.value = passwordC.text;

  void setConfirmPassword() => confirmPassword.value = confirmPasswordC.text;

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
      updateProfile();
    }
  }

  Future<List<ResultJabatanModel>> fetchJabatan() async {
    try {
      final response = await _profileS.fetchJabatan();
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

  Future<ResultJabatanModel> filterJabatanById() {
    return fetchJabatan().then(
      (value) => value.firstWhere(
        (element) => element.id == args?.profile?.jabatanId,
      ),
    );
  }

  Future<void> updateProfile() async {
    var newData = RequestDataUsersModel(
      roleId: args!.roles?[0].id.toString(),
      oldPassword: args!.password.toString(),
      username: username.value,
      password: password.value,
      confirmPassword: confirmPassword.value,
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
      final response = await _profileS.updateProfile(
        id: args!.id!,
        model: formData,
      );

      if (response.statusCode == HttpStatus.ok) {
        isLoading.value = false;
        showSnackBar(
          content: const Text('Berhasil mengubah profile'),
          backgroundColor: Colors.green,
        );
        _detailProfileKorcabC.fetchProfile();
        Get.back();
      } else {
        isLoading.value = false;
        showSnackBar(
          content: const Text('Gagal mengubah profile'),
          backgroundColor: Colors.red,
        );
      }
    } on dio.DioException catch (e) {
      logger.e('Error: ${e.message}');
      isLoading.value = false;
      showSnackBar(
        content: const Text('Gagal mengubah profile'),
        backgroundColor: Colors.red,
      );
    }
  }
}
