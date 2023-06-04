import 'package:flutter/material.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/common/presentation/pages/tutorial.dart';
import 'package:mobile/features/crowdfundr/presentation/pages/home.dart';
import 'package:mobile/generated/assets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_utils/shared_utils.dart';

final class AppRouterConfig {
  static Route<dynamic>? setupRoutes(RouteSettings settings) {
    // traverse routes
    switch (settings.name) {
      case AppRouter.initialRoute:
        return _initialRouteBuilder(settings);
      // case AppRouter.unsupportedDeviceRoute:
      //   return MaterialWithModalsPageRoute(
      //       builder: (_) => const UnsupportedDevicePage(), settings: settings);
      // case AppRouter.noInternetRoute:
      //   return MaterialWithModalsPageRoute(
      //       builder: (_) => const NoInternetPage(), settings: settings);
      case AppRouter.homeRoute:
        return MaterialWithModalsPageRoute(
            builder: (_) => const HomePage(), settings: settings);
      // case AppRouter.phoneVerificationRoute:
      //   return MaterialWithModalsPageRoute(
      //       builder: (_) => PhoneNumberVerificationPage(
      //           phoneNumber: settings.arguments.toString()),
      //       settings: settings);
      // case AppRouter.signUpRoute:
      //   return MaterialWithModalsPageRoute(
      //       builder: (_) => const RegisterAccountPage(), settings: settings);
      // case AppRouter.signInWithRoute:
      //   return MaterialWithModalsPageRoute(
      //       builder: (_) => const LoginPage(), settings: settings);
      // case AppRouter.resetPasswordRoute:
      //   return MaterialWithModalsPageRoute(
      //       builder: (_) => const ResetPasswordPage(), settings: settings);
      // case AppRouter.welcomeRoute:
      //   return MaterialWithModalsPageRoute(
      //       builder: (_) => const SocialAuthPage(), settings: settings);
      case AppRouter.tutorialRoute:
        return MaterialWithModalsPageRoute(
            builder: (_) => const TutorialPage(), settings: settings);
    }

    return MaterialWithModalsPageRoute(
      builder: (context) => Scaffold(
        extendBodyBehindAppBar: true,
        appBar: AppBar(
            elevation: 0, backgroundColor: context.colorScheme.background),
        body: EmptyContentPlaceholder(
          icon: TablerIcons.building_factory,
          title: context.localizer.underDevelopment,
          subtitle: context.localizer.underDevelopmentSubhead,
        ),
      ),
    );
  }

  static Route<dynamic> _initialRouteBuilder(RouteSettings? settings) =>
      MaterialWithModalsPageRoute(
          builder: (context) {
            kUseDefaultOverlays(context,
                statusBarBrightness: context.theme.brightness);
            return Scaffold(
              body: Builder(
                builder: (context) => AnimatedColumn(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Assets.imgAppLogo.asAssetImage(
                        size: context.width * 0.3, fit: BoxFit.contain),
                    const CircularProgressIndicator.adaptive().top(40),
                  ],
                ).centered(),
              ),
            );
          },
          settings: settings);
}

sealed class AppRouter {
  static const initialRoute = '/';
  static const tutorialRoute = '/walkthrough';
  static const welcomeRoute = '/welcome'; // todo
  static const homeRoute = '/home'; // todo
  static const signUpRoute = '/auth/sign-up'; // todo
  static const signInWithRoute = '/auth/sign-in'; // todo
  static const resetPasswordRoute = '/auth/sign-in/reset-password'; // todo
  static const phoneVerificationRoute = '/auth/phone-verification'; // todo
  static const projectDetailsRoute = '/projects/details'; // todo
  static const donateRoute = '/donations/project'; // todo
  static const editProfileRoute = '/edit-profile'; // todo
  static const profileRoute = '/profile'; // todo
  static const notificationsRoute = '/notifications'; // todo
  static const manageSubscriptionRoute = '/auth/manage-subscription'; // todo
  static const unsupportedDeviceRoute = '/states/unsupported-device'; // todo
  static const noInternetRoute = '/states/no-internet'; // todo
  static const categoryDetailsRoute = '/category/details'; // todo
}
