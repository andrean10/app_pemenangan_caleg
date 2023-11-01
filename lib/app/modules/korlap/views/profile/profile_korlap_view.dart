import 'package:app_pemenangan_caleg/app/data/models/users/users_model.dart';
import 'package:app_pemenangan_caleg/app/widgets/infinite_scroll/infinite_scroll.dart';
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
    final size = MediaQuery.of(context).size;

    Widget builderHeader(UsersModel data) {
      return Column(
        children: [
          CachedNetworkImage(
            imageUrl: data.profile?.gambarProfile ?? '',
            width: size.width * 0.5,
            height: size.width * 0.5,
            fit: BoxFit.cover,
            imageBuilder: (context, imageProvider) {
              return Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    // fit: BoxFit.cover,
                    image: imageProvider,
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
              );
            },
            errorWidget: (context, url, error) => Image.asset(
              'assets/img/placeholder_no_photo.png',
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
          AutoSizeText(
            data.profile?.namaProfile ?? '',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              // fontSize: 18,
            ),
          ),
          AutoSizeText(
            'NIK: ${data.profile?.nikProfile ?? ''}',
            style: theme.textTheme.bodyMedium,
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
      body: FutureBuilder(
        future: controller.fetchProfile(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: InfiniteScroll.builderFirstPageProgress(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data;

            return ListView(
              children: [
                // const SizedBox(height: 16),
                builderHeader(data!),
                const SizedBox(height: 16),
                builderMenu(),
                const SizedBox(height: 16),
              ],
            );
          } else {
            return const Center(
              child: Text('Data tidak ditemukan'),
            );
          }
        },
      ),
    );
  }
}
