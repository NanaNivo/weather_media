import 'package:dio/dio.dart';

//import 'package:ecommerce_template/domain/repositories/auth_repository.dart';

import 'package:get_it/get_it.dart';

import 'package:weather/core/api/auth_interceptor.dart';
import 'package:weather/core/mediators/bloc_hub/concrete_hub.dart';
import 'package:weather/core/mediators/bloc_hub/hub.dart';
import 'package:weather/core/mediators/bloc_hub/members_key.dart';
import 'package:weather/core/services/session_manager.dart';
import 'package:weather/core/services/theme_store.dart';
import 'package:weather/core/services/location_service.dart';
import 'package:weather/core/usecases/app_theme_usecases.dart';
import 'package:weather/presentation/façades/app_facade.dart';
import 'package:weather/presentation/hom_flow/bloc/bloc_home.dart';
import 'package:weather/presentation/hom_flow/bloc/navigation_cubit.dart';
import 'package:weather/presentation/hom_flow/dataSource/data_source_home_imp.dart';
import 'package:weather/presentation/hom_flow/repository/repository_home.dart';
import 'package:weather/presentation/hom_flow/repository/repository_home_Imp.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_get_location.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_weather_meta.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_weather_daily.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_weather_hourly.dart';
import 'package:weather/presentation/hom_flow/usecase/usecase_nearby_stations.dart';
import 'package:weather/core/blocs/application_bloc/app_bloc.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/helper/util/material_colore_converter.dart';

final locator = GetIt.instance;

Future<void> setUpLocator() async {
  // Register AppThemeColors
  locator.registerFactory<AppThemeColors>(
    () => ThemeFactory.colorModeFactory(AppThemeMode.light),
  );

  // Register BlocHub
  locator.registerLazySingleton<BlocHub>(() => ConcreteHub());

  // Register Navigation Cubit
  locator.registerLazySingleton<NavigationCubit>(() => NavigationCubit());

  // Register Theme Services
  locator.registerLazySingleton<ThemeStore>(() => ThemeStore());
  locator.registerLazySingleton<SetAppThemeUseCase>(
      () => SetAppThemeUseCase(locator<ThemeStore>()));
  locator.registerLazySingleton<GetAppThemeUseCase>(
      () => GetAppThemeUseCase(locator<ThemeStore>()));

  // Register Session Manager
  locator.registerLazySingleton<SessionManager>(() => SessionManager());

  // Register Location Service
  locator.registerLazySingleton<LocationService>(() => LocationService());

  // Register App Facade
  locator.registerLazySingleton<AppUiFacade>(() => AppUiFacade(
        getAppThemeUseCase: locator<GetAppThemeUseCase>(),
        setAppThemeUseCase: locator<SetAppThemeUseCase>(),
        sessionManager: locator<SessionManager>(),
      ));

  // Register App Bloc
  locator.registerLazySingleton<AppBloc>(
      () => AppBloc(appUiFacade: locator<AppUiFacade>()));

  // Register Network Components
  locator.registerFactory<Dio>(() => Dio());
  // locator.registerLazySingleton<AuthInterceptor>(
  //     () => AuthInterceptor(locator<SessionManager>(), locator<Dio>()));

  // Register Data Sources
  locator.registerLazySingleton(() => DataSourceHomeImp());
  locator.registerLazySingleton<RepositoryHome>(() => HomeRepositoryImp(
      locator<DataSourceHomeImp>(), locator<LocationService>()));

  // Register Use Cases
  locator.registerLazySingleton<WeatherDailyUseCase>(
      () => WeatherDailyUseCase(homeRepository: locator<RepositoryHome>()));
  locator.registerLazySingleton<WeatherHourlyUseCase>(
      () => WeatherHourlyUseCase(homeRepository: locator<RepositoryHome>()));
  locator.registerLazySingleton<LocationUseCase>(
      () => LocationUseCase(homeRepository: locator<RepositoryHome>()));
  locator.registerLazySingleton<NearbyStationsUseCase>(
    () => NearbyStationsUseCase(locator<RepositoryHome>()),
  );

  // Register Home Bloc
  locator.registerLazySingleton<HomeBloc>(() => HomeBloc(
        locationUseCase: locator<LocationUseCase>(),
        weatherDailyUseCase: locator<WeatherDailyUseCase>(),
        weatherHourlyUseCase: locator<WeatherHourlyUseCase>(),
        nearbyStationsUseCase: locator<NearbyStationsUseCase>(),
      ));

  // Register Bloc Hub Members
  locator<BlocHub>().registerByName(locator<AppBloc>(), MembersKeys.appBloc);
}
