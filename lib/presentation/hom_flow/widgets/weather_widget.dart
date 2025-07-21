import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/helper/util/Globals.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:weather/presentation/hom_flow/bloc/state_home.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

class WeatherWidget extends StatelessWidget {
  const WeatherWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeBloc, HomeState>(
      bloc: locator<HomeBloc>(),
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.errorMessage != null) {
          return Center(
            child: Text(
              state.errorMessage!,
              style: const TextStyle(color: Colors.red),
            ),
          );
        }

        if (state.status != WeatherStatus.weatherLoaded) {
          return const Center(
            child: Text('Select a location to view weather data'),
          );
        }

        return SingleChildScrollView(
          child: Column(
            children: [
              // Current Weather
              Container(
                width: ScreenUtil().screenWidth,
                height: ScreenUtil().setHeight(600),
                margin: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(80),
                  vertical: ScreenUtil().setHeight(20),
                ),
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
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      DateFormat('E, d MMM').format(DateTime.now()),
                      style: TextStyle(
                        color: locator<AppThemeColors>().grey,
                        fontSize: ScreenUtil().setSp(50),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state.hourlyData?.data?.isNotEmpty == true) ...[
                      Text(
                        '${state.hourlyData!.data!.first.temp?.toStringAsFixed(1)}°C',
                        style: TextStyle(
                          color: locator<AppThemeColors>().textBlack,
                          fontSize: ScreenUtil().setSp(90),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Humidity: ${state.hourlyData!.data!.first.rhum?.toStringAsFixed(0)}%',
                        style: TextStyle(
                          color: locator<AppThemeColors>().grey,
                          fontSize: ScreenUtil().setSp(40),
                        ),
                      ),
                    ],
                  ],
                ),
              ),

              // Hourly Forecast
              if (state.hourlyData?.data?.isNotEmpty == true) ...[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(80),
                    vertical: ScreenUtil().setHeight(20),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Hourly Forecast',
                      style: TextStyle(
                        color: locator<AppThemeColors>().textBlack,
                        fontSize: ScreenUtil().setSp(50),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(300),
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: state.hourlyData!.data!.length,
                    padding: EdgeInsets.symmetric(
                      horizontal: ScreenUtil().setWidth(80),
                    ),
                    itemBuilder: (context, index) {
                      final hourData = state.hourlyData!.data![index];
                      return Container(
                        width: ScreenUtil().setWidth(200),
                        margin: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                        ),
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
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              DateFormat('HH:mm').format(
                                DateTime.parse(hourData.time!),
                              ),
                              style: TextStyle(
                                color: locator<AppThemeColors>().grey,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '${hourData.temp?.toStringAsFixed(1)}°C',
                              style: TextStyle(
                                color: locator<AppThemeColors>().textBlack,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '${hourData.rhum?.toStringAsFixed(0)}%',
                              style: TextStyle(
                                color: locator<AppThemeColors>().grey,
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],

              // Daily Forecast
              if (state.dailyData?.data?.isNotEmpty == true) ...[
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(80),
                    vertical: ScreenUtil().setHeight(20),
                  ),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Daily Forecast',
                      style: TextStyle(
                        color: locator<AppThemeColors>().textBlack,
                        fontSize: ScreenUtil().setSp(50),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.dailyData!.data!.length,
                  padding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(80),
                  ),
                  itemBuilder: (context, index) {
                    final dayData = state.dailyData!.data![index];
                    return Container(
                      margin: EdgeInsets.only(
                        bottom: ScreenUtil().setHeight(20),
                      ),
                      padding: EdgeInsets.all(ScreenUtil().setWidth(40)),
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
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            DateFormat('E, MMM d').format(
                              DateTime.parse(dayData.date!),
                            ),
                            style: TextStyle(
                              color: locator<AppThemeColors>().textBlack,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Row(
                            children: [
                              Text(
                                '${dayData.tmin?.toStringAsFixed(1)}°',
                                style: TextStyle(
                                  color: locator<AppThemeColors>().grey,
                                ),
                              ),
                              Text(
                                ' / ',
                                style: TextStyle(
                                  color: locator<AppThemeColors>().grey,
                                ),
                              ),
                              Text(
                                '${dayData.tmax?.toStringAsFixed(1)}°',
                                style: TextStyle(
                                  color: locator<AppThemeColors>().textBlack,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
