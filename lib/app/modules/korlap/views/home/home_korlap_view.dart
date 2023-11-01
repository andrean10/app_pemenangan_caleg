import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/shared_method.dart';
import '../../../../shared/shared_theme.dart';
import '../../../../utils/constants_korlap_destination.dart';
import '../../controllers/home/home_korlap_controller.dart';

class HomeKorlapView extends GetView<HomeKorlapController> {
  const HomeKorlapView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    AppBar builderHeading() {
      return AppBar(
        automaticallyImplyLeading: false,
        notificationPredicate: (notification) => notification.depth == 0,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 4),
            AutoSizeText(
              'Selamat ${checkDayMessage()}',
              style: const TextStyle(
                fontWeight: SharedTheme.light,
                fontSize: 14,
              ),
            ),
            Obx(
              () => AutoSizeText(
                controller.usersModel.value?.profile?.namaProfile ?? '-',
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(height: 4),
          ],
        ),
        centerTitle: false,
        actions: [
          GestureDetector(
            onTap: () => controller.korlapC
                .setCurentIndex(ConstantsKorlapDestination.profile),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: CachedNetworkImage(
                imageUrl: '',
                imageBuilder: (context, imageProvider) => CircleAvatar(
                  backgroundImage: imageProvider,
                ),
                placeholder: (context, url) => const CircleAvatar(),
                errorWidget: (context, url, error) => const CircleAvatar(
                  backgroundImage:
                      AssetImage('assets/img/placeholder_no_photo.png'),
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
        ],
      );
    }

    Widget builderBanner() {
      return CarouselSlider(
        options: CarouselOptions(
          height: 150,
          autoPlay: true,
        ),
        items: [
          'assets/img/banner.webp',
          'assets/img/banner2.jpg',
          'assets/img/banner3.jpg'
        ].map((i) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: const EdgeInsets.symmetric(horizontal: 5.0),
                decoration: const BoxDecoration(color: Colors.amber),
                child: Image.asset(
                  i,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      );
    }

    Widget builderMenu() {
      return GridView.count(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: [
          GestureDetector(
            onTap: () => controller.korlapC
                .setCurentIndex(ConstantsKorlapDestination.pendukung),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.redAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.groups_2_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Pendukung',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: () => controller.korlapC
                .setCurentIndex(ConstantsKorlapDestination.suaraTPS),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.pie_chart_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Suara TPS',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: controller.moveToDataPendukung,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.contact_page_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                FittedBox(
                  child: Text(
                    'Data Pendukung',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    }

    return Scaffold(
      appBar: builderHeading(),
      body: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 32,
        ),
        child: Column(
          children: [
            builderBanner(),
            const SizedBox(height: 32),
            builderMenu(),
          ],
        ),
      ),
    );
  }
}
