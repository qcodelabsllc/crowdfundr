import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_utils/shared_utils.dart';

class AuthButton extends StatelessWidget {
  final String label;
  final String brandIcon;
  final bool loading;
  final VoidCallback? onPressed;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool outlined;

  const AuthButton({
    Key? key,
    required this.label,
    required this.brandIcon,
    this.loading = false,
    this.outlined = true,
    this.onPressed,
    this.backgroundColor,
    this.foregroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onPressed,
    child: Container(
      width: context.width,
      padding: const EdgeInsets.symmetric(vertical: 12),
      margin: const EdgeInsets.only(top: 12),
      decoration: BoxDecoration(
        color: outlined
            ? Colors.transparent
            : backgroundColor ?? context.colorScheme.primary,
        borderRadius:
        (context.theme.buttonTheme.shape as RoundedRectangleBorder)
            .borderRadius,
        border: Border.all(
            color: outlined
                ? context.colorScheme.onBackground
                : backgroundColor ?? context.colorScheme.primary),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (loading) ...{
            CircularProgressIndicator.adaptive(
              strokeWidth: 2,
              valueColor:
              AlwaysStoppedAnimation(backgroundColor ?? context.colorScheme.primary),
            ).centered(),
          } else ...{
            SvgPicture.asset(
              brandIcon,
              height: 24,
              width: 24,
              colorFilter: foregroundColor == null
                  ? null
                  : ColorFilter.mode(
                  outlined
                      ? (foregroundColor ?? context.colorScheme.onBackground)
                      : (foregroundColor ?? context.colorScheme.onPrimary),
                  BlendMode.srcIn),
            ).right(8),
            label.button(context,
                color: outlined ? backgroundColor : foregroundColor ?? context.colorScheme.onPrimary),
          }
        ],
      ),
    ),
  );
}
