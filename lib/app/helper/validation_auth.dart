import 'package:get/get.dart';

abstract class ValidationAuth {
  static String? isWeakPassword(String? password) {
    if (password != null && password.isEmpty) {
      return 'Password harus di isi!';
    } else if (password != null && password.length < 6) {
      return 'Password minimal 6 karakter!';
      // } else if (password != null && !password.contains(RegExp(r'[A-Z]'))) {
      //   return 'Password harus mengandung huruf besar!';
      // } else if (password != null && !password.contains(RegExp(r'[a-z]'))) {
      //   return 'Password harus mengandung huruf kecil!';
    } else if (password != null && !password.contains(RegExp(r'[0-9]'))) {
      return 'Password harus mengandung angka!';
    }

    return null;
  }

  static String? isNumberPhoneValid(String? numberPhone) {
    if (numberPhone != null && numberPhone.isEmpty) {
      return 'Nomor HP harus di isi!';
    } else if (numberPhone != null && numberPhone.length < 10) {
      return 'Nomor HP minimal 10 karakter!';
    } else if (numberPhone != null && numberPhone.length > 13) {
      return 'Nomor HP maksimal 13 karakter!';
    } else if (numberPhone != null && !numberPhone.isPhoneNumber) {
      return 'Nomor HP tidak valid!';
    }

    return null;
  }
}
