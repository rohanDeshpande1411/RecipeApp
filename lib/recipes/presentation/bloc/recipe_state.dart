import 'package:equatable/equatable.dart';

import '../../data/recipe_model.dart';

abstract class RecipeState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeLoading extends RecipeState {}

class RecipeSuccess extends RecipeState {
  final List<RecipeModel> recipes;

  RecipeSuccess(this.recipes);

  @override
  List<Object?> get props => [recipes];
}

class RecipeError extends RecipeState {
  final String message;

  RecipeError(this.message);

  @override
  List<Object?> get props => [message];
}
