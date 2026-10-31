import 'package:flutter/material.dart';

class Ingredient {
  final String name;
  final double baseAmount;
  final String unit;
  final IconData icon;
  bool isChecked;

  Ingredient({
    required this.name,
    required this.baseAmount,
    required this.unit,
    this.icon = Icons.restaurant_menu_rounded,
    this.isChecked = false,
  });

  String getFormattedAmount(int servings) {
    final amount = (baseAmount * servings / 2);
    if (amount == amount.roundToDouble()) {
      return '${amount.toInt()} $unit'.trim();
    }
    return '${amount.toStringAsFixed(1)} $unit'.trim();
  }
}

class RecipeItem {
  final String id;
  final String title;
  final String subtitle;
  final String imageUrl;
  final String cookTime;
  final String prepTime;
  final int calories;
  final double rating;
  final String reviewsCount;
  final int matchPercentage;
  final String category;
  final List<String> dietaryTags;
  final List<Ingredient> ingredients;
  final List<String> instructions;
  bool isSaved;

  RecipeItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.imageUrl,
    required this.cookTime,
    required this.prepTime,
    required this.calories,
    required this.rating,
    required this.reviewsCount,
    required this.matchPercentage,
    required this.category,
    required this.dietaryTags,
    required this.ingredients,
    required this.instructions,
    this.isSaved = false,
  });

  static RecipeItem tuscanChicken = RecipeItem(
    id: 'rec_tuscan_chicken',
    title: 'Tuscan Garlic Butter Chicken',
    subtitle: 'Golden seared chicken with blistered tomatoes & basil',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuAiBSjBjtCGEQbJbS24p57aqy_ud3f4m6heEI88ShS4oYqhpXf_0NqKzHZH-rK9dH0FJChEJfjB5ElImzNVP7QKryHoSG-32nGqIf74MBpLOCM7J09BcpOQyoxQG4AJtGi8_SLnssNIHCwNOdBN2OUjQ8gaEY_-sXlr-OQZz59Bg-IM84XJ9oxseQMl-tPqoM07Mky6cuDEuQ7Vp8GXmeCqOED9hDJrwxjs3nVDGobst6MI_wwv0e3t3bMbg7x9MGCpmVIHbyxxJvE',
    cookTime: '20m',
    prepTime: '10m',
    calories: 460,
    rating: 4.9,
    reviewsCount: '1.2k',
    matchPercentage: 98,
    category: 'Dinner',
    dietaryTags: ['Keto', 'Gluten-Free', 'High-Protein'],
    isSaved: true,
    ingredients: [
      Ingredient(name: 'Boneless Chicken Breasts', baseAmount: 2, unit: 'cutlets', icon: Icons.lunch_dining_rounded),
      Ingredient(name: 'Fresh Garlic Cloves', baseAmount: 4, unit: 'cloves', icon: Icons.spa_rounded),
      Ingredient(name: 'Cherry Tomatoes', baseAmount: 1, unit: 'cup', icon: Icons.circle_rounded),
      Ingredient(name: 'Extra Virgin Olive Oil', baseAmount: 2, unit: 'tbsp', icon: Icons.opacity_rounded),
      Ingredient(name: 'Fresh Basil Leaves', baseAmount: 0.25, unit: 'cup', icon: Icons.eco_rounded),
      Ingredient(name: 'Parmesan Reggiano', baseAmount: 0.5, unit: 'cup', icon: Icons.pie_chart_rounded),
    ],
    instructions: [
      'Season chicken cutlets with sea salt and cracked black pepper. Sear in olive oil over medium-high heat for 6-8 mins until deeply golden.',
      'Reduce heat to medium. Add minced garlic and whole cherry tomatoes. Sauté until garlic is aromatic and tomatoes gently burst.',
      'Pour in light cream and stir in fresh basil leaves. Simmer for 3 minutes until pan sauce thickens into a velvety glaze.',
      'Spoon luxurious sauce generously over warm chicken. Garnish with freshly grated Parmesan Reggiano.',
    ],
  );

  static RecipeItem salmonHero = RecipeItem(
    id: 'rec_salmon',
    title: 'Smoked Paprika Glazed Salmon',
    subtitle: 'Crispy skin salmon with honey paprika reduction',
    imageUrl:
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCrCu_1JNQ6n0Pg6Jjdl6esgwufE40D0jdKCpkR8DOB-gHrAgpuW5YLeG41MsWvczAaN3F8BqW3zA8YT4lWvyeU0EwfZ5pa5yzJ3MA-sQsP5y-gawhOHauMgrEz9e_QRJMlNNEf2hv7tw1cvMnF6KLhd_kKP_6N5dh9e-N8f10qVPVhTLtQs6uY6Xp_FwNZufDpF_nGbPjbgICCc7KbuVnQFLIliGRIJmg7T-TCIAZQBjzXH9bfL2YBDMbaz_d9TiNKYgrcq8LYDao',
    cookTime: '25m',
    prepTime: '8m',
    calories: 480,
    rating: 4.9,
    reviewsCount: '890',
    matchPercentage: 95,
    category: 'Dinner',
    dietaryTags: ['Keto', 'Omega-3 Rich', 'High-Protein'],
    isSaved: true,
    ingredients: [
      Ingredient(name: 'Wild Atlantic Salmon Fillets', baseAmount: 2, unit: 'fillets', icon: Icons.set_meal_rounded),
      Ingredient(name: 'Smoked Spanish Paprika', baseAmount: 1.5, unit: 'tsp', icon: Icons.whatshot_rounded),
      Ingredient(name: 'Honey or Maple', baseAmount: 1, unit: 'tbsp', icon: Icons.liquor_rounded),
      Ingredient(name: 'Lemon Juice', baseAmount: 1, unit: 'tbsp', icon: Icons.water_drop_rounded),
    ],
    instructions: [
      'Pat salmon dry and rub with smoked paprika, sea salt, and black pepper.',
      'Sear skin-side down in a hot skillet until crispy (4 mins).',
      'Flip gently and baste with honey-lemon glaze until caramelized.',
    ],
  );

  static List<RecipeItem> trendingList = [
    RecipeItem(
      id: 'rec_truffle_pasta',
      title: 'Truffle Wild Mushroom Pasta',
      subtitle: 'Handmade tagliatelle with earthy forest mushrooms',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDYPlOytpRpmicgWBlqCftg5OQd26gXyiOUeMeXp73xuv3EQsnjKsugJ_ksJsQINNVDOSVXBRPxPrjirXcYQdlifwWirTnCYq8G5Q-LSvQh8bWITG63loet7vyZyrVn28kIfajNruIRptoirJe3XrBBrFlJtGPND8Q33-ZpMWF0FKVfPINUn8lmsjE4d2pUcslHJR1YdJJz9rZSTegATC6qw-nBart_tX7uhlhD_mWTRya5Mk26mdVCVAn8irFDGZmGOSVVrYTukNs',
      cookTime: '15m',
      prepTime: '5m',
      calories: 420,
      rating: 4.8,
      reviewsCount: '640',
      matchPercentage: 90,
      category: 'Italian',
      dietaryTags: ['Vegetarian', 'Quick'],
      ingredients: [],
      instructions: [],
      isSaved: true,
    ),
    RecipeItem(
      id: 'rec_avocado_bowl',
      title: 'Avocado Citrus Bowl',
      subtitle: 'Zesty orange, lime, and crisp garden herbs',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDLAujNGs59AzmbQkWNzGtazeES6lIEFr0TdoIen9qCGOOr5xqCtnFRRB5WUTyRHiJh2mCINwQ1VctuqE0hXKX8jigF4GbZqXp4ylaOP1yhVLR2o5v_qfltoOfAK-T4IegrMjdSoKK1TVGAeJrGp7iGwd8AS-lUm87Oj0KWojKVtE8Wjjlq9gP-XrwSlyXUH-JLEmB8GhLNg4wpKoaHE-TYTSJz_Kks4nYWekmbixjNCmv7RSjw47bVvRtscS60t6gJM2j2aOxVWx8',
      cookTime: '12m',
      prepTime: '12m',
      calories: 340,
      rating: 4.7,
      reviewsCount: '510',
      matchPercentage: 88,
      category: 'Healthy Greens',
      dietaryTags: ['Vegan', 'Gluten-Free'],
      ingredients: [],
      instructions: [],
      isSaved: true,
    ),
    RecipeItem(
      id: 'rec_beef_ragu',
      title: 'Slow-Cooked Beef Ragù',
      subtitle: 'Velvety slow-braised short rib pappardelle',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuDXj6ELVMFvtWOGsGqrfYNWZd5WJyWOtMrjG8lqw6v9_kU9eh4cbLtkhgsTRBwGOaMM5GfyQyT9xhKVq5yOCqBIVqq-vTsOFLEEmUZBmB4SQvrHTvVPPRSQoqr_9NKDRbhULl_LtCuM0AEJSflqfGW2nNo1d6rBsZrmgtO20lPhuzgGwvygAA-Lh8GNRCPQoZMVKIuNGdI3uvzoOQxmkJjH5f2J9Dta7Z1r2UDjbBkbJLXgy9JHc3awXYOlgMhS3VbdOpkPxzHYMFg',
      cookTime: '45m',
      prepTime: '15m',
      calories: 620,
      rating: 4.9,
      reviewsCount: '1.4k',
      matchPercentage: 92,
      category: 'Italian',
      dietaryTags: ['High-Protein'],
      ingredients: [],
      instructions: [],
      isSaved: false,
    ),
    RecipeItem(
      id: 'rec_matcha_parfait',
      title: 'Matcha Berry Parfait',
      subtitle: 'Ceremonial grade matcha & raspberries',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuBRSkTjFciiDmu3DdKbNPKFE3XpvoAnzwnXFIq6DCtufVCNtGydPVsxp3ahyO0IM0EqeEmCpgqgWoNekB2fPUljUoWaGpymQMZr_lwA8iizhbbWJxitwjcCpcyXMK3syWhBXhIXOhG7iUz8S0yrthJ4Z9IWHSAR7e94Ij2AfLEjIZ9mWBrBdjp1i4xm3qFPAPNdR9dGx-msPspgQ-O3gfLlVGX4Eo50s6sl2bkZQUYM-LkREPI0lWSjovGEEhgCtimAxAegHGXkV2A',
      cookTime: '10m',
      prepTime: '10m',
      calories: 280,
      rating: 4.6,
      reviewsCount: '320',
      matchPercentage: 85,
      category: 'Breakfast',
      dietaryTags: ['Vegetarian', 'Quick'],
      ingredients: [],
      instructions: [],
      isSaved: true,
    ),
    RecipeItem(
      id: 'rec_honey_shrimp',
      title: 'Honey Garlic Glazed Shrimp',
      subtitle: 'Crispy skillet shrimp with chili scallion crunch',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuAvt1M70jbgc8vLQ3l_S3rmMslZSE0RI5Zra27EtZaWikVJOWgwbgmu95tCpEzFeCKinh2hVIHU-Ns-xPAwtzsVxea9lCSrfTYgYf5Qi9ZCuWf1OWWwV3tEJCoCyG7BDjajJQ4TaYGp_1e5uYUuByTUnZk3gQRljobUh08JTSXEabknKdq3CJMjoHctEbOub-vIuK_A5TceaqIFqMaUBkG2wc5RMTVWPAbN1Mwk9b5Wk51y4ehW5AVPIafBKdHKw7ugn_NcdUDn904',
      cookTime: '18m',
      prepTime: '5m',
      calories: 390,
      rating: 4.9,
      reviewsCount: '780',
      matchPercentage: 96,
      category: 'Dinner',
      dietaryTags: ['High-Protein', 'Quick'],
      ingredients: [],
      instructions: [],
      isSaved: true,
    ),
    RecipeItem(
      id: 'rec_acai_bowl',
      title: 'Berry Açai Power Bowl',
      subtitle: 'Chilled antioxidant blend with roasted seeds',
      imageUrl:
          'https://lh3.googleusercontent.com/aida-public/AB6AXuCztMhD-DFRbJ_aBgKyi5lLiRRFrqU1Q9Vj5fMYrLlT21Bb048rTmayxtey9CBYVIvElNVA-HRFQM1LF2nZfoXeC8i67GuZEsqrsB3oGVkZJR6R1aEWhwnG1upScuYt-Nf5maCy9WaeWWqah6LhgYMFoWTd9B38D6u6hF-Lj4Nz83rRAYun38nU3hUYETiCXul2rnifgRe-_xW7wGvfvzZDg3QqxFvPoJnd2XwLU7rGsjWep1f3A444SMlSAs3pCy7rVLdc-YZQ43o',
      cookTime: '10m',
      prepTime: '10m',
      calories: 310,
      rating: 4.6,
      reviewsCount: '440',
      matchPercentage: 87,
      category: 'Breakfast',
      dietaryTags: ['Vegan', 'Superfood'],
      ingredients: [],
      instructions: [],
      isSaved: true,
    ),
  ];
}
