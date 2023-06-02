import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/theme.dart';
import 'package:shared_utils/shared_utils.dart';

class CrowdfundrApp extends StatefulWidget {
  const CrowdfundrApp({Key? key}) : super(key: key);

  @override
  State<CrowdfundrApp> createState() => _CrowdfundrAppState();
}

class _CrowdfundrAppState extends State<CrowdfundrApp> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) => DismissKeyboard(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Crowdfundr',
          theme: context.useLightTheme,
          darkTheme: context.useDarkTheme,
          themeMode: ThemeMode.system,
          onGenerateRoute: AppRouterConfig.setupRoutes,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          navigatorKey: _navigatorKey,
          scrollBehavior: const CupertinoScrollBehavior(),
        ),
      );
}
