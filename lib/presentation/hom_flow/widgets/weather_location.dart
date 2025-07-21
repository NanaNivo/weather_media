import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/custom_widgets/text_translation.dart';
import 'package:weather/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:weather/presentation/hom_flow/bloc/event_home.dart';
import 'package:weather/presentation/hom_flow/bloc/state_home.dart';
import 'package:weather/app+injection/di.dart';

class WeatherLocation extends StatelessWidget {
  const WeatherLocation({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "Right clothes, no bad weather",
            style: TextStyle(
              color: locator<AppThemeColors>().textBlack,
              fontSize: 23,
            ),
          ),
          const SizedBox(height: 30),
          Text(
            "See the weather around the world and save your favourite locations",
            style: TextStyle(
              color: locator<AppThemeColors>().grey,
              fontSize: 18,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30),
          BlocBuilder<HomeBloc, HomeState>(
            bloc: locator<HomeBloc>(),
            builder: (context, state) {
              return Column(
                children: [
                  if (state.position != null) ...[
                    Text(
                      'Current Location:',
                      style: TextStyle(
                        color: locator<AppThemeColors>().grey,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${state.position!.latitude.toStringAsFixed(4)}, ${state.position!.longitude.toStringAsFixed(4)}',
                      style: TextStyle(
                        color: locator<AppThemeColors>().textBlack,
                        fontSize: 16,
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                  TextButton(
                    onPressed: () {
                      context.read<HomeBloc>().add(GetMyLocationEvent());
                    },
                    style: TextButton.styleFrom(
                      backgroundColor: locator<AppThemeColors>().lightblue,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 12,
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.location_on,
                          color: locator<AppThemeColors>().textBlack,
                        ),
                        const SizedBox(width: 8),
                        TextTranslation(
                          TranslationsKeys.MyLocation,
                          style: TextStyle(
                            color: locator<AppThemeColors>().textBlack,
                          ),
                        ),
                      ],
                    ),
                  ),
                  if (state.isLoading) ...[
                    const SizedBox(height: 16),
                    const CircularProgressIndicator(),
                  ],
                  if (state.errorMessage != null) ...[
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage!,
                      style: TextStyle(
                        color: Colors.red,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
