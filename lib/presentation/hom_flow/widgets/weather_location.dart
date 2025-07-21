import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/custom_widgets/text_translation.dart';
import 'package:weather/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:weather/presentation/hom_flow/bloc/state_home.dart';
import 'package:weather/presentation/hom_flow/bloc/event_home.dart';

class WeatherLocation extends StatelessWidget {
  const WeatherLocation({Key? key}) : super(key: key);

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
          child: Align(
            alignment: AlignmentDirectional.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    'My Location',
                    style: TextStyle(
                      color: locator<AppThemeColors>().white,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 700.w,
                    margin: EdgeInsets.all(16.w),
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
                    child: BlocBuilder<HomeBloc, HomeState>(
                      bloc: locator<HomeBloc>(),
                      builder: (context, state) {
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.location_on,
                              size: 60.w,
                              color: locator<AppThemeColors>().primaryColor,
                            ),
                            SizedBox(height: 20.h),
                            TextButton(
                              onPressed: () {
                                locator<HomeBloc>().add(GetMyLocationEvent());
                              },
                              style: TextButton.styleFrom(
                                backgroundColor:
                                    locator<AppThemeColors>().primaryColor,
                                padding: EdgeInsets.symmetric(
                                  horizontal: 32.w,
                                  vertical: 16.h,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(30.r),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.my_location,
                                    color: locator<AppThemeColors>().white,
                                  ),
                                  SizedBox(width: 8.w),
                                  TextTranslation(
                                    TranslationsKeys.MyLocation,
                                    style: TextStyle(
                                      color: locator<AppThemeColors>().white,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            if (state.isLoading ?? false) ...[
                              SizedBox(height: 24.h),
                              CircularProgressIndicator(
                                color: locator<AppThemeColors>().primaryColor,
                              ),
                            ],
                            if (state.errorMessage?.isNotEmpty ?? false) ...[
                              SizedBox(height: 16.h),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 24.w),
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: Colors.red.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Text(
                                  state.errorMessage!,
                                  style: TextStyle(
                                    color: Colors.red,
                                    fontSize: 14.sp,
                                  ),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                            if (state.position != null) ...[
                              SizedBox(height: 24.h),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 24.w),
                                padding: EdgeInsets.all(16.w),
                                decoration: BoxDecoration(
                                  color: locator<AppThemeColors>()
                                      .primaryColor
                                      .withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Column(
                                  children: [
                                    Text(
                                      'Current Location',
                                      style: TextStyle(
                                        color: locator<AppThemeColors>()
                                            .primaryColor,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: 8.h),
                                    Text(
                                      '${state.position?.latitude.toStringAsFixed(4)}, ${state.position?.longitude.toStringAsFixed(4)}',
                                      style: TextStyle(
                                        color: locator<AppThemeColors>().black,
                                        fontSize: 14.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
