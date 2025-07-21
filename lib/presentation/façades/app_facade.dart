

import 'package:weather/core/localization/app_lang.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/services/session_manager.dart';

import '../../core/param/no_param.dart';
import '../../core/usecases/app_theme_usecases.dart';


class AppUiFacade {
  final SetAppThemeUseCase setAppThemeUseCase;
  final GetAppThemeUseCase getAppThemeUseCase;
  // final CheckFirstInitUseCase checkFirstInitUseCase;
  // final SetFirstTimeUseCase setFirstTimeUseCase;
  final SessionManager sessionManager;

  AppUiFacade(
      {required this.setAppThemeUseCase,
      required this.getAppThemeUseCase,
      // this.checkFirstInitUseCase,
      // this.setFirstTimeUseCase,
     required this.sessionManager
      });

  Future<AppThemeMode> getAppTheme() {
    return getAppThemeUseCase(NoParams());
  }

  // Future<bool> isItFirstInit() {
  //   return checkFirstInitUseCase(NoParams());
  // }

  // void setFirstTime() {
  //   setFirstTimeUseCase(NoParams());
  // }

  Future<AppLanguages> getSessionLang() {
    return sessionManager.LangApp;
  }

  Future<void> setAppTheme(AppThemeMode appThemeMode) {
    return setAppThemeUseCase(ThemeParams(appThemeMode));
  }
}
