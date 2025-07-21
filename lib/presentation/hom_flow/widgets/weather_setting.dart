import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/custom_widgets/text_translation.dart';

class WeatherSetting extends StatelessWidget {
  const WeatherSetting({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            locator<AppThemeColors>().primaryColor.withOpacity(0.8),
            locator<AppThemeColors>().backgroundColor,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Settings',
                    style: TextStyle(
                      color: locator<AppThemeColors>().white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Language Settings
                  _buildSettingsCard(
                    title: 'Language',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildLanguageButton(
                          context: context,
                          language: 'EN',
                          isSelected: true,
                        ),
                        _buildLanguageButton(
                          context: context,
                          language: 'AR',
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Temperature Unit Settings
                  _buildSettingsCard(
                    title: 'Temperature Unit',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildUnitButton(
                          context: context,
                          unit: '°C',
                          isSelected: true,
                        ),
                        _buildUnitButton(
                          context: context,
                          unit: '°F',
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  // Theme Settings
                  _buildSettingsCard(
                    title: 'Theme',
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        _buildThemeButton(
                          context: context,
                          theme: 'Light',
                          icon: Icons.light_mode,
                          isSelected: true,
                        ),
                        _buildThemeButton(
                          context: context,
                          theme: 'Dark',
                          icon: Icons.dark_mode,
                          isSelected: false,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSettingsCard({required String title, required Widget child}) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: locator<AppThemeColors>().white.withOpacity(0.9),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(
              color: locator<AppThemeColors>().black,
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 16.h),
          child,
        ],
      ),
    );
  }

  Widget _buildLanguageButton({
    required BuildContext context,
    required String language,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        // Handle language selection
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? locator<AppThemeColors>().primaryColor
              : locator<AppThemeColors>().white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: locator<AppThemeColors>().primaryColor,
            width: 2,
          ),
        ),
        child: Text(
          language,
          style: TextStyle(
            color: isSelected
                ? locator<AppThemeColors>().white
                : locator<AppThemeColors>().primaryColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildUnitButton({
    required BuildContext context,
    required String unit,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        // Handle unit selection
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 32.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? locator<AppThemeColors>().primaryColor
              : locator<AppThemeColors>().white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: locator<AppThemeColors>().primaryColor,
            width: 2,
          ),
        ),
        child: Text(
          unit,
          style: TextStyle(
            color: isSelected
                ? locator<AppThemeColors>().white
                : locator<AppThemeColors>().primaryColor,
            fontSize: 16.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildThemeButton({
    required BuildContext context,
    required String theme,
    required IconData icon,
    required bool isSelected,
  }) {
    return InkWell(
      onTap: () {
        // Handle theme selection
      },
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 24.w,
          vertical: 12.h,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? locator<AppThemeColors>().primaryColor
              : locator<AppThemeColors>().white,
          borderRadius: BorderRadius.circular(30.r),
          border: Border.all(
            color: locator<AppThemeColors>().primaryColor,
            width: 2,
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: isSelected
                  ? locator<AppThemeColors>().white
                  : locator<AppThemeColors>().primaryColor,
              size: 20.w,
            ),
            SizedBox(width: 8.w),
            Text(
              theme,
              style: TextStyle(
                color: isSelected
                    ? locator<AppThemeColors>().white
                    : locator<AppThemeColors>().primaryColor,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
