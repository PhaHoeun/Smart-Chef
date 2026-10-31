import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class OrangeButton extends StatelessWidget {
  final String text;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isExpanded;
  final double height;
  final double fontSize;
  final bool isLoading;
  final EdgeInsetsGeometry? padding;

  const OrangeButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isExpanded = true,
    this.height = 48.0,
    this.fontSize = 13.0,
    this.isLoading = false,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    Widget buttonContent = Container(
      height: height,
      padding: padding ?? const EdgeInsets.symmetric(horizontal: 14.0),
      decoration: BoxDecoration(
        gradient: AppTheme.primaryGradient,
        borderRadius: BorderRadius.circular(999.0),
        boxShadow: AppTheme.orangeGlow,
      ),
      child: Center(
        child: isLoading
            ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Row(
                mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, color: Colors.white, size: 18),
                    const SizedBox(width: 6),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: fontSize,
                        fontWeight: FontWeight.w800,
                        letterSpacing: 0.2,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(999.0),
        onTap: isLoading ? null : onPressed,
        child: isExpanded
            ? SizedBox(width: double.infinity, child: buttonContent)
            : buttonContent,
      ),
    );
  }
}
