import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:lottie/lottie.dart';

import '../../utils/constants_lottie.dart';
import '../buttons/custom_filled_button.dart';
import '../card/cards.dart';

abstract class InfiniteScroll {
  static Widget builderFirstPageProgress() {
    return LottieBuilder.asset(ConstantsLottie.loading);
  }

  static Widget builderFirstPageError<K, V>({
    required BuildContext context,
    required PagingController<K, V> controller,
  }) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Cards.filled(
          context: context,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Upss... sepertinya ada masalah!'),
                const SizedBox(height: 21),
                CustomFilledButton(
                  onPressed: () => controller.refresh(),
                  isFilledTonal: false,
                  child: const Text('Coba Lagi'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  static Widget builderNewPageProgress(Size size) {
    return LottieBuilder.asset(
      ConstantsLottie.loading,
      width: size.width / 12,
      height: size.height / 12,
    );
  }

  static Widget builderNewPageError<K, V>(PagingController<K, V> controller) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Sepertinya ada yang salah. Tekan dan coba lagi'),
          IconButton(
            onPressed: () => controller.retryLastFailedRequest(),
            icon: const Icon(Icons.refresh_rounded),
          ),
        ],
      ),
    );
  }

  static Widget builderNoItemsFound() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            ConstantsLottie.empty,
            width: 150,
            height: 150,
          ),
          const SizedBox(height: 16),
          Text(
            'Tidak ada data',
            style: Get.theme.textTheme.titleLarge,
          ),
        ],
      ),
    );
  }
}
