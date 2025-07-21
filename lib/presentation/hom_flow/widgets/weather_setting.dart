import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/blocs/application_bloc/app_bloc.dart';
import 'package:weather/core/localization/app_lang.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/custom_widgets/text_translation.dart';

class WeatherSetting extends StatelessWidget {
  const WeatherSetting({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppBloc, AppState>(
      bloc: locator<AppBloc>(),
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ScreenUtil().setWidth(20),
            vertical: ScreenUtil().setHeight(20),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Language Settings
              Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                  color: locator<AppThemeColors>().ContainerColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTranslation(
                      TranslationsKeys.Language,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(50),
                        fontWeight: FontWeight.bold,
                        color: locator<AppThemeColors>().textBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildLanguageButton(
                          context: context,
                          language: AppLanguages.en,
                          currentLanguage: state.language,
                          label: TranslationsKeys.EN,
                        ),
                        _buildLanguageButton(
                          context: context,
                          language: AppLanguages.ar,
                          currentLanguage: state.language,
                          label: TranslationsKeys.AR,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: ScreenUtil().setHeight(20)),

              // Theme Settings
              Container(
                padding: EdgeInsets.all(ScreenUtil().setWidth(20)),
                decoration: BoxDecoration(
                  color: locator<AppThemeColors>().ContainerColor,
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 2,
                      blurRadius: 3,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextTranslation(
                      TranslationsKeys.Them,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(50),
                        fontWeight: FontWeight.bold,
                        color: locator<AppThemeColors>().textBlack,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        _buildThemeButton(
                          context: context,
                          mode: AppThemeMode.light,
                          currentMode: state.appThemeMode,
                          label: TranslationsKeys.light,
                        ),
                        _buildThemeButton(
                          context: context,
                          mode: AppThemeMode.dark,
                          currentMode: state.appThemeMode,
                          label: TranslationsKeys.Dark,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLanguageButton({
    required BuildContext context,
    required AppLanguages language,
    required AppLanguages currentLanguage,
    required String label,
  }) {
    final isSelected = language == currentLanguage;
    return TextButton(
      onPressed: () {
        context.read<AppBloc>().add(AppLanguageEvent(language));
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected
            ? locator<AppThemeColors>().lightblue
            : locator<AppThemeColors>().ContainerColor,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(40),
          vertical: ScreenUtil().setHeight(12),
        ),
      ),
      child: TextTranslation(
        label,
        style: TextStyle(
          color: locator<AppThemeColors>().textBlack,
          fontSize: ScreenUtil().setSp(40),
        ),
      ),
    );
  }

  Widget _buildThemeButton({
    required BuildContext context,
    required AppThemeMode mode,
    required AppThemeMode currentMode,
    required String label,
  }) {
    final isSelected = mode == currentMode;
    return TextButton(
      onPressed: () {
        context.read<AppBloc>().add(AppThemeModeEvent(appThemeMode: mode));
      },
      style: TextButton.styleFrom(
        backgroundColor: isSelected
            ? locator<AppThemeColors>().lightblue
            : locator<AppThemeColors>().ContainerColor,
        padding: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(40),
          vertical: ScreenUtil().setHeight(12),
        ),
      ),
      child: TextTranslation(
        label,
        style: TextStyle(
          color: locator<AppThemeColors>().textBlack,
          fontSize: ScreenUtil().setSp(40),
        ),
      ),
    );
  }
}
