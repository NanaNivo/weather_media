import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:weather/presentation/hom_flow/bloc/event_home.dart';
import 'package:weather/presentation/hom_flow/bloc/state_home.dart';
import 'package:weather/core/models/weather_meta_model.dart';
import 'package:weather/core/models/weather_hourly_daily_model.dart';

class WeatherHomeScreen extends StatelessWidget {
   WeatherHomeScreen({Key? key}) : super(key: key);
   final homeBloc=locator<HomeBloc>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        bloc: homeBloc,
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          switch (state.status) {
            case WeatherStatus.initial:
              return Center(
                child: ElevatedButton(
                  onPressed: () {
                    homeBloc.add(GetMyLocationEvent());
                  },
                  child: const Text('Get Weather'),
                ),
              );

            case WeatherStatus.error:
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(state.errorMessage ?? 'An error occurred'),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        homeBloc.add(GetMyLocationEvent());
                      },
                      child: const Text('Try Again'),
                    ),
                  ],
                ),
              );

            case WeatherStatus.stationsLoaded:
              return _buildStationsList(context, state.stations?.data ?? []);

            case WeatherStatus.weatherLoaded:
              return _buildWeatherData(context, state);

            default:
              return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  Widget _buildStationsList(
      BuildContext context, List<DataWeather> stations) {
    if (stations.isEmpty) {
      return const Center(child: Text('No stations found'));
    }

    return ListView.builder(
      itemCount: stations.length,
      itemBuilder: (context, index) {
        final station = stations[index];
        return ListTile(
          title: Text(station.name?.en ?? 'Unknown Station'),
          subtitle: Text('${station.country ?? ''} - ${station.region ?? ''}'),
      //    trailing: Text('${station.na?.toStringAsFixed(1)}m'),
          onTap: () {
            context.read<HomeBloc>().add(GetStationWeatherEvent(
                  station: station.id!,
                  startDate: DateTime.now(),
                  endDate: DateTime.now().add(const Duration(days: 7)),
                ));
          },
        );
      },
    );
  }

  Widget _buildWeatherData(BuildContext context, HomeState state) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (state.dailyData != null) ...[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Daily Forecast',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.dailyData?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final day = state.dailyData!.data![index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 120,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(day.date ?? ''),
                          const SizedBox(height: 8),
                          Text('${day.tavg?.toStringAsFixed(1)}°C'),
                          if (day.tmin != null)
                            Text('L: ${day.tmin?.toStringAsFixed(1)}°C'),
                          if (day.tmax != null)
                            Text('H: ${day.tmax?.toStringAsFixed(1)}°C'),
                          Text('${day.prcp?.toStringAsFixed(1)}mm'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          if (state.hourlyData != null) ...[
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Hourly Forecast',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            SizedBox(
              height: 200,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.hourlyData?.data?.length ?? 0,
                itemBuilder: (context, index) {
                  final hour = state.hourlyData!.data![index];
                  return Card(
                    margin: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(hour.time?.split('T')[1].split(':')[0] ?? ''),
                          const SizedBox(height: 8),
                          Text('${hour.temp?.toStringAsFixed(1)}°C'),
                          Text('${hour.rhum?.toStringAsFixed(0)}%'),
                          if (hour.prcp != null && hour.prcp! > 0)
                            Text('${hour.prcp?.toStringAsFixed(1)}mm'),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                context.read<HomeBloc>().add(GetMyLocationEvent());
              },
              child: const Text('Update Location'),
            ),
          ),
        ],
      ),
    );
  }
}
