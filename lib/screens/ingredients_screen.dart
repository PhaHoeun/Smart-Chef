import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';
import '../components/glass_card.dart';
import '../components/orange_button.dart';

class IngredientsScreen extends StatefulWidget {
  final List<Ingredient> basketIngredients;
  final void Function(String name, [IconData icon]) onAddIngredient;
  final ValueChanged<int> onRemoveIngredient;
  final VoidCallback onClearIngredients;
  final VoidCallback onGenerateSuccess;
  final VoidCallback onBack;

  const IngredientsScreen({
    super.key,
    required this.basketIngredients,
    required this.onAddIngredient,
    required this.onRemoveIngredient,
    required this.onClearIngredients,
    required this.onGenerateSuccess,
    required this.onBack,
  });

  @override
  State<IngredientsScreen> createState() => _IngredientsScreenState();
}

class _IngredientsScreenState extends State<IngredientsScreen> {
  final TextEditingController _inputController = TextEditingController();
  final Set<String> _selectedDiets = {'High Protein', 'Keto'};
  String _selectedCookTime = '30m';
  bool _isGenerating = false;

  final List<Map<String, dynamic>> _pantryStaples = [
    {'name': 'Eggs', 'icon': Icons.egg_alt_rounded},
    {'name': 'Butter', 'icon': Icons.bakery_dining_rounded},
    {'name': 'Onion', 'icon': Icons.spa_rounded},
    {'name': 'Rice', 'icon': Icons.rice_bowl_rounded},
    {'name': 'Pasta', 'icon': Icons.dinner_dining_rounded},
    {'name': 'Chili Flakes', 'icon': Icons.whatshot_rounded},
    {'name': 'Soy Sauce', 'icon': Icons.liquor_rounded},
  ];

  final List<String> _diets = [
    'High Protein',
    'Keto',
    'Low Carb',
    'Vegetarian',
    'Gluten-Free',
  ];

  final List<String> _cookTimes = [
    '< 15m',
    '30m',
    '45m+',
  ];

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  void _handleAddInput() {
    final text = _inputController.text.trim();
    if (text.isNotEmpty) {
      widget.onAddIngredient(text, Icons.restaurant_menu_rounded);
      _inputController.clear();
    }
  }

