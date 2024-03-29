import 'package:app_pemenangan_caleg/app/utils/constants_endpoint.dart';
import 'package:app_pemenangan_caleg/app/utils/constants_korcab_destination.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../../../shared/shared_method.dart';
import '../../../../shared/shared_theme.dart';
import '../../controllers/home/home_korcab_controller.dart';

class HomeKorcabView extends GetView<HomeKorcabController> {
  const HomeKorcabView({Key? key}) : super(key: key);

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
            FutureBuilder(
                future: controller.fetchProfile(),
                builder: (context, snapshot) {
                  var name = '-';

                  if (snapshot.hasData && snapshot.data != null) {
                    name = snapshot.data?.profile?.namaProfile ?? '-';
                  }

                  return AutoSizeText(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  );
                }),
            const SizedBox(height: 4),
          ],
        ),
        centerTitle: false,
        actions: [
          FutureBuilder(
              future: controller.fetchProfile(),
              builder: (context, snapshot) {
                var imageUrl = '';
                if (snapshot.hasData && snapshot.data != null) {
                  imageUrl = snapshot.data?.profile?.gambarProfile ?? '-';
                }

                return GestureDetector(
                  onTap: () => controller.korcabC
                      .setCurentIndex(ConstantsKorcabDestination.profile),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    child: CachedNetworkImage(
                      imageUrl: '${ConstantsEndpoint.imgProfile}$imageUrl',
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
                );
              }),
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
            onTap: () => controller.korcabC
                .setCurentIndex(ConstantsKorcabDestination.pendukung),
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
            onTap: () => controller.korcabC
                .setCurentIndex(ConstantsKorcabDestination.koordinator),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.orangeAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.supervisor_account_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Koor TPS',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: controller.moveToDataTPS,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.archive_rounded,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Data TPS',
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: controller.moveToSuaraTPS,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.blueAccent,
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
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontWeight: FontWeight.bold,
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
      body: SingleChildScrollView(
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
