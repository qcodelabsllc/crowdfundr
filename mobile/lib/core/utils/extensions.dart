import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:lottie/lottie.dart';
import 'package:mobile/generated/assets.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:shared_utils/shared_utils.dart';
import 'package:tinycolor2/tinycolor2.dart';

import 'constants.dart';

extension BuildContextX on BuildContext {
  AppLocalizations get localizer => AppLocalizations.of(this)!;

  bool get isDarkMode => theme.brightness == Brightness.dark;

  void showFeatureUnderDevSheet() async => showBarModalBottomSheet(
        context: this,
        backgroundColor: colorScheme.background,
        useRootNavigator: true,
        bounce: true,
        builder: (context) => AnimatedColumn(
          animateType: AnimateType.slideUp,
          children: [
            const SizedBox(height: 24),
            Lottie.asset(Assets.animUnderDev,
                    repeat: false, height: height * 0.2, width: width * 0.7)
                .bottom(24),
            EmptyContentPlaceholder(
                title: localizer.underDevelopment,
                subtitle: localizer.underDevelopmentSubhead),
            SafeArea(
              top: false,
              child: AppRoundedButton(
                      text: localizer.okay,
                      layoutSize: LayoutSize.standard,
                      onTap: context.navigator.pop)
                  .top(40),
            ),
          ],
        ),
      );

  /// used for custom error messages / prompts
  void showMessageDialog(
    String message, {
    bool showAsError = true,
    String? title,
    String? actionLabel,
    String? animationAsset,
    VoidCallback? onTap,
  }) async {
    if (showAsError) {
      await showBarModalBottomSheet(
        context: this,
        backgroundColor: colorScheme.background,
        useRootNavigator: true,
        bounce: true,
        builder: (context) => AnimatedColumn(
          animateType: AnimateType.slideRight,
          children: [
            Lottie.asset(
                    animationAsset ??
                        (showAsError ? Assets.animError : Assets.animSuccess),
                    frameRate: FrameRate(90),
                    repeat: false,
                    fit: BoxFit.fitHeight,
                    height: height * 0.1,
                    width: width * 0.7)
                .bottom(24),
            EmptyContentPlaceholder(
                title: title ?? localizer.errorMessage, subtitle: message),
            SafeArea(
              top: false,
              child: AppRoundedButton(
                text: actionLabel ?? localizer.okay,
                layoutSize: LayoutSize.standard,
                onTap: () {
                  context.navigator.pop();
                  onTap?.call();
                },
              ).top(40),
            ),
          ],
        ).top(24),
      );
    } else {
      await showCupertinoModalBottomSheet(
        context: this,
        backgroundColor: colorScheme.background,
        useRootNavigator: true,
        isDismissible: false,
        enableDrag: false,
        bounce: true,
        builder: (context) => AnimatedColumn(
          animateType: AnimateType.slideRight,
          children: [
            Lottie.asset(Assets.animSuccess,
                    frameRate: FrameRate(90),
                    repeat: false,
                    fit: BoxFit.fitHeight,
                    height: height * 0.1,
                    width: width * 0.7)
                .bottom(24),
            EmptyContentPlaceholder(
                title: title ?? localizer.successMessage, subtitle: message),
            SafeArea(
              top: false,
              child: AppRoundedButton(
                text: actionLabel ?? localizer.okay,
                layoutSize: LayoutSize.standard,
                onTap: () {
                  context.navigator.pop();
                  onTap?.call();
                },
              ).top(40),
            ),
          ],
        ).top(24),
      );
    }
  }

