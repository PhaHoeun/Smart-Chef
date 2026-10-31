import 'dart:ui';
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

class BottomNavDock extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;

  const BottomNavDock({
    super.key,
    required this.currentIndex,
    required this.onTabSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: AppTheme.surface.withValues(alpha: 0.90),
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
        border: Border(
          top: BorderSide(color: Colors.white.withValues(alpha: 0.12), width: 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.6),
            blurRadius: 28,
            offset: const Offset(0, -6),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: ClipRRect(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(0, Icons.restaurant_rounded, 'Home'),
                _buildNavItem(1, Icons.auto_awesome_rounded, 'Generate'),
                _buildNavItem(2, Icons.menu_book_rounded, 'Recipe'),
                _buildNavItem(3, Icons.bookmark_rounded, 'Saved'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index, IconData icon, String label) {
    final bool isSelected = currentIndex == index;

    return InkWell(
      onTap: () => onTabSelected(index),
      borderRadius: BorderRadius.circular(999.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        padding: isSelected
            ? const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0)
            : const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        decoration: BoxDecoration(
          color: isSelected
              ? AppTheme.primary.withValues(alpha: 0.18)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(999.0),
          border: isSelected
              ? Border.all(color: AppTheme.primary.withValues(alpha: 0.4), width: 1.0)
              : null,
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primary.withValues(alpha: 0.3),
                    blurRadius: 14,
                  ),
                ]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 20,
              color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
            ),
            if (isSelected) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: AppTheme.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.2,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
