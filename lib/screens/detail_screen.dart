import 'package:flutter/material.dart';
import 'package:recipeapp/recipes/data/recipe_model.dart';

class DetailScreen extends StatelessWidget {
  final RecipeModel recipe;

  const DetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(recipe.name)),
        body: SingleChildScrollView(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(recipe.image,
                            height: 220,
                            width: double.infinity,
                            fit: BoxFit.cover),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        recipe.name,
                        style: const TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Row(children: [
                        Text("⭐ ${recipe.rating}"),
                        const SizedBox(width: 20),
                        Text(recipe.cuisine)
                      ]),
                      const SizedBox(height: 20),
                      Text(
                        "Cooking Time: ${recipe.cookTime} minutes",
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        "Ingredients",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ...recipe.ingredients.map((item) => Text("• $item")),
                      const SizedBox(height: 20),
                      const Text(
                        "Instructions",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      ...recipe.instructions.map((step) => Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(step),
                          ))
                    ]))));
  }
}
