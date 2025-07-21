import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:weather/presentation/hom_flow/bloc/state_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:weather_icons/weather_icons.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({Key? key}) : super(key: key);

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
          child: BlocBuilder<HomeBloc, HomeState>(
            bloc: locator<HomeBloc>(),
            builder: (context, state) {
              if (state.isLoading ?? false) {
                return const Center(child: CircularProgressIndicator());
              }

              if (state.errorMessage?.isNotEmpty ?? false) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(24.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 16.sp,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              if (state.status != WeatherStatus.weatherLoaded) {
                return Center(
                  child: Container(
                    margin: EdgeInsets.all(24.w),
                    padding: EdgeInsets.all(16.w),
                    decoration: BoxDecoration(
                      color: locator<AppThemeColors>().white.withOpacity(0.9),
                      borderRadius: BorderRadius.circular(12.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          WeatherIcons.day_cloudy,
                          size: 100.w,
                          color: locator<AppThemeColors>().primaryColor,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Select a location to view weather data',
                          style: TextStyle(
                            color: locator<AppThemeColors>().black,
                            fontSize: 30.sp,
                            fontWeight: FontWeight.w500,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                );
              }

              return SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Current Weather Card
                      Container(
                        width: double.infinity,
                        height: 400.h,
                        padding: EdgeInsets.all(20.w),
                        decoration: BoxDecoration(
                          color:
                              locator<AppThemeColors>().white.withOpacity(0.9),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('EEEE, MMMM d').format(DateTime.now()),
                              style: TextStyle(
                                color: locator<AppThemeColors>().grey,
                                fontSize: 16.sp,
                              ),
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  WeatherIcons.day_sunny,
                                  size: 64.w,
                                  color: locator<AppThemeColors>().primaryColor,
                                ),
                                SizedBox(width: 20.w),
                                Text(
                                  '${state.hourlyData?.data?.first.temp?.round()}°',
                                  style: TextStyle(
                                    color: locator<AppThemeColors>().black,
                                    fontSize: 90.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                _buildWeatherInfo(
                                  icon: WeatherIcons.humidity,
                                  value:
                                      '${state.hourlyData?.data?.first.rhum?.round()}%',
                                  label: 'Humidity',
                                ),
                                _buildWeatherInfo(
                                  icon: WeatherIcons.strong_wind,
                                  value:
                                      '${state.hourlyData?.data?.first.wspd?.round()} km/h',
                                  label: 'Wind',
                                ),
                                _buildWeatherInfo(
                                  icon: WeatherIcons.barometer,
                                  value:
                                      '${state.hourlyData?.data?.first.pres?.round()} hPa',
                                  label: 'Pressure',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 20.h),
                      // Hourly Forecast
                      Text(
                        'Hourly Forecast',
                        style: TextStyle(
                          color: locator<AppThemeColors>().white,
                          fontSize: 40.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      if (state.hourlyData?.data?.isNotEmpty ?? false) ...[
                        SizedBox(
                          height: 230.h,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: state.hourlyData?.data?.length ?? 0,
                            itemBuilder: (context, index) {
                              final hourly = state.hourlyData?.data?[index];
                              if (hourly == null) return const SizedBox();

                              return Container(
                                width: 200.w,

                                margin: EdgeInsets.only(right: 10.w),
                                padding: EdgeInsets.all(10.w),
                                decoration: BoxDecoration(
                                  color: locator<AppThemeColors>()
                                      .white
                                      .withOpacity(0.9),
                                  borderRadius: BorderRadius.circular(15.r),
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Text(
                                      DateFormat('HH:mm').format(
                                          DateTime.parse(hourly.time ?? '')),
                                      style: TextStyle(
                                        color: locator<AppThemeColors>().grey,
                                        fontSize: 28.sp,
                                      ),
                                    ),
                                    Icon(
                                      WeatherIcons.day_sunny,
                                      size: 28.w,
                                      color: locator<AppThemeColors>()
                                          .primaryColor,
                                    ),
                                    Text(
                                      '${hourly.temp?.round()}°',
                                      style: TextStyle(
                                        color: locator<AppThemeColors>().black,
                                        fontSize: 28.sp,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                      SizedBox(height: 20.h),
                      // Daily Forecast
                      Text(
                        'Daily Forecast',
                        style: TextStyle(
                          color: locator<AppThemeColors>().white,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      if (state.dailyData?.data?.isNotEmpty ?? false) ...[
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: state.dailyData?.data?.length ?? 0,
                          itemBuilder: (context, index) {
                            final daily = state.dailyData?.data?[index];
                            if (daily == null) return const SizedBox();

                            return Container(
                              height: 200.h,
                              margin: EdgeInsets.only(bottom: 10.h),
                              padding: EdgeInsetsDirectional.symmetric(horizontal: 35.w,vertical: 12.h),
                              decoration: BoxDecoration(
                                color: locator<AppThemeColors>()
                                    .white
                                    .withOpacity(0.9),
                                borderRadius: BorderRadius.circular(15.r),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withOpacity(0.1),
                                    blurRadius: 10,
                                    offset: const Offset(0, 5),
                                  ),
                                ],
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    flex: 2,
                                    child: Text(
                                      DateFormat('EEEE').format(
                                          DateTime.parse(daily.date ?? '')),
                                      style: TextStyle(
                                        color: locator<AppThemeColors>().black,
                                        fontSize: 35.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: Icon(
                                      WeatherIcons.day_sunny,
                                      size: 34.w,
                                      color: locator<AppThemeColors>()
                                          .primaryColor,
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Text(
                                          '${daily.tmin?.round()}°',
                                          style: TextStyle(
                                            color:
                                                locator<AppThemeColors>().grey,
                                            fontSize: 30.sp,
                                          ),
                                        ),
                                        Text(
                                          ' / ',
                                          style: TextStyle(
                                            color:
                                                locator<AppThemeColors>().grey,
                                            fontSize: 16.sp,
                                          ),
                                        ),
                                        Text(
                                          '${daily.tmax?.round()}°',
                                          style: TextStyle(
                                            color:
                                                locator<AppThemeColors>().black,
                                            fontSize: 30.sp,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherInfo({
    required IconData icon,
    required String value,
    required String label,
  }) {
    return Column(
      children: [
        Icon(
          icon,
          size: 30.w,
          color: locator<AppThemeColors>().primaryColor,
        ),
        SizedBox(height: 8.h),
        Text(
          value,
          style: TextStyle(
            color: locator<AppThemeColors>().black,
            fontSize: 440.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: locator<AppThemeColors>().grey,
            fontSize: 40.sp,
          ),
        ),
      ],
    );
  }
}
