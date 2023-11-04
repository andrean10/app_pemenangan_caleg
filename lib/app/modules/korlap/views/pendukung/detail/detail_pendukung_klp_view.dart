import 'package:app_pemenangan_caleg/app/shared/shared_method.dart';
import 'package:app_pemenangan_caleg/app/utils/constants_endpoint.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../../../../../data/models/korlap/pendukung/response/data_pendukung_korlap.dart';
import '../../../../../utils/constants_status_verification_tps.dart';
import '../../../controllers/pendukung/detail/detail_pendukung_klp_controller.dart';

class DetailPendukungKlpView extends GetView<DetailPendukungKlpController> {
  const DetailPendukungKlpView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = MediaQuery.of(context).size;

    Widget builderImage() {
      return CachedNetworkImage(
        height: size.height * 0.4,
        imageUrl:
            '${ConstantsEndpoint.imgProfile}${controller.args.users?.profile?.gambarProfile}',
        errorWidget: (context, url, error) => Image.asset(
          'assets/img/placeholder_no_photo.png',
          fit: BoxFit.cover,
        ),
      );
    }

    Widget builderStatusBuktiLapangan(DataPendukungKorlap item) {
      var iconVerifyStatus = Icons.broken_image_rounded;
      var colorVerifyStatus = Colors.grey;
      var verifyStatus = 'Belum ada data';

      if (item.pendukungcoblosTps != null) {
        if (item.verificationcoblosTps != null) {
          if (item.verificationcoblosTps ==
              ConstantsStatusVerificationTPS.verified) {
            iconVerifyStatus = Icons.verified_rounded;
            colorVerifyStatus = Colors.green;
            verifyStatus = 'Diverifikasi';
          } else if (item.verificationcoblosTps ==
              ConstantsStatusVerificationTPS.rejected) {
            iconVerifyStatus = Icons.cancel_rounded;
            colorVerifyStatus = Colors.red;
            verifyStatus = 'Ditolak';
          }
        } else {
          iconVerifyStatus = Icons.hourglass_bottom_rounded;
          colorVerifyStatus = Colors.purple;
          verifyStatus = 'Menunggu Verifikasi';
        }
      }

      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: colorVerifyStatus,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconVerifyStatus,
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              verifyStatus,
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    Widget builderStatusBuktiCoblos(DataPendukungKorlap item) {
      var iconVerifyStatus = Icons.broken_image_rounded;
      var colorVerifyStatus = Colors.grey;
      var verifyStatus = 'Belum Mencoblos';

      if (item.tpsCoblos != null) {
        if (item.tpsStatus != null &&
            item.tpsStatus == ConstantsStatusVerificationTPS.verified) {
          iconVerifyStatus = Icons.verified_rounded;
          colorVerifyStatus = Colors.green;
          verifyStatus = 'Sudah Mencoblos';
        }
      } else {
        if (item.tpsStatus != null &&
            item.tpsStatus == ConstantsStatusVerificationTPS.rejected) {
          iconVerifyStatus = Icons.cancel_rounded;
          colorVerifyStatus = Colors.orange;
          verifyStatus = 'Belum Diverifikasi';
        }
      }

      return Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 8,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: colorVerifyStatus,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              iconVerifyStatus,
              color: Colors.white,
              size: 14,
            ),
            const SizedBox(width: 4),
            Text(
              verifyStatus,
              style: theme.textTheme.labelMedium?.copyWith(
                color: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    Widget builderItemField({
      required String field,
      required dynamic value,
      bool isImage = false,
      bool isState = false,
      bool isVerification = false,
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
                      imageUrl: '$value',
                      height: size.height * 0.15,
                      fit: BoxFit.cover,
                      errorWidget: (context, url, error) => Image.asset(
                        'assets/img/no_image.png',
                        fit: BoxFit.cover,
                      ),
                    ),
                  )
                : (isState)
                    ? Container(
                        child: (isVerification)
                            ? builderStatusBuktiLapangan(value)
                            : builderStatusBuktiCoblos(value),
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
            value: controller.args.users?.username ?? '-',
          ),
          const SizedBox(height: 8),
          builderItemField(
            field: 'Status Aktif',
            value: (controller.args.users?.isAktif != null &&
                    controller.args.users?.isAktif == 1)
                ? Icons.check_rounded
                : Icons.close_rounded,
          ),
          const SizedBox(height: 8),
          builderItemField(
            field: 'Status Pendaftaran TPS',
            value: (controller.args.users?.isRegistps != null &&
                    controller.args.users?.isRegistps == 1)
                ? Icons.check_rounded
                : Icons.close_rounded,
          ),
        ],
      );
    }

