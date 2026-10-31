import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';
import '../components/glass_card.dart';

class HomeScreen extends StatefulWidget {
  final VoidCallback onNavigateToIngredients;
  final ValueChanged<RecipeItem> onViewRecipe;
  final ValueChanged<RecipeItem> onToggleSave;

  const HomeScreen({
    super.key,
    required this.onNavigateToIngredients,
    required this.onViewRecipe,
    required this.onToggleSave,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _selectedCategory = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _categories = [
    {'name': 'All', 'icon': Icons.restaurant_rounded},
    {'name': 'Italian', 'icon': Icons.dinner_dining_rounded},
    {'name': 'Quick & Easy', 'icon': Icons.bolt_rounded},
    {'name': 'Healthy Greens', 'icon': Icons.eco_rounded},
    {'name': 'Breakfast', 'icon': Icons.bakery_dining_rounded},
    {'name': 'Bakery', 'icon': Icons.cookie_rounded},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredTrending = RecipeItem.trendingList.where((recipe) {
      final matchesSearch = recipe.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe.subtitle.toLowerCase().contains(_searchQuery.toLowerCase());
      final matchesCategory = _selectedCategory == 'All' ||
          recipe.category.toLowerCase() == _selectedCategory.toLowerCase() ||
          (_selectedCategory == 'Quick & Easy' && (recipe.cookTime.contains('10') || recipe.cookTime.contains('15') || recipe.cookTime.contains('12')));
      return matchesSearch && matchesCategory;
    }).toList();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 100.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Top Header Profile & Notifications
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: AppTheme.primary, width: 2),
                        image: const DecorationImage(
                          image: NetworkImage(
                            'https://lh3.googleusercontent.com/aida-public/AB6AXuAQ_K-V-ZRUtlOw9G6KYVph47-gwJ1TjwARfOUNEr-rMeqBA727Fquq_Fi8nynhdBowdFRgKSsj7HyWtGtIWVQ-t-EcLjX3NZQTMkjMEMkKkxgrtR0YJa-0Xdy0xR-ReC-Pm5w9bkOk63Wfc1IK24sd94COhl6d1zZxCPU77fSbt8up3snRE0YZWFOVD_ZknxySQwYh9QQtT4Pl1T5BZGAiGJXsPe9x0bOXRvXYRA0cbENSkqpJtIQ0jK_g1ludCeCXaZ2OJlPpwmg',
                          ),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              'Good evening, Chef Alex',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.3,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.auto_awesome_rounded, color: AppTheme.primary, size: 14),
                          ],
                        ),
                        SizedBox(height: 2),
                        Text(
                          'What are we cooking?',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainer.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white12),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      const Icon(Icons.notifications_none_rounded, color: Colors.white, size: 22),
                      Positioned(
                        top: 10,
                        right: 11,
                        child: Container(
                          width: 8,
                          height: 8,
                          decoration: const BoxDecoration(
                            color: AppTheme.primary,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 18),

            // 2. Search Bar
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surface.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(16.0),
                border: Border.all(color: Colors.white12),
                boxShadow: AppTheme.glassShadow,
              ),
              child: TextField(
                controller: _searchController,
                onChanged: (val) {
                  setState(() {
                    _searchQuery = val;
                  });
                },
                style: const TextStyle(color: Colors.white, fontSize: 14),
                decoration: InputDecoration(
                  hintText: 'Search 10,000+ recipes, ingredients...',
                  hintStyle: const TextStyle(color: AppTheme.textMuted, fontSize: 13),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppTheme.textSecondary, size: 20),
                  suffixIcon: Container(
                    margin: const EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: AppTheme.surfaceContainer,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: const Icon(Icons.tune_rounded, color: AppTheme.primary, size: 18),
                  ),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 16),

            // 3. Category Horizontal Row
            SizedBox(
              height: 38,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _categories.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final cat = _categories[index];
                  final isSelected = _selectedCategory == cat['name'];
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedCategory = cat['name'] as String;
                      });
                    },
                    borderRadius: BorderRadius.circular(999.0),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primary
                            : AppTheme.surfaceContainer.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(999.0),
                        border: Border.all(
                          color: isSelected
                              ? AppTheme.primary
                              : Colors.white.withValues(alpha: 0.08),
                        ),
                        boxShadow: isSelected ? AppTheme.orangeGlow : null,
                      ),
                      child: Row(
                        children: [
                          Icon(
                            cat['icon'] as IconData,
                            size: 14,
                            color: isSelected ? Colors.white : AppTheme.textSecondary,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            cat['name'] as String,
                            style: TextStyle(
                              color: isSelected ? Colors.white : AppTheme.textSecondary,
                              fontSize: 12,
                              fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
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

            // 4. Featured Hero Recipe Card
            InkWell(
              onTap: () => widget.onViewRecipe(RecipeItem.salmonHero),
              borderRadius: BorderRadius.circular(24.0),
              child: GlassCard(
                borderRadius: 24.0,
                padding: EdgeInsets.zero,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
                          child: SizedBox(
                            height: 170,
                            width: double.infinity,
                            child: Image.network(
                              RecipeItem.salmonHero.imageUrl,
                              fit: BoxFit.cover,
                              loadingBuilder: (context, child, progress) {
                                if (progress == null) return child;
                                return Container(
                                  height: 170,
                                  color: AppTheme.surfaceContainerHigh,
                                  child: const Center(
                                    child: SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary)),
                                    ),
                                  ),
                                );
                              },
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  height: 170,
                                  color: AppTheme.surfaceContainerHigh,
                                  child: const Center(child: Icon(Icons.set_meal_rounded, size: 40, color: AppTheme.primary)),
                                );
                              },
                            ),
                          ),
                        ),
                        // Dark gradient overlay
                        Positioned.fill(
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: const BorderRadius.vertical(top: Radius.circular(24.0)),
                              gradient: LinearGradient(
                                colors: [Colors.transparent, Colors.black.withValues(alpha: 0.85)],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                            ),
                          ),
                        ),
                        // Top badges
                        Positioned(
                          top: 12,
                          left: 12,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppTheme.primary.withValues(alpha: 0.9),
                              borderRadius: BorderRadius.circular(999.0),
                              boxShadow: AppTheme.orangeGlow,
                            ),
                            child: const Row(
                              children: [
                                Icon(Icons.star_rounded, color: Colors.white, size: 14),
                                SizedBox(width: 4),
                                Text(
                                  'FEATURED DISH',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w800,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          top: 12,
                          right: 12,
                          child: InkWell(
                            onTap: () => widget.onToggleSave(RecipeItem.salmonHero),
                            child: Container(
                              width: 34,
                              height: 34,
                              decoration: BoxDecoration(
                                color: Colors.black.withValues(alpha: 0.5),
                                shape: BoxShape.circle,
                                border: Border.all(color: Colors.white24),
                              ),
                              child: Icon(
                                RecipeItem.salmonHero.isSaved
                                    ? Icons.bookmark_rounded
                                    : Icons.bookmark_border_rounded,
                                color: RecipeItem.salmonHero.isSaved ? AppTheme.primary : Colors.white,
                                size: 18,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceContainerHigh,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.schedule_rounded, color: AppTheme.textSecondary, size: 12),
                                    SizedBox(width: 3),
                                    Text(
                                      '25 mins',
                                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.surfaceContainerHigh,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Icon(Icons.local_fire_department_rounded, color: AppTheme.primary, size: 12),
                                    SizedBox(width: 3),
                                    Text(
                                      '480 kcal',
                                      style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(Icons.star_rounded, color: AppTheme.secondary, size: 13),
                                  SizedBox(width: 2),
                                  Text(
                                    '4.9 (890)',
                                    style: TextStyle(
                                      color: AppTheme.secondary,
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Smoked Paprika Glazed Salmon',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            'Crispy skin salmon drizzled with honey-paprika reduction and fresh garden dill.',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 12),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                '95% Ingredient Match',
                                style: TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                                decoration: BoxDecoration(
                                  gradient: AppTheme.primaryGradient,
                                  borderRadius: BorderRadius.circular(999.0),
                                  boxShadow: AppTheme.orangeGlow,
                                ),
                                child: const Row(
                                  children: [
                                    Text(
                                      'View Recipe',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                    SizedBox(width: 4),
                                    Icon(Icons.arrow_forward_rounded, color: Colors.white, size: 14),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 18),

            // 5. Smart Pantry AI Quick Banner
            InkWell(
              onTap: widget.onNavigateToIngredients,
              borderRadius: BorderRadius.circular(20.0),
              child: Container(
                padding: const EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primary.withValues(alpha: 0.22),
                      AppTheme.surfaceContainer.withValues(alpha: 0.9),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(20.0),
                  border: Border.all(color: AppTheme.primary.withValues(alpha: 0.35)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primary.withValues(alpha: 0.15),
                      blurRadius: 18,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppTheme.primary.withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(14.0),
                        border: Border.all(color: AppTheme.primary.withValues(alpha: 0.4)),
                      ),
                      child: const Icon(Icons.auto_awesome_rounded, color: AppTheme.primary, size: 24),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const Text(
                                'Smart Fridge AI',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w800,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: AppTheme.primary,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: const Text(
                                  'NEW',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 9,
                                    fontWeight: FontWeight.w900,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 2),
                          const Text(
                            'Got leftover ingredients? Create a meal now',
                            style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                          ),
                        ],
                      ),
                    ),
                    const Icon(Icons.chevron_right_rounded, color: AppTheme.primary, size: 22),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // 6. Trending Recipes Section
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Row(
                  children: [
                    Text(
                      'Trending Recipes',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    SizedBox(width: 4),
                    Icon(Icons.local_fire_department_rounded, color: AppTheme.primary, size: 20),
                  ],
                ),
                TextButton(
                  onPressed: () {},
                  child: const Text(
                    'See All',
                    style: TextStyle(
                      color: AppTheme.primary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            // Grid of 2 columns
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: filteredTrending.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 12.0,
                mainAxisSpacing: 12.0,
                childAspectRatio: 0.76,
              ),
              itemBuilder: (context, index) {
                final recipe = filteredTrending[index];
                return InkWell(
                  onTap: () => widget.onViewRecipe(recipe),
                  borderRadius: BorderRadius.circular(16.0),
                  child: GlassCard(
                    borderRadius: 16.0,
                    padding: EdgeInsets.zero,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Stack(
                            children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(16.0)),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: double.infinity,
                                  child: Image.network(
                                    recipe.imageUrl,
                                    fit: BoxFit.cover,
                                    loadingBuilder: (context, child, progress) {
                                      if (progress == null) return child;
                                      return Container(
                                        color: AppTheme.surfaceContainerHigh,
                                        child: const Center(
                                          child: SizedBox(
                                            width: 18,
                                            height: 18,
                                            child: CircularProgressIndicator(strokeWidth: 2, valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary)),
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return Container(
                                        color: AppTheme.surfaceContainerHigh,
                                        child: const Center(child: Icon(Icons.restaurant_rounded, size: 28, color: AppTheme.primary)),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: InkWell(
                                  onTap: () => widget.onToggleSave(recipe),
                                  child: Container(
                                    width: 28,
                                    height: 28,
                                    decoration: BoxDecoration(
                                      color: Colors.black54,
                                      shape: BoxShape.circle,
                                      border: Border.all(color: Colors.white24),
                                    ),
                                    child: Icon(
                                      recipe.isSaved
                                          ? Icons.bookmark_rounded
                                          : Icons.bookmark_border_rounded,
                                      color: recipe.isSaved ? AppTheme.primary : Colors.white,
                                      size: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.schedule_rounded, color: AppTheme.textSecondary, size: 12),
                                      const SizedBox(width: 3),
                                      Text(
                                        recipe.cookTime,
                                        style: const TextStyle(
                                          color: AppTheme.textSecondary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Icon(Icons.star_rounded, color: AppTheme.secondary, size: 12),
                                      const SizedBox(width: 2),
                                      Text(
                                        '${recipe.rating}',
                                        style: const TextStyle(
                                          color: AppTheme.secondary,
                                          fontSize: 10,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                recipe.title,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                recipe.subtitle,
                                style: const TextStyle(
                                  color: AppTheme.textMuted,
                                  fontSize: 10,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
