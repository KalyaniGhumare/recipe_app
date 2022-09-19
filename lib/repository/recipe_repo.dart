import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/receipe_model.dart';

class RecipeRepository {
  final CollectionReference collection =
      FirebaseFirestore.instance.collection('recipes');

  Future<List<RecipeModel>> getRecipes() async {
    List<RecipeModel> recipeList = [];
    QuerySnapshot userSnapShot = await collection.get();
    for (var element in userSnapShot.docs) {
      final referenceId = element.reference.id;
      print('referenceId $referenceId');
      final data = element.data() as Map<dynamic, dynamic>;
      RecipeModel model = RecipeModel.fromJson(data);
      model.id = referenceId;
      recipeList.add(model);
    }
    return recipeList;
  }

  Future<RecipeModel> getRecipeDetails(String id) async {
    print('getRecipeDetails $id');
    final userSnapShot = await collection.doc(id).get();
    print('userSnapShot ${userSnapShot.data()}');
    final data = userSnapShot.data() as Map<dynamic, dynamic>;
    RecipeModel model = RecipeModel.fromJson(data);
    print('model ${model.recipeName}');
    print('stepDetails ${model.stepDetails?.length}');
    return model;
  }

  Future<DocumentReference> addRecipe(RecipeModel recipeModel) {
    return collection.add(recipeModel.toJson());
  }

  Future<void> updateRecipeImage(RecipeModel recipeModel) async {
    await collection.doc(recipeModel.referenceId).update(recipeModel.toJson());
  }

  void updateRecipe(RecipeModel recipeModel) async {
    await collection.doc(recipeModel.referenceId).update(recipeModel.toJson());
  }

  void deleteRecipe(RecipeModel recipeModel) async {
    await collection.doc(recipeModel.referenceId).delete();
  }
}
