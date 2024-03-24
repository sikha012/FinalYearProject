import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:happytails/app/utils/memory_management.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  await MemoryManagement.init();
  runApp(
    KhaltiScope(
      //9862386795
      publicKey: "test_public_key_65d815af3d214d119cac15fa6910aa6a",
      builder: (context, navigatorKey) => GetMaterialApp(
        title: "Application",
        navigatorKey: navigatorKey,
        supportedLocales: const [
          Locale('en', 'US'),
          Locale('ne', 'NP'),
        ],
        localizationsDelegates: const [
          KhaltiLocalizations.delegate,
        ],
        initialRoute: AppPages.INITIAL,
        debugShowCheckedModeBanner: false,
        defaultTransition: Transition.cupertino,
        getPages: AppPages.routes,
        theme: ThemeData(
          useMaterial3: true,
          brightness: Brightness.light,
          colorScheme: const ColorScheme.light(
            background: Color(0xFFEEEEEE),
            primary: Color(0xFF54C7EC),
            tertiary: Color(0xFFFFA500),
          ),
        ),
      ),
    ),
  );
}
