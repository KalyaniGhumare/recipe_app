import 'package:flutter/material.dart';
import 'package:recipe_app/model/receipe_model.dart';
import 'package:recipe_app/repository/recipe_repo.dart';

class RecipeDetailsStore extends ChangeNotifier {
  RecipeModel recipeDetails = RecipeModel();

  bool isLoading = false;

  RecipeRepository get repo => RecipeRepository();

  String id;

  RecipeDetailsStore({required this.id}) {
    fetchRecipeDetails();
  }

  Future<void> fetchRecipeDetails() async {
    final data = await repo.getRecipeDetails(id);
    recipeDetails = data;
    notifyListeners();
  }
}
