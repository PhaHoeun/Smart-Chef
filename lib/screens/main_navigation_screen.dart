import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';
import '../components/bottom_nav_dock.dart';
import 'home_screen.dart';
import 'ingredients_screen.dart';
import 'recipe_screen.dart';
import 'saved_screen.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Global App State
  late RecipeItem _currentRecipe;
  late List<RecipeItem> _savedRecipes;
  late List<Ingredient> _basketIngredients;

  @override
  void initState() {
    super.initState();
    _currentRecipe = RecipeItem.tuscanChicken;
    _savedRecipes = [
      RecipeItem.tuscanChicken,
      RecipeItem.salmonHero,
      ...RecipeItem.trendingList.where((r) => r.isSaved),
    ];
    _basketIngredients = [
      Ingredient(name: 'Chicken Breast', baseAmount: 2, unit: 'cutlets', icon: Icons.lunch_dining_rounded),
      Ingredient(name: 'Fresh Garlic', baseAmount: 4, unit: 'cloves', icon: Icons.spa_rounded),
      Ingredient(name: 'Olive Oil', baseAmount: 2, unit: 'tbsp', icon: Icons.opacity_rounded),
      Ingredient(name: 'Cherry Tomatoes', baseAmount: 1, unit: 'cup', icon: Icons.circle_rounded),
      Ingredient(name: 'Fresh Basil', baseAmount: 0.25, unit: 'cup', icon: Icons.eco_rounded),
    ];
  }

  void _navigateToTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _openRecipe(RecipeItem recipe) {
    setState(() {
      _currentRecipe = recipe;
      _currentIndex = 2; // Recipe tab
    });
  }

  void _toggleSave(RecipeItem recipe) {
    setState(() {
      recipe.isSaved = !recipe.isSaved;
      if (recipe.isSaved) {
        if (!_savedRecipes.any((r) => r.id == recipe.id)) {
          _savedRecipes.insert(0, recipe);
        }
      } else {
        _savedRecipes.removeWhere((r) => r.id == recipe.id);
      }
    });

    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: AppTheme.surfaceContainer,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            color: recipe.isSaved
                ? AppTheme.primary.withValues(alpha: 0.5)
                : Colors.white12,
          ),
        ),
        content: Row(
          children: [
            Icon(
              recipe.isSaved ? Icons.bookmark_added_rounded : Icons.bookmark_border_rounded,
              color: recipe.isSaved ? AppTheme.primary : AppTheme.textSecondary,
              size: 20,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                recipe.isSaved
                    ? 'Saved "${recipe.title}" to collection'
                    : 'Removed from collection',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                ),
              ),
            ),
            if (recipe.isSaved)
              TextButton(
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  _navigateToTab(3); // Go to Saved
                },
                child: const Text(
                  'View',
                  style: TextStyle(
                    color: AppTheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _addIngredient(String name, [IconData icon = Icons.restaurant_menu_rounded]) {
    if (name.trim().isEmpty) return;
    setState(() {
      _basketIngredients.add(
        Ingredient(
          name: name.trim(),
          baseAmount: 1,
          unit: 'portion',
          icon: icon,
        ),
      );
    });
  }

  void _removeIngredient(int index) {
    setState(() {
      if (index >= 0 && index < _basketIngredients.length) {
        _basketIngredients.removeAt(index);
      }
    });
  }

  void _clearIngredients() {
    setState(() {
      _basketIngredients.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    // Screens list
    final List<Widget> screens = [
      HomeScreen(
        onNavigateToIngredients: () => _navigateToTab(1),
        onViewRecipe: _openRecipe,
        onToggleSave: _toggleSave,
      ),
      IngredientsScreen(
        basketIngredients: _basketIngredients,
        onAddIngredient: _addIngredient,
        onRemoveIngredient: _removeIngredient,
        onClearIngredients: _clearIngredients,
        onGenerateSuccess: () => _navigateToTab(2),
        onBack: () => _navigateToTab(0),
      ),
      RecipeScreen(
        recipe: _currentRecipe,
        onToggleSave: () => _toggleSave(_currentRecipe),
        onBack: () => _navigateToTab(1),
        onGoToSaved: () => _navigateToTab(3),
      ),
      SavedScreen(
        savedRecipes: _savedRecipes,
        onViewRecipe: _openRecipe,
        onToggleSave: _toggleSave,
        onOpenAiGenerator: () => _navigateToTab(1),
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.canvas,
      body: Stack(
        children: [
          // Background ambient glows
          Positioned(
            top: -60,
            right: -60,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.primary.withValues(alpha: 0.12),
              ),
            ),
          ),
          Positioned(
            bottom: 120,
            left: -80,
            child: Container(
              width: 260,
              height: 260,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppTheme.secondary.withValues(alpha: 0.08),
              ),
            ),
          ),
          // Active Screen
          IndexedStack(
            index: _currentIndex,
            children: screens,
          ),
          // Fixed Bottom Dock Navigation
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: BottomNavDock(
              currentIndex: _currentIndex,
              onTabSelected: _navigateToTab,
            ),
          ),
        ],
      ),
    );
  }
}
