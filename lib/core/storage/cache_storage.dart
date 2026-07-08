import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CacheStorage {
  static const String recipeKey = "recipes_cache";

  Future<void> saveRecipes(List recipes) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(recipeKey, jsonEncode(recipes));
  }

  Future<List?> getRecipes() async {
    final prefs = await SharedPreferences.getInstance();

    String? data = prefs.getString(recipeKey);

    if (data != null) {
      return jsonDecode(data);
    }

    return null;
  }

  Future<void> clearCache() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(recipeKey);
  }
}
