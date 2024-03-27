import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:get/get.dart';
import 'package:happytails/app/data/provider/firebase_services.dart';
import 'package:happytails/app/utils/memory_management.dart';
import 'package:happytails/firebase_options.dart';
import 'package:khalti_flutter/khalti_flutter.dart';

import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await MemoryManagement.init();
  await FirebaseServices().initNotifications();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      statusBarBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(
    KhaltiScope(
      //9862386795
      publicKey: "test_public_key_b2879854a5c74b8dae7acdb7efd87368",
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
