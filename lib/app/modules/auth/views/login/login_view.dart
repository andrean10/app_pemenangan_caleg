import 'package:app_pemenangan_caleg/app/modules/auth/widgets/builder_auth_username.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../widgets/card/cards.dart';
import '../../controllers/login_controller.dart';
import '../../widgets/builder_auth_button.dart';
import '../../widgets/builder_auth_head.dart';
import '../../widgets/builder_auth_password.dart';
import '../../widgets/builder_failed_message.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Widget builderForm() {
      return Form(
        key: controller.formKey,
        child: Column(
          children: [
            BuilderAuthUsername(
              controller: controller.usernameC,
              username: controller.username,
            ),
            const SizedBox(height: 21),
            BuilderAuthPassword(
              controller: controller.passwordC,
              isVisiblePassword: controller.isVisiblePassword,
            ),
            const SizedBox(height: 12),
            Obx(
              () => BuilderFailedMessage(
                failedMsg: controller.failedMsg.value,
              ),
            ),
            const SizedBox(height: 21),
            BuilderAuthButton(
              textFilledButton: 'Login',
              textButton: 'Belum punya akun? Daftar',
              onPressedFilledButton: controller.confirm,
              onPressedTextButton: () {},
              state: controller.isLoading,
            ),
          ],
        ),
      );
    }

    Widget builderAuth() {
      return Cards.filled(
        context: context,
        child: Container(
          padding: const EdgeInsets.all(24),
          child: builderForm(),
        ),
      );
    }

    return Scaffold(
      body: Center(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 32,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const BuilderAuthHead(),
                const SizedBox(height: 21),
                builderAuth(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
