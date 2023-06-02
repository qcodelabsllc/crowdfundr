import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/common/presentation/widgets/auth.button.dart';
import 'package:mobile/generated/assets.dart';
import 'package:shared_utils/shared_utils.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context, statusBarBrightness: context.theme.brightness);
    return LoadingIndicator(
      isLoading: _loading,
      loadingAnimIsAsset: true,
      lottieAnimResource: Assets.animLoading,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Assets.imgAppLogo.asAssetImage(width: context.width * 0.3),
            context.localizer.appName.h6(context).top(24),
            context.localizer.appDescLong
                .subtitle2(context,
                    emphasis: kEmphasisMedium, alignment: TextAlign.center)
                .top(8)
                .bottom(40),
            AuthButton(
                label: context.localizer.signInWithGoogle,
                brandIcon: Assets.brandBrandGoogle),
            AuthButton(
                label: context.localizer.signInWithApple,
                brandIcon: context.isDarkMode
                    ? Assets.brandBrandApple
                    : Assets.brandBrandAppleLight),
            AuthButton(
                label: context.localizer.signInWithEmail,
                brandIcon: Assets.brandBrandEmail,
                iconTint: context.colorScheme.onPrimary,
                onPressed: () =>
                    context.navigator.pushNamed(AppRouter.signInWithRoute),
                outlined: false,
                loading: _loading),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Expanded(child: Divider(endIndent: 24, indent: 24)),
                context.localizer.orText.caption(context),
                const Expanded(child: Divider(endIndent: 24, indent: 24)),
              ],
            ).vertical(12),
            TextButton.icon(
              onPressed: () => context.navigator.pushNamed(AppRouter.homeRoute),
              label: context.localizer.signInLater.button(context),
              icon: const HeroIcon(HeroIcons.userCircle),
            ).bottom(20),
            context.localizer.appDevTeam.caption(context,
                emphasis: kEmphasisLow,
                alignment: TextAlign.center,
                color: context.colorScheme.onSurface).bottom(context.mediaQuery.padding.bottom + 8),
          ],
        ).horizontal(20).centered(),
      ),
    );
  }
}
