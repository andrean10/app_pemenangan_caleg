import 'package:flutter/material.dart';

class BuilderAuthHead extends StatelessWidget {
  const BuilderAuthHead({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final orientation = MediaQuery.of(context).orientation;

    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Column(
        children: [
          Image.asset(
            'assets/img/logo.png.webp',
            width: (orientation == Orientation.portrait)
                ? size.width * 0.25
                : size.height * 0.2,
          ),
          // const SizedBox(height: 21),
          // AutoSizeText(
          //   'Selamat Datang di Aplikasi Pemenangan Caleg',
          //   style: theme.textTheme.titleMedium?.copyWith(
          //     fontWeight: FontWeight.bold,
          //   ),
          //   maxLines: 2,
          //   textAlign: TextAlign.center,
          //   maxFontSize: 21,
          // ),
        ],
      ),
    );
  }
}
