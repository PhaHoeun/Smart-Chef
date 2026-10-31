import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final Color? fillColor;
  final Color? borderColor;
  final double borderWidth;
  final VoidCallback? onTap;
  final List<BoxShadow>? shadows;
  final double blurSigma;

  const GlassCard({
    super.key,
    required this.child,
    this.padding,
    this.borderRadius = 20.0,
    this.fillColor,
    this.borderColor,
    this.borderWidth = 1.0,
    this.onTap,
    this.shadows,
    this.blurSigma = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    Widget card = ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blurSigma, sigmaY: blurSigma),
        child: Container(
          padding: padding ?? const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: fillColor ?? AppTheme.glassFill,
            borderRadius: BorderRadius.circular(borderRadius),
            border: Border.all(
              color: borderColor ?? AppTheme.glassBorder,
              width: borderWidth,
            ),
            boxShadow: shadows ?? AppTheme.glassShadow,
          ),
          child: child,
        ),
      ),
    );

    if (onTap != null) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(borderRadius),
          onTap: onTap,
          child: card,
        ),
      );
    }
    return card;
  }
}
