import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';
import '../components/glass_card.dart';
import '../components/orange_button.dart';

class RecipeScreen extends StatefulWidget {
  final RecipeItem recipe;
  final VoidCallback onToggleSave;
  final VoidCallback onBack;
  final VoidCallback onGoToSaved;

  const RecipeScreen({
    super.key,
    required this.recipe,
    required this.onToggleSave,
    required this.onBack,
    required this.onGoToSaved,
  });

  @override
  State<RecipeScreen> createState() => _RecipeScreenState();
}

class _RecipeScreenState extends State<RecipeScreen> {
  int _servings = 2;
  int _activeCookStep = 1;

  void _showCookModeDialog() {
    showDialog(
      context: context,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            final steps = widget.recipe.instructions;
            final currentStepText = steps.isNotEmpty
                ? steps[_activeCookStep - 1]
                : 'Follow recipe instructions.';

            return Dialog(
              backgroundColor: Colors.transparent,
              insetPadding: const EdgeInsets.all(20),
              child: GlassCard(
                borderRadius: 28,
                padding: const EdgeInsets.all(22),
                borderColor: AppTheme.primary.withValues(alpha: 0.4),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.local_fire_department_rounded, color: AppTheme.primary, size: 24),
                            SizedBox(width: 8),
                            Text(
                              'Active Cook Mode',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                          ],
                        ),
                        IconButton(
                          onPressed: () => Navigator.of(context).pop(),
                          icon: const Icon(Icons.close_rounded, color: Colors.white70),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainerHigh.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(18),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'STEP $_activeCookStep OF ${steps.length}',
                            style: const TextStyle(
                              color: AppTheme.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.8,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            currentStepText,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              height: 1.4,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppTheme.surface,
                        borderRadius: BorderRadius.circular(14),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Step Timer',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                          ),
                          Text(
                            '06:45',
                            style: TextStyle(
                              color: AppTheme.primary,
                              fontSize: 20,
                              fontFamily: 'monospace',
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    OrangeButton(
                      text: _activeCookStep < steps.length
                          ? 'Next Step (${_activeCookStep + 1}/${steps.length}) →'
                          : 'Complete Cooking 🎉',
                      onPressed: () {
                        if (_activeCookStep < steps.length) {
                          setDialogState(() {
                            _activeCookStep++;
                          });
                        } else {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Bon Appétit! Dish completed 🎉'),
                              duration: Duration(seconds: 2),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final recipe = widget.recipe;

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18.0, 10.0, 18.0, 110.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Sticky-like Header Bar
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: widget.onBack,
                  borderRadius: BorderRadius.circular(999),
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainer.withValues(alpha: 0.8),
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white12),
                    ),
                    child: const Icon(Icons.chevron_left_rounded, color: Colors.white, size: 24),
                  ),
                ),
                const Text(
                  'SmartChef',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -0.2,
                  ),
                ),
                Row(
                  children: [
                    Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainer.withValues(alpha: 0.8),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white12),
                      ),
                      child: const Icon(Icons.share_rounded, color: Colors.white70, size: 18),
                    ),
                    const SizedBox(width: 8),
                    InkWell(
                      onTap: widget.onToggleSave,
                      borderRadius: BorderRadius.circular(999),
                      child: Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: AppTheme.surfaceContainer.withValues(alpha: 0.8),
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: recipe.isSaved ? AppTheme.primary : Colors.white12,
                          ),
                        ),
                        child: Icon(
                          recipe.isSaved
                              ? Icons.bookmark_rounded
                              : Icons.bookmark_border_rounded,
                          color: recipe.isSaved ? AppTheme.primary : Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 2. Hero Image Banner
            GlassCard(
              borderRadius: 26,
              padding: EdgeInsets.zero,
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(26),
                    child: SizedBox(
                      height: 220,
                      width: double.infinity,
                      child: Image.network(
                        recipe.imageUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return Container(
                            height: 220,
                            color: AppTheme.surfaceContainerHigh,
                            child: const Center(
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                              ),
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 220,
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [AppTheme.surfaceContainerHigh, AppTheme.surfaceContainer],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                            ),
                            child: const Center(
                              child: Icon(Icons.restaurant_rounded, size: 48, color: AppTheme.primary),
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                  Positioned.fill(
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(26),
                        gradient: LinearGradient(
                          colors: [
                            Colors.black.withValues(alpha: 0.45),
                            Colors.transparent,
                            Colors.black.withValues(alpha: 0.85),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                  // AI Match Badge top-left
                  Positioned(
                    top: 14,
                    left: 14,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.5)),
                        boxShadow: AppTheme.orangeGlow,
                      ),
                      child: Row(
                        children: [
                          const Icon(Icons.auto_awesome_rounded, color: AppTheme.primary, size: 14),
                          const SizedBox(width: 6),
                          Text(
                            '${recipe.matchPercentage}% Ingredient Match',
                            style: const TextStyle(
                              color: AppTheme.primary,
                              fontSize: 11,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Quick stats overlay on bottom of hero
                  Positioned(
                    bottom: 12,
                    left: 12,
                    right: 12,
                    child: Row(
                      children: [
                        _buildHeroStat(Icons.schedule_rounded, 'COOK', recipe.cookTime),
                        const SizedBox(width: 8),
                        _buildHeroStat(Icons.outdoor_grill_rounded, 'PREP', recipe.prepTime),
                        const SizedBox(width: 8),
                        _buildHeroStat(Icons.local_fire_department_rounded, 'ENERGY', '${recipe.calories} kcal'),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 3. Title & Servings Scaler
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: AppTheme.surfaceContainerHigh,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: const Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(Icons.bolt_rounded, color: AppTheme.secondary, size: 13),
                                SizedBox(width: 3),
                                Text(
                                  'Curated by Chef AI',
                                  style: TextStyle(color: AppTheme.secondary, fontSize: 10, fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 8),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              const Icon(Icons.star_rounded, color: AppTheme.secondary, size: 14),
                              const SizedBox(width: 2),
                              Text(
                                '${recipe.rating} (${recipe.reviewsCount})',
                                style: const TextStyle(color: AppTheme.secondary, fontSize: 11, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        recipe.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                ),
                // Servings Scaler (- 2 +)
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainer.withValues(alpha: 0.9),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          if (_servings > 1) {
                            setState(() {
                              _servings--;
                            });
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.remove_rounded, color: Colors.white70, size: 16),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6.0),
                        child: Text(
                          '$_servings Servings',
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          if (_servings < 12) {
                            setState(() {
                              _servings++;
                            });
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(4.0),
                          child: Icon(Icons.add_rounded, color: AppTheme.primary, size: 16),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Dietary Pills
            Wrap(
              spacing: 6,
              children: recipe.dietaryTags.map((tag) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainer.withValues(alpha: 0.6),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: Colors.white10),
                  ),
                  child: Text(
                    tag,
                    style: const TextStyle(color: AppTheme.textSecondary, fontSize: 11, fontWeight: FontWeight.w500),
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 20),

            // 4. Ingredients Checklist
            GlassCard(
              borderRadius: 22,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ingredients List',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                      Text(
                        'Scaled for $_servings ${_servings == 1 ? "serving" : "servings"}',
                        style: const TextStyle(color: AppTheme.primary, fontSize: 11, fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  ...recipe.ingredients.map((ing) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          ing.isChecked = !ing.isChecked;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6.0),
                        child: Row(
                          children: [
                            Container(
                              width: 22,
                              height: 22,
                              decoration: BoxDecoration(
                                color: ing.isChecked ? AppTheme.primary : Colors.transparent,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: ing.isChecked ? AppTheme.primary : Colors.white24,
                                  width: 1.5,
                                ),
                              ),
                              child: ing.isChecked
                                  ? const Icon(Icons.check_rounded, size: 16, color: Colors.black)
                                  : null,
                            ),
                            const SizedBox(width: 10),
                            Icon(
                              ing.icon,
                              size: 16,
                              color: ing.isChecked ? AppTheme.textMuted : AppTheme.primary,
                            ),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                ing.name,
                                style: TextStyle(
                                  color: ing.isChecked ? AppTheme.textMuted : Colors.white,
                                  fontSize: 13,
                                  decoration: ing.isChecked ? TextDecoration.lineThrough : null,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Text(
                              ing.getFormattedAmount(_servings),
                              style: TextStyle(
                                color: ing.isChecked ? AppTheme.textMuted : AppTheme.secondary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 5. Step-by-Step Cooking Instructions
            const Row(
              children: [
                Text(
                  'Cooking Instructions',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.menu_book_rounded, color: AppTheme.primary, size: 18),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(recipe.instructions.length, (index) {
              final stepNum = index + 1;
              final instruction = recipe.instructions[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 10.0),
                child: GlassCard(
                  borderRadius: 18,
                  padding: const EdgeInsets.all(14),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 28,
                        height: 28,
                        decoration: BoxDecoration(
                          color: AppTheme.primary.withValues(alpha: 0.2),
                          shape: BoxShape.circle,
                          border: Border.all(color: AppTheme.primary.withValues(alpha: 0.4)),
                        ),
                        child: Center(
                          child: Text(
                            '$stepNum',
                            style: const TextStyle(
                              color: AppTheme.primary,
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          instruction,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 13,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),

            const SizedBox(height: 20),

            // 6. Action Triggers (Guaranteed NO overflow)
            Row(
              children: [
                Expanded(
                  flex: 5,
                  child: OutlinedButton.icon(
                    onPressed: widget.onToggleSave,
                    style: OutlinedButton.styleFrom(
                      foregroundColor: recipe.isSaved ? Colors.white : AppTheme.primary,
                      backgroundColor: recipe.isSaved
                          ? AppTheme.success.withValues(alpha: 0.2)
                          : AppTheme.surfaceContainer,
                      side: BorderSide(
                        color: recipe.isSaved ? AppTheme.success : AppTheme.primary,
                      ),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
                    ),
                    icon: Icon(
                      recipe.isSaved ? Icons.bookmark_added_rounded : Icons.bookmark_add_rounded,
                      size: 18,
                    ),
                    label: Text(
                      recipe.isSaved ? 'Saved' : 'Save',
                      style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 13),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  flex: 6,
                  child: OrangeButton(
                    text: 'Cook Mode',
                    icon: Icons.local_fire_department_rounded,
                    height: 44.0,
                    fontSize: 13.0,
                    padding: const EdgeInsets.symmetric(horizontal: 12.0),
                    onPressed: _showCookModeDialog,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroStat(IconData icon, String label, String value) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 6),
        decoration: BoxDecoration(
          color: Colors.black.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.white12),
        ),
        child: Column(
          children: [
            Icon(icon, color: AppTheme.primary, size: 16),
            const SizedBox(height: 2),
            Text(
              label,
              style: const TextStyle(color: AppTheme.textMuted, fontSize: 9, fontWeight: FontWeight.bold),
            ),
            Text(
              value,
              style: const TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.w800),
            ),
          ],
        ),
      ),
    );
  }
}
