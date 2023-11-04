import 'package:app_pemenangan_caleg/app/utils/constants_endpoint.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/detail_profile_controller.dart';

class DetailProfileKorcabView extends GetView<DetailProfileKorcabController> {
  const DetailProfileKorcabView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    Widget builderImage() {
      return Obx(() {
        return CachedNetworkImage(
          height: size.height * 0.4,
          imageUrl:
              '${ConstantsEndpoint.imgProfile}${controller.dataUsers.value?.profile!.gambarProfile}',
          errorWidget: (context, url, error) => Image.asset(
            'assets/img/placeholder_no_photo.png',
            fit: BoxFit.cover,
          ),
        );
      });
    }

    Widget builderItemField({
      required String field,
      required dynamic value,
      bool isImage = false,
    }) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              field,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          const Flexible(
            child: Text(':'),
          ),
          Expanded(
            flex: 3,
            child: (isImage)
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: CachedNetworkImage(
                      imageUrl: '',
                      height: size.height * 0.15,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/img/no_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : (value is IconData)
                    ? Icon(value)
                    : Text(
                        value,
                        textAlign: TextAlign.center,
                        style: theme.textTheme.bodyMedium,
                      ),
          ),
        ],
      );
    }

    Widget builderUserAccount() {
      return Obx(() {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Users Account',
              style: theme.textTheme.titleLarge,
            ),
            Divider(
              thickness: 2,
              endIndent: size.width * 0.3,
            ),
            const SizedBox(height: 8),
            builderItemField(
              field: 'Username',
              value: controller.dataUsers.value?.username ?? '-',
            ),
            const SizedBox(height: 8),
            builderItemField(
              field: 'Role',
              value: controller.dataUsers.value?.roles?[0].namaRoles ?? '-',
            ),
          ],
        );
      });
    }

    Widget builderBiodata() {
      return Obx(
        () => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Biodata',
              style: theme.textTheme.titleLarge,
            ),
            Divider(
              thickness: 2,
              endIndent: size.width * 0.3,
            ),
            const SizedBox(height: 8),
            builderItemField(
              field: 'NIK',
              value: controller.dataUsers.value?.profile?.nikProfile ?? '-',
            ),
            const SizedBox(height: 8),
            builderItemField(
              field: 'Nama',
              value: controller.dataUsers.value?.profile?.namaProfile ?? '-',
            ),
            const SizedBox(height: 8),
            builderItemField(
              field: 'Email',
              value: controller.dataUsers.value?.profile?.emailProfile ?? '-',
            ),
            const SizedBox(height: 8),
            builderItemField(
              field: 'Alamat',
              value: controller.dataUsers.value?.profile?.alamatProfile ?? '-',
            ),
            const SizedBox(height: 8),
            const SizedBox(height: 8),
            builderItemField(
              field: 'No. HP',
              value: controller.dataUsers.value?.profile?.nohpProfile ?? '-',
            ),
            const SizedBox(height: 8),
            builderItemField(
              field: 'Jenis Kelamin',
              value: (controller
                          .dataUsers.value?.profile?.jenisKelaminProfile !=
                      null)
                  ? (controller.dataUsers.value?.profile?.jenisKelaminProfile ==
                          'L')
                      ? 'Laki-laki'
                      : 'Perempuan'
                  : '-',
            ),
          ],
        ),
      );
    }

    Widget builderContent() {
      return SingleChildScrollView(
        child: Column(
          children: [
            builderImage(),
            Padding(
              padding: const EdgeInsets.all(21),
              child: Column(
                children: [
                  builderUserAccount(),
                  const SizedBox(height: 32),
                  builderBiodata()
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Profile Saya'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
        actions: [
          IconButton(
            onPressed: controller.moveToManageProfile,
            icon: const Icon(Icons.edit_rounded),
          ),
          const SizedBox(width: 8),
        ],
      ),
      body: builderContent(),
    );
  }
}
