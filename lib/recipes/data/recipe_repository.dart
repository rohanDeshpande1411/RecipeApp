import 'package:dio/dio.dart';
import 'package:recipeapp/core/storage/cache_storage.dart';

import '../../../core/network/api_constant.dart';

import '../../../core/network/dio_client.dart';

import 'recipe_model.dart';

class RecipeRepository {
  final DioClient client;
  final CacheStorage cache;

  RecipeRepository(this.client, this.cache);

  Future<List<RecipeModel>> getRecipes() async {
    try {
      Response response = await client.dio.get(ApiConstant.recipes);

      List data = response.data['recipes'];

      await cache.saveRecipes(data);

      return data.map((e) => RecipeModel.fromJson(e)).toList();
    } catch (e) {
      final cached = await cache.getRecipes();
      if (cached != null) {
        return cached.map((e) => RecipeModel.fromJson(e)).toList();
      }
      throw Exception("No Internet Connection");
    }
  }
}
