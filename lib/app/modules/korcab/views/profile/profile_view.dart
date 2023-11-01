import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/profile/profile_controller.dart';

class ProfileView extends GetView<ProfileController> {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget builderHeader() {
      return Column(
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/img/placeholder_no_photo.png'),
                // image: (selectedImage == null)
                //     ? imageProvider!
                //     : FileImage(File(
                //         selectedImage!.path,
                //       )),
              ),
            ),
            // child: Align(
            //   alignment: Alignment.bottomRight,
            //   child: Container(
            //     width: 36,
            //     height: 36,
            //     padding: const EdgeInsets.all(4),
            //     decoration: const BoxDecoration(
            //       shape: BoxShape.circle,
            //       color: Colors.white,
            //     ),
            //     child: CircleAvatar(
            //       backgroundColor: theme.colorScheme.primaryContainer,
            //       child: IconButton(
            //         padding: EdgeInsets.zero,
            //         icon: const Icon(
            //           Icons.edit_outlined,
            //           size: 16,
            //         ),
            //         color: Colors.white,
            //         onPressed: () async {
            //           // final image = await selectImage();

            //           // if (controller. selectedImage.value != null) {

            //           // }
            //         },
            //       ),
            //     ),
            //   ),
            // ),
          ),
          const SizedBox(height: 16),
          AutoSizeText(
            'Example',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              // fontSize: 18,
            ),
          ),
          AutoSizeText(
            'NIK: 523523423',
            style: theme.textTheme.bodyMedium?.copyWith(
                // fontSize: 16,
                ),
          ),
        ],
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
            onTap: () {
              // Get.toNamed(Routes.DETAIL_PROFILE);
            },
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
