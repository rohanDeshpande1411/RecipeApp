import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/recipe_repository.dart';

import 'recipe_event.dart';

import 'recipe_state.dart';

class RecipeBloc extends Bloc<RecipeEvent, RecipeState> {
  final RecipeRepository repository;

  RecipeBloc(this.repository) : super(RecipeInitial()) {
    on<FetchRecipes>(_fetchRecipes);
  }

  Future<void> _fetchRecipes(
      FetchRecipes event, Emitter<RecipeState> emit) async {
    emit(RecipeLoading());

    try {
      final recipes = await repository.getRecipes();

      if (recipes.isEmpty) {
        emit(RecipeError("No Recipes Found"));
      } else {
        emit(RecipeSuccess(recipes));
      }
    } catch (e) {
      emit(RecipeError(e.toString()));
    }
  }
}
