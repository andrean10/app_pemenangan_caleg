import 'package:app_pemenangan_caleg/app/modules/init/bindings/init_binding.dart';
import 'package:app_pemenangan_caleg/app/routes/app_pages.dart';
import 'package:app_pemenangan_caleg/app/shared/shared_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: InitBinding(),
      title: 'Pemenangan Caleg',
      theme: SharedTheme.lightTheme,
      themeMode: ThemeMode.light,
      getPages: AppPages.routes,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('id'), // Indonesia
      ],
      defaultTransition: Transition.cupertino,
      debugShowCheckedModeBanner: false,
      enableLog: true,
    );
  }
}
