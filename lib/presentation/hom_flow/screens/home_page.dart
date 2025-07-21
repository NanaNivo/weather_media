import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/app+injection/di.dart';
import 'package:weather/core/localization/app_lang.dart';
import 'package:weather/core/navigation/routes.dart';
import 'package:weather/core/resources/colors.dart';
import 'package:weather/core/resources/constants.dart';
import 'package:weather/presentation/custom_widgets/text_translation.dart';
import 'package:weather/presentation/hom_flow/bloc/navigation_cubit.dart';
import 'package:weather/presentation/hom_flow/bloc/navigation_state.dart';

class NavigationController {
  final BuildContext context;

  NavigationController(this.context);

  List<NavigationItem> get navigationItems => [
        NavigationItem(
          title: TranslationsKeys.MyLocation.tr(context),
          enabledIcon: ImagesKeys.location,
          disabledIcon: ImagesKeys.location,
          page: Container(
            child: Text(
              TranslationsKeys.MyLocation.tr(context),
              style: TextStyle(color: locator<AppThemeColors>().primaryColor),
            ),
          ),
        ),
        NavigationItem(
          title: TranslationsKeys.Weather.tr(context),
          enabledIcon: ImagesKeys.weather,
          disabledIcon: ImagesKeys.weather,
          page: Container(
            child: Text(
              TranslationsKeys.Weather.tr(context),
              style: TextStyle(color: locator<AppThemeColors>().primaryColor),
            ),
          ),
        ),
        NavigationItem(
          title: TranslationsKeys.setting.tr(context),
          enabledIcon: ImagesKeys.settings,
          disabledIcon: ImagesKeys.settings,
          page: Container(
            child: Text(
              TranslationsKeys.setting.tr(context),
              style: TextStyle(color: locator<AppThemeColors>().primaryColor),
            ),
          ),
        ),
      ];

  int _currentIndex = 0;

  NavigationItem get currentNavigationItem => navigationItems[_currentIndex];

  int get currentIndex => _currentIndex;

  List<BottomNavigationBarItem> get bottomNavigationBarItems => navigationItems
      .map((item) => BottomNavigationBarItem(
            icon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 5.h),
                  child: Container(
                    height: 90.h,
                    child: SvgPicture.asset(
                      item.disabledIcon,
                      colorFilter: ColorFilter.mode(
                        locator<AppThemeColors>().grey,
                        BlendMode.srcIn,
                      ),
                      // height: 100.h,
                      // width: 100.w,
                    ),
                  ),
                ),
                Text(
                  item.title,
                  style: TextStyle(
                      color: locator<AppThemeColors>().grey,
                      fontSize: 20.sp,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
            activeIcon: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: EdgeInsetsDirectional.only(top: 5.h),
                  child: Container(
                    height: 90.h,
                    child: SvgPicture.asset(
                      item.enabledIcon,
                      colorFilter: ColorFilter.mode(
                        locator<AppThemeColors>().primaryColor,
                        BlendMode.srcIn,
                      ),
                      //  height: 20.h,
                    ),
                  ),
                ),
                Text(
                  item.title,
                  style: TextStyle(
                      color: locator<AppThemeColors>().primaryColor,
                      fontSize: 20.sp,
                      overflow: TextOverflow.ellipsis),
                )
              ],
            ),
            label: '',
          ))
      .toList();

  Widget get currentPage => currentNavigationItem.page;

  void navigateToPage(int index) {
    _currentIndex = index;
  }
}

class NavigationItem {
  final String title;
  final String enabledIcon;
  final String disabledIcon;
  final Widget page;

  NavigationItem(
      {required this.title,
      required this.enabledIcon,
      required this.disabledIcon,
      required this.page});
}

class HomePage extends StatefulWidget {
  final Widget navigationShell;
  const HomePage({Key? key, required this.navigationShell}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final NavigationController navigationController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    navigationController = NavigationController(context);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: locator<NavigationCubit>(),
      child: BlocBuilder<NavigationCubit, NavigationState>(
        builder: (context, state) {
          return Scaffold(
            body: SafeArea(
              child: widget.navigationShell,
            ),
            bottomNavigationBar: Theme(
              data: Theme.of(context).copyWith(
                canvasColor: locator<AppThemeColors>().white,
              ),
              child: BottomNavigationBar(
                selectedFontSize: 0,
                unselectedFontSize: 0,
                backgroundColor: locator<AppThemeColors>().white,
                type: BottomNavigationBarType.fixed,
                items: navigationController.bottomNavigationBarItems,
                currentIndex: state.currentIndex,
                onTap: (index) =>
                    context.read<NavigationCubit>().setCurrentIndex(
                          index,
                          GoRouter.of(context),
                        ),
              ),
            ),
          );
        },
      ),
    );
  }
}