    Widget builderBiodata() {
      return Column(
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
            value: controller.args.users?.profile?.nikProfile ?? '-',
          ),
          const SizedBox(height: 8),
          builderItemField(
            field: 'Nama',
            value: controller.args.users?.profile?.namaProfile ?? '-',
          ),
          const SizedBox(height: 8),
          builderItemField(
            field: 'Email',
            value: controller.args.users?.profile?.emailProfile ?? '-',
          ),
          const SizedBox(height: 8),
          builderItemField(
            field: 'Alamat',
            value: controller.args.users?.profile?.alamatProfile ?? '-',
          ),
          const SizedBox(height: 8),
          const SizedBox(height: 8),
          builderItemField(
            field: 'No. HP',
            value: controller.args.users?.profile?.nohpProfile ?? '-',
          ),
          const SizedBox(height: 8),
          builderItemField(
            field: 'Jenis Kelamin',
            value: (controller.args.users?.profile?.jenisKelaminProfile != null)
                ? (controller.args.users?.profile?.jenisKelaminProfile == 'L')
                    ? 'Laki-laki'
                    : 'Perempuan'
                : '-',
          ),
        ],
      );
    }

    Widget builderBuktiLapangan() {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            'Verifikasi Bukti Ke Lapangan',
            style: theme.textTheme.titleLarge,
          ),
          Divider(
            thickness: 2,
            endIndent: size.width * 0.3,
          ),
          const SizedBox(height: 8),
          // builderItemField(
          //   field: 'Koordinator',
          //   value: controller.args.users?.profile?.nikProfile ?? '-',
          // ),
          // const SizedBox(height: 8),
          GestureDetector(
            // buatkan dialog full screen dan bisa di zoom gambarnya
            onTap: () => detailPicture(
              context,
              '${ConstantsEndpoint.imgTps}${controller.args.pendukungcoblosTps}',
            ),
            child: Stack(
              children: [
                builderItemField(
                  field: 'Bukti Upload',
                  value:
                      '${ConstantsEndpoint.imgTps}${controller.args.pendukungcoblosTps}',
                  isImage: true,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: controller.uploadBuktiLapangan,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.edit_rounded,
                        color: theme.colorScheme.primary,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          builderItemField(
            field: 'Status',
            value: controller.args,
            isState: true,
            isVerification: true,
          ),
        ],
      );
    }

    Widget builderBuktiPencoblosan() {
      final gambarBuktiUpload =
          '${ConstantsEndpoint.imgCoblos}${controller.args.tpsCoblos}';
      Logger().d('debug: gambarBuktiUpload $gambarBuktiUpload');

      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          AutoSizeText(
            'Verifikasi Pencoblosan',
            style: theme.textTheme.titleLarge,
          ),
          Divider(
            thickness: 2,
            endIndent: size.width * 0.3,
          ),
          const SizedBox(height: 8),
          GestureDetector(
            onTap: () => detailPicture(
              context,
              '${ConstantsEndpoint.imgCoblos}${controller.args.tpsCoblos}',
            ),
            child: Stack(
              children: [
                builderItemField(
                  field: 'Bukti Upload',
                  value:
                      '${ConstantsEndpoint.imgCoblos}${controller.args.tpsCoblos}',
                  isImage: true,
                ),
                Positioned(
                  bottom: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: controller.uploadBuktiCoblos,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.primaryContainer,
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Icon(
                        Icons.edit_rounded,
                        color: theme.colorScheme.primary,
                        size: 18,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          builderItemField(
            field: 'Status',
            value: controller.args,
            isState: true,
          ),
        ],
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
                  builderBiodata(),
                  const SizedBox(height: 32),
                  builderBuktiLapangan(),
                  const SizedBox(height: 32),
                  builderBuktiPencoblosan(),
                ],
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Pendukung'),
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new_rounded),
        ),
      ),
      body: builderContent(),
    );
  }
}
