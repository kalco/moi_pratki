// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:moi_pratki/app/controller/home_controller.dart';
import 'package:moi_pratki/app/screen/home/home_screen.dart';
import 'package:moi_pratki/app/splash_screen.dart';
import 'package:moi_pratki/base/color_data.dart';
import 'package:moi_pratki/base/constant.dart';
import 'package:moi_pratki/base/preference_settings_helper.dart';
import 'package:moi_pratki/base/preference_settings_provider.dart';
import 'package:moi_pratki/base/translate.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:workmanager/workmanager.dart';

const fetchBackground = "fetchBackground";
DataController controller = Get.put(DataController());


@pragma('vm:entry-point')
void callbackDispatcher() {
  Workmanager().executeTask((task, inputData) {
    switch (task) {
      case fetchBackground:
        controller.updateInBackground();
        break;
    }
    return Future.value(true);
  });
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
    Workmanager().initialize(
      callbackDispatcher,
      isInDebugMode: false
  );
    Workmanager().registerPeriodicTask("task-identifier", fetchBackground,frequency: const Duration(hours: 24));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((_) => runApp(const MyApp()));
}



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    TranslatorHelper.init();
    changeStatusColor(primaryColor);
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferenceSettingsProvider(
            preferenceSettingsHelper: PreferenceSettingsHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
      ],
      child: Consumer<PreferenceSettingsProvider>(
        builder: (context, preferenceSettingsProvider, _) {
          return GetMaterialApp(
            navigatorKey: NavKey.navKey,
            theme: preferenceSettingsProvider.themeData,
            debugShowCheckedModeBanner: false,
            routes: routes,
            builder: EasyLoading.init(),
          );
        },
      ),
    );
  }

  var routes = <String, WidgetBuilder>{
    Routes.splash: (BuildContext context) => const SplashScreen(),
    Routes.home: (BuildContext context) => const HomeManage(),
  };
}

class Routes {
  static String splash = "/";
  static String home = "/screen/home";
}

class NavKey {
  static final navKey = GlobalKey<NavigatorState>();
}