  void _triggerAiGeneration() async {
    setState(() {
      _isGenerating = true;
    });

    // Show exciting generation dialog
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: const EdgeInsets.all(24),
          child: GlassCard(
            borderRadius: 28,
            borderColor: AppTheme.primary.withValues(alpha: 0.5),
            padding: const EdgeInsets.all(28),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.2),
                    shape: BoxShape.circle,
                    border: Border.all(color: AppTheme.primary),
                  ),
                  child: const Center(
                    child: SizedBox(
                      width: 28,
                      height: 28,
                      child: CircularProgressIndicator(
                        strokeWidth: 3,
                        valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Crafting Your Recipe',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Chef AI is pairing ${_selectedDiets.join(", ")} options with your ingredients...',
                  style: const TextStyle(
                    color: AppTheme.textSecondary,
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                ClipRRect(
                  borderRadius: BorderRadius.circular(999),
                  child: const LinearProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                    backgroundColor: Colors.white10,
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );

    await Future.delayed(const Duration(milliseconds: 1600));

    if (mounted) {
      Navigator.of(context, rootNavigator: true).pop();
      setState(() {
        _isGenerating = false;
      });
      widget.onGenerateSuccess();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 110.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header with back button
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
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
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'CULINARY STUDIO',
                          style: TextStyle(
                            color: AppTheme.primary,
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.8,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "What's in your fridge?",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w800,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.kitchen_rounded, color: AppTheme.primary, size: 18),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppTheme.primary.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(999),
                    border: Border.all(color: AppTheme.primary.withValues(alpha: 0.3)),
                  ),
                  child: const Row(
                    children: [
                      Icon(Icons.auto_awesome_rounded, color: AppTheme.primary, size: 14),
                      SizedBox(width: 4),
                      Text(
                        'AI Ready',
                        style: TextStyle(
                          color: AppTheme.primary,
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 6),
            const Text(
              'Add ingredients you have on hand to curate personalized artisan recipes.',
              style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
            ),

            const SizedBox(height: 18),

            // 2. Input Box
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surface.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(18.0),
                border: Border.all(color: Colors.white12),
                boxShadow: AppTheme.glassShadow,
              ),
              child: Row(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.0),
                    child: Icon(Icons.search_rounded, color: AppTheme.textSecondary, size: 22),
                  ),
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      onSubmitted: (_) => _handleAddInput(),
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: const InputDecoration(
                        hintText: 'Type ingredients (e.g. Chicken, Basil)...',
                        hintStyle: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  // Camera OCR Scan Button
                  IconButton(
                    onPressed: () {
                      widget.onAddIngredient('Spinach', Icons.eco_rounded);
                      widget.onAddIngredient('Heavy Cream', Icons.local_drink_rounded);
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Fridge scanned! Added Spinach & Heavy Cream 📸'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                    icon: const Icon(Icons.photo_camera_rounded, color: Colors.white70, size: 20),
                    tooltip: 'Scan fridge',
                  ),
                  // Add Button
                  Padding(
                    padding: const EdgeInsets.only(right: 6.0),
                    child: ElevatedButton.icon(
                      onPressed: _handleAddInput,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14.0),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      ),
                      icon: const Icon(Icons.add_rounded, size: 16),
                      label: const Text('Add', style: TextStyle(fontWeight: FontWeight.w800, fontSize: 12)),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 3. Basket Ingredients Card
            GlassCard(
              borderRadius: 20.0,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.shopping_basket_rounded, color: AppTheme.primary, size: 20),
                          const SizedBox(width: 8),
                          const Text(
                            'Your Basket',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.w800,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(999),
                              border: Border.all(color: AppTheme.primary.withValues(alpha: 0.3)),
                            ),
                            child: Text(
                              '${widget.basketIngredients.length} ingredients',
                              style: const TextStyle(
                                color: AppTheme.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      if (widget.basketIngredients.isNotEmpty)
                        TextButton(
                          onPressed: widget.onClearIngredients,
                          child: const Text(
                            'Clear all',
                            style: TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  if (widget.basketIngredients.isEmpty)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 24.0),
                      child: Center(
                        child: Text(
                          'Your basket is empty. Add ingredients above or tap pantry staples!',
                          style: TextStyle(color: AppTheme.textMuted, fontSize: 12),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    )
                  else
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(widget.basketIngredients.length, (index) {
                        final item = widget.basketIngredients[index];
                        return Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
                          decoration: BoxDecoration(
                            color: AppTheme.surfaceContainerHigh.withValues(alpha: 0.8),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(color: Colors.white12),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(item.icon, size: 14, color: AppTheme.primary),
                              const SizedBox(width: 6),
                              Text(
                                item.name,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(width: 4),
                              InkWell(
                                onTap: () => widget.onRemoveIngredient(index),
                                borderRadius: BorderRadius.circular(999),
                                child: const Padding(
                                  padding: EdgeInsets.all(2.0),
                                  child: Icon(Icons.close_rounded, size: 14, color: AppTheme.textSecondary),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
                    ),
                ],
              ),
            ),

            const SizedBox(height: 18),

            // 4. Pantry Quick Add
            const Row(
              children: [
                Text(
                  'Quick Add Pantry Staples',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.inventory_2_rounded, color: AppTheme.primary, size: 16),
              ],
            ),
            const SizedBox(height: 8),
            SizedBox(
              height: 36,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _pantryStaples.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final staple = _pantryStaples[index];
                  return InkWell(
                    onTap: () {
                      widget.onAddIngredient(staple['name'] as String, staple['icon'] as IconData);
                    },
                    borderRadius: BorderRadius.circular(999),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: AppTheme.surfaceContainer.withValues(alpha: 0.7),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(color: Colors.white12),
                      ),
                      child: Row(
                        children: [
                          Icon(staple['icon'] as IconData, size: 14, color: AppTheme.primary),
                          const SizedBox(width: 6),
                          Text(
                            '+ ${staple['name']}',
                            style: const TextStyle(
                              color: AppTheme.textSecondary,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 5. Dietary & Time Filter Options
            GlassCard(
              borderRadius: 20.0,
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Cooking Preferences',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Dietary Lifestyle',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 8.0,
                    runSpacing: 6.0,
                    children: _diets.map((diet) {
                      final isSelected = _selectedDiets.contains(diet);
                      return InkWell(
                        onTap: () {
                          setState(() {
                            if (isSelected) {
                              _selectedDiets.remove(diet);
                            } else {
                              _selectedDiets.add(diet);
                            }
                          });
                        },
                        borderRadius: BorderRadius.circular(999),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 150),
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? AppTheme.primary.withValues(alpha: 0.2)
                                : AppTheme.surfaceContainerHigh.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: isSelected ? AppTheme.primary : Colors.white10,
                            ),
                          ),
                          child: Text(
                            diet,
                            style: TextStyle(
                              color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                              fontSize: 11,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),

                  const SizedBox(height: 14),
                  const Text(
                    'Maximum Cook Time',
                    style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: _cookTimes.map((time) {
                      final isSelected = _selectedCookTime == time;
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                _selectedCookTime = time;
                              });
                            },
                            borderRadius: BorderRadius.circular(999),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 150),
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? AppTheme.primary.withValues(alpha: 0.2)
                                    : AppTheme.surfaceContainerHigh.withValues(alpha: 0.6),
                                borderRadius: BorderRadius.circular(999),
                                border: Border.all(
                                  color: isSelected ? AppTheme.primary : Colors.white10,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  time,
                                  style: TextStyle(
                                    color: isSelected ? AppTheme.primary : AppTheme.textSecondary,
                                    fontSize: 12,
                                    fontWeight: isSelected ? FontWeight.w800 : FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // 6. Giant Primary Action Button
            OrangeButton(
              text: 'Generate Recipe with AI',
              icon: Icons.auto_awesome_rounded,
              isLoading: _isGenerating,
              onPressed: _triggerAiGeneration,
            ),
          ],
        ),
      ),
    );
  }
}
