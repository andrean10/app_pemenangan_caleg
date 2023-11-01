import 'package:app_pemenangan_caleg/app/data/models/korlap/header/response/header_pendukung_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

import '../../../../widgets/buttons/custom_filled_button.dart';
import '../../../../widgets/card/cards.dart';
import '../../../../widgets/infinite_scroll/infinite_scroll.dart';
import '../../controllers/suara_tps/suara_tps_klp_controller.dart';

class SuaraTPS {
  final String gender;
  final int jumlah;

  SuaraTPS(this.gender, this.jumlah);
}

List<PieSeries<SuaraTPS, String>> _getDefaultPieSeries(
    HeaderPendukungModel data) {
  return <PieSeries<SuaraTPS, String>>[
    PieSeries<SuaraTPS, String>(
      name: data.tps?.namaTps,
      enableTooltip: true,
      explode: true,
      explodeIndex: 0,
      explodeOffset: '10%',
      dataSource: <SuaraTPS>[
        SuaraTPS('Laki-laki', data.tps?.totallkTps ?? 0),
        SuaraTPS('Perempuan', data.tps?.totalprTps ?? 0),
      ],
      xValueMapper: (SuaraTPS data, _) => data.gender,
      yValueMapper: (SuaraTPS data, _) => data.jumlah,
      dataLabelMapper: (SuaraTPS data, _) => '${data.gender}\n${data.jumlah}',
      pointColorMapper: (datum, index) =>
          index == 0 ? Colors.blueAccent : Colors.pinkAccent,
      startAngle: 0,
      endAngle: 0,
      dataLabelSettings: DataLabelSettings(
        isVisible: true,
        textStyle: Get.textTheme.labelLarge?.copyWith(color: Colors.white),
      ),
    ),
  ];
}

class SuaraTpsKlpView extends GetView<SuaraTpsKlpController> {
  const SuaraTpsKlpView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    Widget builderItemHeader({
      required IconData icons,
      required String value,
    }) {
      return Row(
        children: [
          Icon(
            icons,
            size: 18,
          ),
          const SizedBox(width: 4),
          Text(value),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suara TPS'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.fetchHeaderPendukung(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: InfiniteScroll.builderFirstPageProgress(),
            );
          } else if (snapshot.hasError) {
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
                          onPressed: () => controller.fetchHeaderPendukung(),
                          isFilledTonal: false,
                          child: const Text('Coba Lagi'),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            );
          } else if (snapshot.hasData && snapshot.data != null) {
            final data = snapshot.data;
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SfCircularChart(
                  title: ChartTitle(text: '${snapshot.data?.tps?.namaTps}'),
                  series: _getDefaultPieSeries(snapshot.data!),
                  legend: const Legend(isVisible: true),
                  tooltipBehavior: TooltipBehavior(enable: true),
                ),
                Container(
                  width: double.infinity,
                  color: theme.colorScheme.outline.withOpacity(0.1),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        builderItemHeader(
                          icons: Icons.location_on_outlined,
                          value: 'Kelurahan : ${data?.tps?.villages?.name}',
                        ),
                        const SizedBox(height: 8),
                        builderItemHeader(
                          icons: Icons.home_outlined,
                          value: 'Alamat : ${data?.tps?.alamatTps}',
                        ),
                        const SizedBox(height: 8),
                        builderItemHeader(
                          icons: Icons.people_alt_outlined,
                          value:
                              'Total Dukungan : ${data?.tps?.totalsemuaTps ?? '-'} Suara',
                        ),
                        const SizedBox(height: 8),
                        builderItemHeader(
                          icons: Icons.man_outlined,
                          value:
                              'Dukungan Laki-laki : ${data?.tps?.totallkTps ?? '-'} Suara',
                        ),
                        const SizedBox(height: 8),
                        builderItemHeader(
                          icons: Icons.woman_outlined,
                          value:
                              'Dukungan Perempuan : ${data?.tps?.totalprTps ?? '-'} Suara',
                        ),
                        const SizedBox(height: 8),
                        builderItemHeader(
                          icons: Icons.person_outline,
                          value:
                              'Total Koordinator : ${data?.tps?.totalcoTps ?? '-'} Orang',
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          } else {
            return const Text('Data Kosong');
          }
        },
      ),
    );
  }
}
