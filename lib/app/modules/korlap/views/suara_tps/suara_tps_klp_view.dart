import 'package:app_pemenangan_caleg/app/data/models/korlap/dashboard/response/result_dashboard_suara_model.dart';
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
    ResultDashboardSuaraModel? result) {
  final tps = result?.koordinatorTps?.tps;

  return <PieSeries<SuaraTPS, String>>[
    PieSeries<SuaraTPS, String>(
      name: tps?.namaTps ?? 'TPS -',
      enableTooltip: true,
      explode: true,
      explodeIndex: 0,
      explodeOffset: '10%',
      dataSource: <SuaraTPS>[
        SuaraTPS('Laki-laki', result?.totalDukunganLk ?? 0),
        SuaraTPS('Perempuan', result?.totalDukunganPr ?? 0),
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

    Widget builderPie(ResultDashboardSuaraModel? result) {
      final tps = result?.koordinatorTps?.tps;

      return SfCircularChart(
        title: ChartTitle(text: '${tps?.namaTps}'),
        series: _getDefaultPieSeries(result),
        legend: const Legend(isVisible: true),
        tooltipBehavior: TooltipBehavior(enable: true),
      );
    }

    Widget builderInfo(ResultDashboardSuaraModel? result) {
      final tps = result?.koordinatorTps?.tps;

      return Container(
        width: double.infinity,
        color: theme.colorScheme.outline.withOpacity(0.1),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              builderItemHeader(
                icons: Icons.location_on_outlined,
                value: 'Kelurahan : ${tps?.villages?.name}',
              ),
              const SizedBox(height: 8),
              builderItemHeader(
                icons: Icons.home_outlined,
                value: 'Alamat : ${tps?.alamatTps}',
              ),
              const SizedBox(height: 8),
              builderItemHeader(
                icons: Icons.people_alt_outlined,
                value: 'Total Dukungan : ${result?.totalDukungan ?? '-'} Suara',
              ),
              const SizedBox(height: 8),
              builderItemHeader(
                icons: Icons.man_outlined,
                value:
                    'Dukungan Laki-laki : ${result?.totalDukunganLk ?? '-'} Suara',
              ),
              const SizedBox(height: 8),
              builderItemHeader(
                icons: Icons.woman_outlined,
                value:
                    'Dukungan Perempuan : ${result?.totalDukunganPr ?? '-'} Suara',
              ),
              const SizedBox(height: 8),
              builderItemHeader(
                icons: Icons.person_outline,
                value:
                    'Total Koordinator : ${result?.totalkoordinator ?? '-'} Orang',
              ),
              const SizedBox(height: 16),
              LinearProgressIndicator(
                value: result!.presentasePemenangan! / 100,
                backgroundColor: theme.colorScheme.errorContainer,
                valueColor: AlwaysStoppedAnimation<Color>(
                  theme.colorScheme.primary,
                ),
                borderRadius: BorderRadius.circular(16),
                minHeight: 12,
              ),
              Text('${result.presentasePemenangan} %'),
              const SizedBox(height: 8),
              builderItemHeader(
                icons: Icons.campaign_rounded,
                value:
                    'Target Pemenangan TPS : ${result.targetPemenangan ?? '-'} Suara',
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Suara TPS'),
        centerTitle: true,
      ),
      body: FutureBuilder(
        future: controller.fetchKorlapSuaraTps(),
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
                          onPressed: () => controller.fetchKorlapSuaraTps(),
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
            final result = snapshot.data?.result;

            return SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  builderPie(result),
                  builderInfo(result),
                ],
              ),
            );
          } else {
            return const Center(child: Text('Data Kosong'));
          }
        },
      ),
    );
  }
}
