import 'package:app_pemenangan_caleg/app/shared/shared_method.dart';
import 'package:app_pemenangan_caleg/app/widgets/textformfield/custom_text_form_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../shared/shared_theme.dart';
import '../../../widgets/buttons/custom_filled_button.dart';
import '../controllers/manage_tps_korcab_controller.dart';

class ManageDataTpsKorcabView extends GetView<ManageDataTpsKorcabController> {
  const ManageDataTpsKorcabView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    PreferredSizeWidget builderAppBar() {
      return AppBar(
        title: Text(controller.title),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: (controller.args != null)
            ? [
                IconButton(
                  onPressed: () => Get.defaultDialog(
                    title: 'Konfirmasi',
                    titlePadding: const EdgeInsets.all(16),
                    middleText: 'Apakah anda yakin ingin menghapus TPS ini?',
                    textConfirm: 'Ya',
                    textCancel: 'Tidak',
                    onConfirm: controller.deleteTps,
                  ),
                  icon: const Icon(Icons.delete_rounded),
                ),
                const SizedBox(width: 8),
              ]
            : null,
      );
    }

    // Widget builderProvince() {
    //   return CustomTextField(
    //     controller: controller.provinceC,
    //     title: 'Provinsi',
    //     hintTitle: 'Pilih item',
    //     onTap: () => showCustomBottomSheet(
    //       context: context,
    //       pagingController: controller.pagingProvinceC,
    //       title: 'Pilih Provinsi',
    //       itemTap: (value) {
    //         controller.setProvince(value);
    //         Get.back();
    //       },
    //     ),
    //     suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
    //     isReadOnly: true,
    //     validator: (value) => controller.validateForm(
    //       value: value,
    //       titleField: 'Provinsi',
    //     ),
    //   );
    // }

    // Widget builderRegencies() {
    //   return Obx(
    //     () => CustomTextField(
    //       controller: controller.regenciesC,
    //       title: 'Kabupaten/Kota',
    //       hintTitle: 'Pilih item',
    //       isEnable: controller.selectedItemProvince.value != null,
    //       onTap: () => showCustomBottomSheet(
    //         context: context,
    //         pagingController: controller.pagingRegenciesC,
    //         title: 'Pilih Kabupaten',
    //         itemTap: (value) {
    //           controller.setRegencies(value);
    //           Get.back();
    //         },
    //       ),
    //       suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
    //       isReadOnly: true,
    //       validator: (value) => controller.validateForm(
    //         value: value,
    //         titleField: 'Kabupaten',
    //       ),
    //     ),
    //   );
    // }

    // Widget builderDistrict() {
    //   return Obx(
    //     () => CustomTextField(
    //       controller: controller.districtsC,
    //       title: 'Kecamatan',
    //       hintTitle: 'Pilih item',
    //       isEnable: controller.selectedItemRegencies.value != null,
    //       onTap: () => showCustomBottomSheet(
    //         context: context,
    //         pagingController: controller.pagingDistrictC,
    //         title: 'Pilih Kecamatan',
    //         itemTap: (value) {
    //           controller.setDistrict(value);
    //           Get.back();
    //         },
    //       ),
    //       suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
    //       isReadOnly: true,
    //       validator: (value) => controller.validateForm(
    //         value: value,
    //         titleField: 'Kecamatan',
    //       ),
    //     ),
    //   );
    // }

