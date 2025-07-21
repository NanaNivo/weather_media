import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:weather/core/navigation/routes.dart';

import '../../../app+injection/di.dart';
import '../../../core/helper/screen_util/screen_helper.dart';
import '../../../core/resources/colors.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import '../../custom_widgets/animation/fade_tans_animation.dart';

class SplashPage extends StatefulWidget {
  static String routeName = 'SplashPage';

  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage>
    with SingleTickerProviderStateMixin {
  final Duration _animationDuration =
      const Duration(seconds: 1, milliseconds: 1);

  late Animation<double> _animation;
  late Animation<double> _animationRounded;
  late AnimationController _animationController;

  bool isWordsAnimationFinished = false;
  bool isShapesAnimationFinished = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: _animationDuration,
      lowerBound: 0.2,
      upperBound: 1.0,
    );

    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.fastOutSlowIn,
    );
    _animation.addStatusListener((AnimationStatus state) {
      if (state == AnimationStatus.completed) {
        isShapesAnimationFinished = true;
        setState(() {});
        // Navigate after animation completes
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            context.go(RoutesPath.homePage);
          }
        });
      }
    });

    _animationRounded = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInCubic);

    Future.delayed(const Duration(milliseconds: 300), () {
      _animationController.forward();
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreensHelper(context);

    return Scaffold(
      body: SafeArea(
        left: false,
        top: false,
        right: false,
        bottom: true,
        child: Container(
          //  color: locator<AppThemeColors>().background,
          child: Stack(
            clipBehavior: Clip.hardEdge,
            children: <Widget>[
              // Positioned.fill(
              //   top: MediaQuery.of(context).size.height * 0.0001,
              //   child: _getMiddleContents(),
              // ),
              Center(
                child: FlutterLogo(
                  size: ScreenUtil().setWidth(500), // adjust the size as needed
                ),
              ),
              Positioned(
                width: MediaQuery.of(context).size.width,
                bottom: ScreenUtil().setHeight(30),
                child: _getBottomLoader(),
              )
            ],
          ),
        ),
      ),
    );
  } // end build

  Widget _getBottomLoader() {
    return Column(
      children: <Widget>[
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.4,
            ),
            child: AnimatedOpacity(
              opacity: isShapesAnimationFinished ? 1.0 : 0.0,
              duration: _animationDuration,
              child: LinearProgressIndicator(
                backgroundColor: Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(
                    locator<AppThemeColors>().secondaryColor),
              ),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(30),
        ),
        RichText(
          text: TextSpan(
            text: 'Powered by ',
            style: TextStyle(
                fontSize: ScreenUtil().setSp(32),
                color: locator<AppThemeColors>().black,
                fontWeight: FontWeight.w500),
            children: <TextSpan>[
              TextSpan(
                  text: 'Test',
                  style: TextStyle(
                      color: locator<AppThemeColors>().black,
                      fontWeight: FontWeight.w500)),
            ],
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    // _bloc.close();
    super.dispose();
  }
}
