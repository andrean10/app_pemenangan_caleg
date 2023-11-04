import 'package:app_pemenangan_caleg/app/utils/constants_endpoint.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/profile_korlap_controller.dart';

class ProfileKorlapView extends GetView<ProfileKorlapController> {
  const ProfileKorlapView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget builderHeader() {
      return Obx(
        () => Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: CachedNetworkImage(
                width: 120,
                height: 120,
                imageUrl:
                    '${ConstantsEndpoint.imgProfile}${controller.usersModel.value?.profile?.gambarProfile}',
                fit: BoxFit.cover,
                errorWidget: (context, url, error) => Image.asset(
                  'assets/img/placeholder_no_photo.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 16),
            AutoSizeText(
              controller.usersModel.value?.profile?.namaProfile ?? '-',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            AutoSizeText(
              'NIK: ${controller.usersModel.value?.profile?.nikProfile ?? '-'}',
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ),
      );
    }

    Widget builderItemMenu({
      required IconData icon,
      required String title,
      required Function() onTap,
    }) {
      return ListTile(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(16),
          ),
        ),
        leading: Icon(icon),
        title: Text(title),
        onTap: onTap,
      );
    }

    Widget builderMenu() {
      return Column(
        children: [
          builderItemMenu(
            icon: Icons.person_outline_rounded,
            title: 'Profile Saya',
            onTap: controller.moveToDetail,
          ),
          const SizedBox(height: 8),
          builderItemMenu(
            icon: Icons.logout_rounded,
            title: 'Log Out',
            onTap: () async {
              Get.defaultDialog(
                title: 'Logout',
                middleText: 'Apakah anda yakin ingin keluar?',
                textConfirm: 'Ya',
                textCancel: 'Tidak',
                onConfirm: () => controller.logout(),
              );
            },
          ),
        ],
      );
    }

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Profile Saya'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 22),
            decoration: BoxDecoration(
              color: Colors.grey.withOpacity(0.1),
              borderRadius: const BorderRadius.all(
                Radius.circular(20),
              ),
            ),
            child: Column(
              children: [
                builderHeader(),
                const SizedBox(height: 32),
                builderMenu(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