    Widget builderVillages() {
      return CustomTextField(
        controller: controller.villagesC,
        title: 'Kelurahan',
        hintTitle: 'Pilih item',
        onTap: () => showCustomBottomSheet(
          context: context,
          pagingController: controller.pagingVillagesC,
          title: 'Pilih Kelurahan',
          itemTap: (value) {
            controller.setVillages(value);
            Get.back();
          },
        ),
        suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
        isReadOnly: true,
        validator: (value) => controller.validateForm(
          value: value,
          titleField: 'Kelurahan',
        ),
      );

      // return Obx(
      //   () => CustomTextField(
      //     controller: controller.villagesC,
      //     title: 'Kelurahan',
      //     hintTitle: 'Pilih item',
      //     onTap: () => showCustomBottomSheet(
      //       context: context,
      //       pagingController: controller.pagingVillagesC,
      //       title: 'Pilih Kelurahan',
      //       itemTap: (value) {
      //         controller.setVillages(value);
      //         Get.back();
      //       },
      //     ),
      //     suffixIcon: const Icon(Icons.keyboard_arrow_down_rounded),
      //     isReadOnly: true,
      //     validator: (value) => controller.validateForm(
      //       value: value,
      //       titleField: 'Kelurahan',
      //     ),
      //   ),
      // );
    }

    Widget builderTPSName() {
      return Obx(
        () => CustomTextField(
          title: 'Nama TPS',
          hintTitle: 'example',
          controller: controller.tpsNameC,
          keyboardType: TextInputType.name,
          suffixIconState: controller.tpsName.value != '',
          validator: (value) => controller.validateForm(
            value: value,
            titleField: 'Nama TPS',
          ),
        ),
      );
    }

    Widget builderCoordinatorQuota() {
      return Obx(
        () => CustomTextField(
          title: 'Kuota Koordinator',
          hintTitle: '10',
          controller: controller.tpsCoQuotaC,
          keyboardType: const TextInputType.numberWithOptions(),
          suffixIconState: controller.tpsCoQuota.value != 0,
          validator: (value) => controller.validateForm(
            value: value,
            titleField: 'Kuota Koordinator',
            isNumber: true,
          ),
          maxLength: 4,
        ),
      );
    }

    Widget builderMinCoordinator() {
      return Obx(
        () => CustomTextField(
          title: 'Minimum Koordinator',
          hintTitle: '10',
          controller: controller.tpsMinCoC,
          keyboardType: const TextInputType.numberWithOptions(),
          suffixIconState: controller.tpsMinCo.value != 0,
          validator: (value) => controller.validateForm(
              value: value,
              titleField: 'Minimum Koordinator',
              isNumber: true,
              isMinCo: true),
          maxLength: 4,
        ),
      );
    }

    Widget buildeMinSupport() {
      return Obx(
        () => CustomTextField(
          title: 'Minimum Pendukung',
          hintTitle: '10',
          controller: controller.tpsSupportC,
          keyboardType: const TextInputType.numberWithOptions(),
          suffixIconState: controller.tpsSupport.value != 0,
          validator: (value) => controller.validateForm(
            value: value,
            titleField: 'Minimum Pendukung',
            isNumber: true,
          ),
          maxLength: 4,
        ),
      );
    }

    Widget builderAddress() {
      return Obx(
        () => CustomTextField(
          title: 'Alamat TPS',
          hintTitle: 'example',
          controller: controller.tpsAddressC,
          keyboardType: TextInputType.streetAddress,
          suffixIconState: controller.tpsAddress.value != '',
          validator: (value) => controller.validateForm(
            value: value,
            titleField: 'Alamat TPS',
          ),
        ),
      );
    }

    Widget builderForm() {
      return Form(
        key: controller.formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // builderProvince(),
            // const SizedBox(height: 16),
            // builderRegencies(),
            // const SizedBox(height: 16),
            // builderDistrict(),
            // const SizedBox(height: 16),
            builderVillages(),
            const SizedBox(height: 16),
            builderTPSName(),
            const SizedBox(height: 16),
            builderCoordinatorQuota(),
            const SizedBox(height: 16),
            builderMinCoordinator(),
            const SizedBox(height: 16),
            buildeMinSupport(),
            const SizedBox(height: 16),
            builderAddress(),
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
      appBar: builderAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(
          left: 21,
          right: 21,
          bottom: 32,
        ),
        child: builderForm(),
      ),
      bottomNavigationBar: builderConfirm(),
    );
  }
}
