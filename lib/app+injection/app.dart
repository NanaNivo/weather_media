import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/core/blocs/application_bloc/app_bloc.dart';
import 'package:weather/core/localization/app_lang.dart';
import 'package:weather/core/navigation/routes.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/presentation/hom_flow/screens/home_page.dart';
import 'di.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(1080, 2340),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return BlocBuilder<AppBloc, AppState>(
          bloc: locator<AppBloc>(),
          builder: (context, state) {
            // Update AppThemeColors based on current theme mode
            if (locator.isRegistered<AppThemeColors>()) {
              locator.unregister<AppThemeColors>();
            }
            locator.registerFactory<AppThemeColors>(
              () => ThemeFactory.colorModeFactory(state.appThemeMode),
            );

            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              title: 'Weather App',
              theme: ThemeData(
                primaryColor: locator<AppThemeColors>().primaryColor,
                scaffoldBackgroundColor:
                    locator<AppThemeColors>().backgroundColor,
                brightness: Brightness.light,
              ),
              darkTheme: ThemeData(
                primaryColor: locator<AppThemeColors>().primaryColor,
                scaffoldBackgroundColor:
                    locator<AppThemeColors>().backgroundColor,
                brightness: Brightness.dark,
              ),
              themeMode: ThemeFactory.currentTheme(state.appThemeMode),
              localizationsDelegates:
                  LocalizationManager.createLocalizationsDelegates,
              supportedLocales: LocalizationManager.createSupportedLocals,
              locale: LocalizationManager.localeFactory(state.language),
              routerConfig: router,
            );
          },
        );
      },
    );
  }
}
