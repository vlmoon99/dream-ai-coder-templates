import 'dart:async';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/assets/localization/localizations_strings.dart';
import 'package:flutter_template/modules/app_module.dart';
import 'package:flutterchain/flutterchain_lib/services/core/lib_initialization_service.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runZonedGuarded(() async {
    LicenseRegistry.addLicense(() async* {
      final license = await rootBundle.loadString('OFL.txt');
      yield LicenseEntryWithLineBreaks(['assets/fonts/manrope'], license);
    });
    WidgetsFlutterBinding.ensureInitialized();
    initFlutterChainLib();
    await EasyLocalization.ensureInitialized();
    final isAuthorized = await checkIfUserAuthorized();

    FlutterError.onError = (details) {
      FlutterError.presentError(details);
    };
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]).then(
      (value) => runApp(
        EasyLocalization(
          supportedLocales: const [
            Locale('en'),
          ],
          path: LocalizationsStrings.localizationPath,
          fallbackLocale: const Locale('en'),
          saveLocale: false,
          child: ModularApp(
            module: AppModule(),
            child: AppWidget(isAuthorized),
          ),
        ),
      ),
    );
  }, (error, stack) {
    log(error.toString());
  });
}

class AppWidget extends StatelessWidget {
  final bool isAuthorized;
  const AppWidget(this.isAuthorized, {super.key});

  @override
  Widget build(BuildContext context) {
    Modular.setInitialRoute('/');
    ScreenUtil.init(context);
    ScreenUtil.configure(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
    );

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'App name',
      routeInformationParser: Modular.routeInformationParser,
      routerDelegate: Modular.routerDelegate,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
    );
  }
}
