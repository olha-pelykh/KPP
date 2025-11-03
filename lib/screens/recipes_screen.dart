import 'package:flutter/material.dart';
import '../models/food_item.dart';
import 'recipe_detail_screen.dart';

class RecipesScreen extends StatelessWidget {
  const RecipesScreen({super.key});

  static final List<FoodItem> _dummyRecipes = [
    FoodItem(
      name: 'Pancakes with blueberry',
      details: '150g/220 kcal',
      imagePath: 'assets/images/pancakes.png',
      protein: 16,
      fats: 8,
      carbs: 10,
      calories: 224,
      rating: 4.8,
      ratingCount: 139,
      ingredients: {
        'Butter': '50g',
        'Sugar': '60g',
        'Egg': '2',
        'Vanilla extract': '5g',
        'Flour': '100g',
      },
      tags: ['vegan', '25 min', '236 kcal'],
    ),

  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 20),
            _buildFilterToggle(),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: _dummyRecipes.length,
                itemBuilder: (context, index) {
                  return _buildRecipeCard(context, _dummyRecipes[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          "Saved Recipes",
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        Row(
          children: [
            IconButton(onPressed: () {}, icon: const Icon(Icons.search)),
            IconButton(onPressed: () {}, icon: const Icon(Icons.filter_list)),
          ],
        ),
      ],
    );
  }

  Widget _buildFilterToggle() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.menu),
          ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
            ),
            child: const Icon(Icons.person_outline, color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildRecipeCard(BuildContext context, FoodItem recipe) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => RecipeDetailScreen(recipe: recipe),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 20),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                recipe.imagePath,
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    "Ingredients: ${recipe.ingredients.keys.take(4).join(', ')}...",
                    style: const TextStyle(color: Colors.grey, fontSize: 12),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: recipe.tags
                        .map((tag) => Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                              decoration: BoxDecoration(
                                color: Colors.grey[200],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: Text(tag, style: const TextStyle(fontSize: 10)),
                            ))
                        .toList(),
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
