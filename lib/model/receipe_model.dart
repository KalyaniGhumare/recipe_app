import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recipe_app/model/ingredient_details.dart';
import 'package:recipe_app/model/step_details.dart';

class RecipeModel {
  String? id,
      recipeName,
      instructions,
      personalTouch,
      time,
      referenceId,
      recipeImage;

  List<IngredientDetails>? ingredient;
  List<StepDetails>? stepDetails;
  File? file;

  RecipeModel({
    this.id,
    this.recipeName,
    this.instructions,
    this.personalTouch,
    this.time,
    this.referenceId,
    this.file,
    this.ingredient,
    this.stepDetails,
  });

  factory RecipeModel.fromSnapshot(DocumentSnapshot snapshot) {
    final newRecipe =
        RecipeModel.fromJson(snapshot.data() as Map<String, dynamic>);
    newRecipe.referenceId = snapshot.reference.id;
    return newRecipe;
  }

  RecipeModel.fromJson(Map<dynamic, dynamic> json) {
    id = json['id'];
    recipeName = json['name'];
    time = json['durations'];
    instructions = json['instructions'];
    personalTouch = json['personal_touch'];
    recipeImage = json['image'];
    ingredient = [];
    if (json['ingredient'] != null) {
      json['ingredient'].forEach((v) {
        ingredient?.add(IngredientDetails.fromJson(v));
      });
    }
    stepDetails = [];
    if (json['steps'] != null) {
      json['steps'].forEach((v) {
        stepDetails?.add(StepDetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = recipeName;
    data['durations'] = time;
    data['instructions'] = instructions;
    data['personal_touch'] = personalTouch;
    data['image'] = recipeImage;
    data['image'] = recipeImage;
    if (ingredient != null) {
      data['ingredient'] = ingredient?.map((v) => v.toJson()).toList();
    }
    if (stepDetails != null) {
      data['steps'] = stepDetails?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
