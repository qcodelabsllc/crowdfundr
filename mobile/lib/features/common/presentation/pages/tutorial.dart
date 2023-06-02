import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:heroicons/heroicons.dart';
import 'package:mobile/core/routing/router.dart';
import 'package:mobile/core/utils/actions.dart';
import 'package:mobile/core/utils/extensions.dart';
import 'package:mobile/features/common/presentation/widgets/auth.button.dart';
import 'package:mobile/features/onboarding/presentation/manager/auth_cubit.dart';
import 'package:mobile/generated/assets.dart';
import 'package:shared_utils/shared_utils.dart';

class TutorialPage extends StatefulWidget {
  const TutorialPage({super.key});

  @override
  State<TutorialPage> createState() => _TutorialPageState();
}

class _TutorialPageState extends State<TutorialPage> {
  final _authBloc = AuthCubit();
  var _loading = false;

  @override
  Widget build(BuildContext context) {
    kUseDefaultOverlays(context, statusBarBrightness: context.theme.brightness);
    return BlocListener(
      bloc: _authBloc,
      listener: (context, state) {
        if (!mounted) return;

        setState(() => _loading = state is LoadingState);

        if (state is ErrorState<String>) {
          context.showMessageDialog(state.failure);
        }
      },
      child: LoadingIndicator(
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
                onPressed: () =>
                    context.navigator.pushNamed(AppRouter.homeRoute),
                label: context.localizer.signInLater.button(context),
                icon: HeroIcon(HeroIcons.userCircle,
                    color: context.colorScheme.onBackground),
              ).bottom(20),
              GestureDetector(
                onTap: openTwitterProfile,
                child: context.localizer.appDevTeam
                    .caption(context,
                        emphasis: kEmphasisLow,
                        alignment: TextAlign.center,
                        color: context.colorScheme.onBackground)
                    .bottom(context.mediaQuery.padding.bottom + 8),
              ),
            ],
          ).horizontal(20).centered(),
        ),
      ),
    );
  }
}
