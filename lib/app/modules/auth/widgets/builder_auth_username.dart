import 'package:app_pemenangan_caleg/app/helper/validation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../widgets/textformfield/custom_text_form_field.dart';

class BuilderAuthUsername extends StatelessWidget {
  final TextEditingController controller;
  final RxString username;

  const BuilderAuthUsername({
    required this.controller,
    required this.username,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ObxValue(
      (username) {
        return CustomTextField(
          controller: controller,
          title: 'Username',
          hintTitle: 'example',
          keyboardType: TextInputType.text,
          textCapitalization: TextCapitalization.none,
          prefixIcon: Icons.person_rounded,
          suffixIcon: (username.value.isNotEmpty)
              ? IconButton(
                  onPressed: () => controller.clear(),
                  icon: const Icon(Icons.cancel_rounded),
                )
              : null,
          validator: (value) => Validation.formField(
            titleField: 'Username',
            value: value,
          ),
        );
      },
      username,
    );
  }
}
