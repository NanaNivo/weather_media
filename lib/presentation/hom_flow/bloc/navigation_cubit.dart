import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/core/navigation/routes.dart';
import 'navigation_state.dart';

class NavigationCubit extends Cubit<NavigationState> {
  NavigationCubit() : super(const NavigationState());

  void setCurrentIndex(int index, GoRouter router) {
    emit(state.copyWith(currentIndex: index));

    switch (index) {
      case 0:
        router.go(RoutesPath.location);
        break;
      case 1:
        router.go(RoutesPath.homePage);
        break;
      case 2:
        router.go(RoutesPath.setting);
        break;
    }
  }
}
