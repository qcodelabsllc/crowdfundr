import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:heroicons/heroicons.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/constants.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/crowdfundr/presentation/widgets/project.tile.dart';
import 'package:mobile/generated/assets.dart';
import 'package:mobile/generated/protos/category.pb.dart';
import 'package:mobile/generated/protos/user.pb.dart';
import 'package:shared_utils/shared_utils.dart';

part 'tabs/donations.dart';

part 'tabs/projects.dart';

part 'tabs/settings.dart';

part 'tabs/stats.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _navIcons = [
    HeroIcons.rectangleStack, // home
    HeroIcons.userGroup, // donations
    HeroIcons.rocketLaunch, // projects
    HeroIcons.userCircle, // settings
  ];
  var _currentIndex = 0;

  @override
  Widget build(BuildContext context) => Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: const [
            _StatsTab(),
            _DonationsTab(),
            _ProjectsTab(),
            _SettingsTab(),
          ],
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(
              bottom: context.mediaQuery.padding.bottom + 12,
              top: 20,
              left: 12,
              right: 12),
          decoration: BoxDecoration(color: context.colorScheme.surfaceVariant),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: _navIcons.map(
              (icon) {
                var index = _navIcons.indexOf(icon),
                    active = index == _currentIndex;
                return GestureDetector(
                  onTap: () => setState(() => _currentIndex = index),
                  child: HeroIcon(
                    icon,
                    color: active
                        ? context.colorScheme.onBackground
                        : context.theme.disabledColor,
                  ),
                );
              },
            ).toList(),
          ),
        ),
      );
}
