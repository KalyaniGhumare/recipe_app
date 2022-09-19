import 'package:flutter/material.dart';
import 'package:recipe_app/data/sp_pref.dart';
import 'package:recipe_app/model/receipe_model.dart';
import 'package:recipe_app/repository/recipe_repo.dart';
import 'package:recipe_app/utils/shared_pref_key.dart';

class HomeStore extends ChangeNotifier {
  final List<RecipeModel> recipeList = [];

  bool isLoading = true;

  HomeStore() {
    _onInit();
  }

  RecipeRepository get repo => RecipeRepository();

  _onInit() {
    fetchAllRecipes();
  }

  Future<void> fetchAllRecipes() async {
    _toggled(true);
    recipeList.clear();
    final data = await repo.getRecipes();
    recipeList.addAll(data);
    _toggled(false);
  }

  _toggled(bool value) {
    isLoading = value;
    notifyListeners();
  }
}
