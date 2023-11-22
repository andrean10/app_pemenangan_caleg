import 'dart:io';
import 'package:app_pemenangan_caleg/app/data/db/shared_preferences/user_session.dart';
import 'package:app_pemenangan_caleg/app/data/models/auth/login/response/response_login_model.dart';
import 'package:app_pemenangan_caleg/app/services/auth/auth_services.dart';
import 'package:app_pemenangan_caleg/app/shared/shared_method.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../data/models/auth/login/request/request_login_model.dart';
import '../../../routes/app_pages.dart';
import '../../init/controller/init_controller.dart';

class LoginController extends GetxController {
  late InitController _initC;
  late final AuthServices _authServices;

  final formKey = GlobalKey<FormState>();
  final usernameC = TextEditingController();
  final passwordC = TextEditingController();

  final username = ''.obs;

  final isVisiblePassword = false.obs;
  final isLoading = false.obs;
  final failedMsg = RxnString();

  final logger = Logger();

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  void _init() {
    if (Get.isRegistered<InitController>()) {
      _initC = Get.find<InitController>();
    }

    _authServices = AuthServices();

    usernameC.addListener(setUsername);
  }

  void setUsername() => username.value = usernameC.text;

  void confirm() async {
    FocusScope.of(Get.context!).unfocus();
    isLoading.value = true;
    failedMsg.value = null;

    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      checkLogin();
    } else {
      isLoading.value = false;
    }
  }

  Future<void> checkLogin() async {
    final reqData = RequestLoginModel(
      username: username.value,
      password: passwordC.text,
    );

    try {
      final res = await _authServices.login(reqData);

      if (res.statusCode == HttpStatus.ok) {
        final loginModel = ResponseLoginModel.fromMap(res.data);
        final id = loginModel.result?.data?.id;
        final token = loginModel.result?.token;
        final role = loginModel.result?.data?.namaRoles;
        final provincesId = loginModel.result?.data?.provincesId;
        final regenciesId = loginModel.result?.data?.regenciesId;
        final districtsId = loginModel.result?.data?.districtsId;

        if (id != null && token != null) {
          final session = UserSession(
            id: id,
            token: token,
            role: role ?? '',
            provincesId: provincesId ?? 0,
            regenciesId: regenciesId ?? 0,
            districtsId: districtsId ?? 0,
          );

          _initC.setSession(session).then((_) => moveToMain(role));
        } else {
          failedMsg.value =
              'Token tidak tergenerate gagal mengautentikasi akun!';
        }
      } else {
        failedMsg.value = res.data?.message;
      }
    } on DioException catch (e) {
      logger.e(
        'error: ${e.message} and type ${e.type}',
        stackTrace: e.stackTrace,
        time: DateTime.now(),
      );

      if (e.type == DioExceptionType.badResponse) {
        failedMsg.value = e.message;
      } else {
        showSnackBar(
          content: const Text('Login gagal karena kesalahan sistem'),
          backgroundColor: Colors.red,
        );
      }
    }

    isLoading.value = false;
  }

  void moveToMain(String? role) {
    if (role?.toLowerCase() == 'koordinator') {
      Get.offAllNamed(Routes.KORLAP);
    } else {
      Get.offAllNamed(Routes.KORCAB);
    }
  }
}
