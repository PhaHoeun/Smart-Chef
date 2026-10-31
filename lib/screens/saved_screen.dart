import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../theme/app_theme.dart';
import '../components/glass_card.dart';

class SavedScreen extends StatefulWidget {
  final List<RecipeItem> savedRecipes;
  final ValueChanged<RecipeItem> onViewRecipe;
  final ValueChanged<RecipeItem> onToggleSave;
  final VoidCallback onOpenAiGenerator;

  const SavedScreen({
    super.key,
    required this.savedRecipes,
    required this.onViewRecipe,
    required this.onToggleSave,
    required this.onOpenAiGenerator,
  });

  @override
  State<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends State<SavedScreen> {
  String _searchQuery = '';
  String _selectedFilter = 'All';
  final TextEditingController _searchController = TextEditingController();

  final List<String> _filters = [
    'All',
    'Favorites',
    'Quick (<20m)',
    'Healthy Greens',
    'AI Generated',
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final filteredRecipes = widget.savedRecipes.where((recipe) {
      final matchesSearch = recipe.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          recipe.subtitle.toLowerCase().contains(_searchQuery.toLowerCase());
      if (!matchesSearch) return false;

      if (_selectedFilter == 'All') return true;
      if (_selectedFilter == 'Quick (<20m)') {
        return recipe.cookTime.contains('10') ||
            recipe.cookTime.contains('12') ||
            recipe.cookTime.contains('15') ||
            recipe.cookTime.contains('18');
      }
      if (_selectedFilter == 'Healthy Greens') {
        return recipe.title.toLowerCase().contains('bowl') ||
            recipe.title.toLowerCase().contains('citrus') ||
            recipe.category.toLowerCase().contains('healthy');
      }
      if (_selectedFilter == 'AI Generated') {
        return recipe.matchPercentage > 90;
      }
      return true;
    }).toList();

    return SafeArea(
      bottom: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(18.0, 12.0, 18.0, 110.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      width: 40,
                      height: 40,
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
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Row(
                          children: [
                            Text(
                              'SAVED RECIPES',
                              style: TextStyle(
                                color: AppTheme.primary,
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                letterSpacing: 0.8,
                              ),
                            ),
                            SizedBox(width: 4),
                            Icon(Icons.bookmark_rounded, color: AppTheme.primary, size: 12),
                          ],
                        ),
                        Row(
                          children: [
                            const Text(
                              'Collection',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
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
                                '${widget.savedRecipes.length} Saved',
                                style: const TextStyle(
                                  color: AppTheme.primary,
                                  fontSize: 10,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppTheme.surfaceContainer.withValues(alpha: 0.8),
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white12),
                  ),
                  child: const Icon(Icons.tune_rounded, color: Colors.white70, size: 18),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // 2. Search Bar
            Container(
              decoration: BoxDecoration(
                color: AppTheme.surface.withValues(alpha: 0.85),
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
                decoration: const InputDecoration(
                  hintText: 'Search saved dishes or ingredients...',
                  hintStyle: TextStyle(color: AppTheme.textMuted, fontSize: 13),
                  prefixIcon: Icon(Icons.search_rounded, color: AppTheme.textSecondary, size: 20),
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                ),
              ),
            ),

            const SizedBox(height: 14),

            // 3. Filter Chips
            SizedBox(
              height: 34,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _filters.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  final filter = _filters[index];
                  final isSelected = _selectedFilter == filter;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    borderRadius: BorderRadius.circular(999),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 150),
                      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppTheme.primary
                            : AppTheme.surfaceContainer.withValues(alpha: 0.8),
                        borderRadius: BorderRadius.circular(999),
                        border: Border.all(
                          color: isSelected ? AppTheme.primary : Colors.white10,
                        ),
                        boxShadow: isSelected ? AppTheme.orangeGlow : null,
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppTheme.textSecondary,
                            fontSize: 11,
                            fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // 4. Saved Recipes Grid
            if (filteredRecipes.isEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 40.0),
                child: Center(
                  child: Column(
                    children: [
                      const Icon(Icons.bookmark_remove_rounded, color: AppTheme.textMuted, size: 48),
                      const SizedBox(height: 12),
                      const Text(
                        'No saved recipes found',
                        style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Try searching another keyword or discover recipes!',
                        style: TextStyle(color: AppTheme.textSecondary, fontSize: 12),
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: widget.onOpenAiGenerator,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primary,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                        ),
                        child: const Text('Open AI Generator'),
                      ),
                    ],
                  ),
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: filteredRecipes.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12.0,
                  mainAxisSpacing: 12.0,
                  childAspectRatio: 0.76,
                ),
                itemBuilder: (context, index) {
                  final recipe = filteredRecipes[index];
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
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                                valueColor: AlwaysStoppedAnimation<Color>(AppTheme.primary),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      errorBuilder: (context, error, stackTrace) {
                                        return Container(
                                          decoration: BoxDecoration(
                                            gradient: LinearGradient(
                                              colors: [AppTheme.surfaceContainerHigh, AppTheme.surfaceContainer],
                                              begin: Alignment.topLeft,
                                              end: Alignment.bottomRight,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Icon(Icons.restaurant_rounded, size: 28, color: AppTheme.primary),
                                          ),
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
                                      child: const Icon(
                                        Icons.bookmark_rounded,
                                        color: AppTheme.primary,
                                        size: 16,
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

            const SizedBox(height: 22),

            // 5. Bottom Discovery Banner
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: AppTheme.surfaceContainer.withValues(alpha: 0.8),
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(color: Colors.white12),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppTheme.primary.withValues(alpha: 0.2),
                      shape: BoxShape.circle,
                      border: Border.all(color: AppTheme.primary.withValues(alpha: 0.4)),
                    ),
                    child: const Icon(Icons.psychology_rounded, color: AppTheme.primary, size: 24),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Want to cook something new?',
                          style: TextStyle(color: Colors.white, fontSize: 13, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(height: 2),
                        const Text(
                          'Generate recipes from what is in your fridge',
                          style: TextStyle(color: AppTheme.textSecondary, fontSize: 11),
                        ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: widget.onOpenAiGenerator,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(999)),
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                      elevation: 0,
                    ),
                    child: const Text('AI Generator', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