  // Future<bool?> showDeleteAccountSheet(Account account) async {
  //   final authBloc = AuthCubit();
  //   var loading = false,
  //       acceptTerms = false,
  //       acceptSubscriptionDeletion = false,
  //       acceptDataDeletion = false;
  //
  //   return await showCupertinoModalBottomSheet(
  //     context: this,
  //     builder: (context) => StatefulBuilder(
  //       builder: (context, setState) => BlocConsumer(
  //         bloc: authBloc,
  //         listener: (context, state) {
  //           setState(() => loading = state is LoadingState);
  //
  //           if (state is SuccessState<Empty>) {
  //             context.navigator.pop(true);
  //           }
  //         },
  //         builder: (context, state) => Material(
  //           type: MaterialType.transparency,
  //           color: colorScheme.background,
  //           elevation: 0,
  //           child: ListView(
  //             shrinkWrap: true,
  //             controller: ModalScrollController.of(context),
  //             padding: EdgeInsets.fromLTRB(
  //                 20, 24, 20, mediaQuery.padding.bottom + 24),
  //             children: [
  //               Lottie.asset(Assets.animUserLeaving,
  //                       height: context.height * 0.15)
  //                   .bottom(16),
  //               context.localizer.deleteAccount
  //                   .subtitle1(context, weight: FontWeight.w600)
  //                   .centered(),
  //               context.localizer.deleteAccountDesc
  //                   .subtitle2(context,
  //                       emphasis: kEmphasisMedium, alignment: TextAlign.center)
  //                   .centered()
  //                   .top(8),
  //               if (state is ErrorState<String>) ...{
  //                 Container(
  //                   padding: const EdgeInsets.symmetric(
  //                       horizontal: 16, vertical: 12),
  //                   margin: EdgeInsets.only(
  //                       top: 12, bottom: context.mediaQuery.padding.bottom),
  //                   decoration: BoxDecoration(
  //                     color: context.colorScheme.error,
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   alignment: Alignment.center,
  //                   child: Column(
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       state.failure.caption(context,
  //                           emphasis: kEmphasisMedium,
  //                           alignment: TextAlign.center,
  //                           color: context.colorScheme.onError),
  //                     ],
  //                   ),
  //                 ),
  //               },
  //               Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //                 margin: const EdgeInsets.only(top: 20, bottom: 16),
  //                 decoration: BoxDecoration(
  //                   color: context.colorScheme.surface,
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: ListTile(
  //                   contentPadding: EdgeInsets.zero,
  //                   leading: HeroIcon(HeroIcons.adjustmentsHorizontal,
  //                       color: context.colorScheme.onSurface, size: 20),
  //                   minLeadingWidth: 20,
  //                   title: localizer.deletePreferences.subtitle2(context,
  //                       color: context.colorScheme.onSurface),
  //                   subtitle: localizer.deletePreferencesSubhead.caption(
  //                       context,
  //                       emphasis: kEmphasisMedium,
  //                       color: context.colorScheme.onSurface),
  //                   trailing: CupertinoCheckbox(
  //                     value: acceptDataDeletion,
  //                     activeColor: context.colorScheme.secondary,
  //                     checkColor: context.colorScheme.onSecondary,
  //                     onChanged: (value) =>
  //                         setState(() => acceptDataDeletion = value!),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //                 margin: const EdgeInsets.only(bottom: 16),
  //                 decoration: BoxDecoration(
  //                   color: context.colorScheme.surface,
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: ListTile(
  //                   contentPadding: EdgeInsets.zero,
  //                   leading: HeroIcon(HeroIcons.users,
  //                       color: context.colorScheme.onSurface, size: 20),
  //                   minLeadingWidth: 20,
  //                   title: localizer.deleteSubscriptions.subtitle2(context,
  //                       color: context.colorScheme.onSurface),
  //                   subtitle: localizer.deleteSubscriptionsSubhead.caption(
  //                       context,
  //                       emphasis: kEmphasisMedium,
  //                       color: context.colorScheme.onSurface),
  //                   trailing: CupertinoCheckbox(
  //                     value: acceptSubscriptionDeletion,
  //                     activeColor: context.colorScheme.secondary,
  //                     checkColor: context.colorScheme.onSecondary,
  //                     onChanged: (value) =>
  //                         setState(() => acceptSubscriptionDeletion = value!),
  //                   ),
  //                 ),
  //               ),
  //               Container(
  //                 padding:
  //                     const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  //                 decoration: BoxDecoration(
  //                   color: context.colorScheme.surface,
  //                   borderRadius: BorderRadius.circular(8),
  //                 ),
  //                 child: ListTile(
  //                   contentPadding: EdgeInsets.zero,
  //                   leading: Icon(TablerIcons.file_description,
  //                       color: context.colorScheme.onSurface, size: 20),
  //                   minLeadingWidth: 20,
  //                   title: localizer.termOfUse.subtitle2(context,
  //                       color: context.colorScheme.onSurface),
  //                   subtitle: localizer.termOfUseSubhead.caption(context,
  //                       emphasis: kEmphasisMedium,
  //                       color: context.colorScheme.onSurface),
  //                   trailing: CupertinoCheckbox(
  //                     value: acceptTerms,
  //                     activeColor: context.colorScheme.secondary,
  //                     checkColor: context.colorScheme.onSecondary,
  //                     onChanged: (value) =>
  //                         setState(() => acceptTerms = value!),
  //                   ),
  //                 ),
  //               ),
  //               SizedBox(height: context.height * 0.1),
  //               AppRoundedButton(
  //                 text: localizer.signOutAndDeleteAccount,
  //                 onTap: authBloc.deleteAccount,
  //                 enabled: !loading &&
  //                     acceptTerms &&
  //                     acceptSubscriptionDeletion &&
  //                     acceptDataDeletion,
  //               ),
  //               if (loading) ...{
  //                 const CircularProgressIndicator.adaptive()
  //                     .centered()
  //                     .fillMaxHeight(context, 0.15)
  //                     .bottom(mediaQuery.padding.bottom + 12),
  //               } else ...{
  //                 TextButton(
  //                   onPressed: navigator.pop,
  //                   child: localizer.cancel.button(context),
  //                 ).top(12).bottom(mediaQuery.padding.bottom + 12),
  //               },
  //             ],
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  String getLocaleNameFromCode(String code) {
    switch (code) {
      case 'fr':
        return localizer.french;
      default:
        return localizer.english;
    }
  }
}

extension ScrollX on ScrollController {
  bool get isAtBottom => offset >= position.maxScrollExtent;

  void scrollToBottom() => SchedulerBinding.instance.addPostFrameCallback((_) {
        animateTo(position.maxScrollExtent,
            duration: kDurationFast, curve: Curves.easeOut);
      });

  void scrollToTop() => SchedulerBinding.instance.addPostFrameCallback((_) {
        animateTo(position.minScrollExtent,
            duration: kDurationFast, curve: Curves.easeOut);
      });
}

extension ColorX on Color {
  // Generate a list of color shades based on the provided hex color
  List<Color> generateColorShades([int numShades = 5]) {
    final Color baseColor = TinyColor.fromColor(this).color;
    final List<Color> shades = [];
    final double step = 1.0 / (numShades - 1);

    for (double i = 0.0; i <= 1.0; i += step) {
      final Color shade =
          TinyColor.fromColor(baseColor).darken((i * 100).toInt()).color;
      shades.add(shade);
    }

    return shades;
  }
}

extension StringX on String {
  bool get isNumeric => num.tryParse(this) != null;
}
