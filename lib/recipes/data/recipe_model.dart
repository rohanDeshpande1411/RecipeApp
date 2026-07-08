class RecipeModel {
  final int id;

  final String name;

  final String image;

  final double rating;

  final String cuisine;

  final int cookTime;

  final List ingredients;

  final List instructions;

  RecipeModel({
    required this.id,
    required this.name,
    required this.image,
    required this.rating,
    required this.cuisine,
    required this.cookTime,
    required this.ingredients,
    required this.instructions,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'] ?? "",
      image: json['image'] ?? "",
      rating: (json['rating'] ?? 0).toDouble(),
      cuisine: json['cuisine'] ?? "",
      cookTime: json['cookTimeMinutes'] ?? 0,
      ingredients: json['ingredients'] ?? [],
      instructions: json['instructions'] ?? [],
    );
  }
}
