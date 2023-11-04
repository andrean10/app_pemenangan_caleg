import 'dart:io';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../data/models/jabatan/response/result_jabatan_model.dart';
import '../../../shared/shared_theme.dart';
import '../../../utils/constants_endpoint.dart';
import '../../../widgets/buttons/custom_filled_button.dart';
import '../../../widgets/infinite_scroll/infinite_scroll.dart';
import '../../../widgets/textformfield/custom_text_form_field.dart';
import '../controllers/manage_profile_controller.dart';

class ManageProfileView extends GetView<ManageProfileController> {
  const ManageProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    Widget builderNoInduk() {
      return Obx(
        () => CustomTextField(
          title: 'No Induk',
          hintTitle: '123456789',
          controller: controller.noIndukC,
          keyboardType: const TextInputType.numberWithOptions(),
          suffixIconState: controller.noInduk.value != 0,
          validator: (value) => controller.validateForm(
            value: value,
            titleField: 'No Induk',
            isNumber: true,
          ),
          maxLength: 9,
        ),
      );
    }

    Widget builderNama() {
      return Obx(
        () => CustomTextField(
          title: 'Nama',
          hintTitle: 'Nama',
          controller: controller.namaC,
          keyboardType: TextInputType.name,
          suffixIconState: controller.nama.value != '',
          validator: (value) => controller.validateForm(
            value: value,
            titleField: 'Nama',
          ),
        ),
      );
    }

    Widget builderJenisKelamin() {
      return Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jenis Kelamin',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: RadioListTile<JenisKelamin>(
                    value: JenisKelamin.L,
                    groupValue: controller.jenisKelamin.value,
                    onChanged: controller.setJenisKelamin,
                    title: Text(
                      'Laki-laki',
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
                Expanded(
                  child: RadioListTile<JenisKelamin>(
                    value: JenisKelamin.P,
                    groupValue: controller.jenisKelamin.value,
                    onChanged: controller.setJenisKelamin,
                    title: Text(
                      'Perempuan',
                      style: theme.textTheme.labelLarge,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      );
    }

    Widget builderJabatan() {
      return Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Jabatan',
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            DropdownSearch<ResultJabatanModel>(
              autoValidateMode: AutovalidateMode.onUserInteraction,
              popupProps: PopupProps.modalBottomSheet(
                title: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Pilih Jabatan',
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 21,
                        ),
                      ),
                      const Divider(thickness: 2)
                    ],
                  ),
                ),
                loadingBuilder: (context, searchEntry) => Center(
                  child: InfiniteScroll.builderFirstPageProgress(),
                ),
              ),
              dropdownButtonProps: const DropdownButtonProps(
                icon: Icon(Icons.arrow_drop_down_rounded),
              ),
              dropdownDecoratorProps: DropDownDecoratorProps(
                dropdownSearchDecoration: InputDecoration(
                  hintText: 'Pilih Item',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                ),
              ),
              asyncItems: (text) => controller.fetchJabatan(),
              itemAsString: (item) =>
                  '${item.namaJabatan} - ${item.keteranganJabatan}',
              selectedItem: controller.selectedItemJurusan.value,
              onChanged: controller.setJabatan,
              validator: (value) => controller.validateForm(
                value: value?.namaJabatan,
                titleField: 'Jabatan',
              ),
            ),
          ],
        ),
      );
    }

    Widget builderEmail() {
      return Obx(
        () => CustomTextField(
          title: 'Email',
          hintTitle: 'example@gmail.com',
          controller: controller.emailC,
          keyboardType: TextInputType.emailAddress,
          suffixIconState: controller.email.value != '',
          validator: (value) => controller.validateForm(
            value: value,
            titleField: 'Email',
            isEmail: true,
          ),
        ),
      );
    }

    Widget builderNoHandphone() {
      return Obx(
        () => CustomTextField(
          title: 'No Handphone',
          hintTitle: '08123456789',
          controller: controller.noHandphoneC,
          keyboardType: const TextInputType.numberWithOptions(),
          suffixIconState: controller.noHandphone.value != '',
          validator: (value) => controller.validateForm(
            value: value,
            titleField: 'No Handphone',
            isNumberPhone: true,
          ),
          maxLength: 12,
        ),
      );
    }

    Widget builderAlamat() {
      return Obx(
        () => CustomTextField(
          title: 'Alamat',
          hintTitle: 'Alamat',
          controller: controller.alamatC,
          keyboardType: TextInputType.streetAddress,
          suffixIconState: controller.alamat.value != '',
          maxLines: 3,
        ),
      );
    }

    Widget childBuilderPhoto() {
      if (controller.image.value != null &&
          controller.selectedImage.value == null) {
        return Image.network(
          '${ConstantsEndpoint.imgProfile}${controller.image.value}',
          fit: BoxFit.cover,
        );
      } else if (controller.selectedImage.value != null) {
        return Image.file(
          File(controller.selectedImage.value!.path),
          fit: BoxFit.cover,
        );
      } else {
        return const Center(
          child: Icon(Icons.add_a_photo_rounded),
        );
      }
    }

    Widget builderPhoto() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upload Photo',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Obx(
                  () => InkWell(
                    onTap: controller.pickImage,
                    child: Container(
                      height: size.height * 0.2,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: childBuilderPhoto(),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    }

    // Widget builderIsAktif() {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Text(
    //         'Status user',
    //         style: theme.textTheme.titleMedium,
    //       ),
    //       const SizedBox(height: 8),
    //       Obx(
    //         () => CheckboxListTile(
    //           title: Text(
    //             'Apakah user ini aktif',
    //             style: theme.textTheme.labelLarge,
    //           ),
    //           value: controller.isAktif.value,
    //           onChanged: controller.setIsAktif,
    //         ),
    //       ),
    //     ],
    //   );
    // }

    Widget builderForm() {
      return Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            builderNoInduk(),
            const SizedBox(height: 16),
            builderNama(),
            const SizedBox(height: 16),
            builderJenisKelamin(),
            const SizedBox(height: 16),
            builderJabatan(),
            const SizedBox(height: 16),
            builderEmail(),
            const SizedBox(height: 16),
            builderNoHandphone(),
            const SizedBox(height: 16),
            builderAlamat(),
            const SizedBox(height: 16),
            // builderIsAktif(),
            // const SizedBox(height: 16),
            builderPhoto(),
          ],
        ),
      );
    }

    Widget builderConfirm() {
      return Container(
        padding: const EdgeInsets.all(16),
        child: Obx(
          () => CustomFilledButton(
            width: double.infinity,
            isFilledTonal: false,
            state: controller.isLoading.value,
            onPressed: controller.confirm,
            child: const Text(
              'Simpan',
              style: TextStyle(fontWeight: SharedTheme.semiBold),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile Saya'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: builderForm(),
      ),
      bottomNavigationBar: builderConfirm(),
    );
  }
}
