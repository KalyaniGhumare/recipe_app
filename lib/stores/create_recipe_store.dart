import 'dart:io';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:recipe_app/create_recipe/pages/ingredients_page.dart';
import 'package:recipe_app/create_recipe/pages/recipe_page.dart';
import 'package:recipe_app/create_recipe/pages/steps_page.dart';

import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/model/ingredient_details.dart';
import 'package:recipe_app/model/receipe_model.dart';
import 'package:recipe_app/model/step_details.dart';
import 'package:recipe_app/repository/recipe_repo.dart';
import 'package:recipe_app/widget/custom_text_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../constant/export.dart';

class CreateRecipeStore extends ChangeNotifier {
  CreateRecipeStore({required this.context});

  BuildContext context;

  String? recipeName,
      instructions,
      personalTouch,
      preparationHr,
      preparationMin;

  List<IngredientDetails> ingredientDetailsList = [];
  List<StepDetails> stepDetailsList = [];

  RecipeRepository get repo => RecipeRepository();

  final onRecipePages = [
    const RecipePage(),
    const IngredientsPage(),
    const StepsPage(),
  ];

  final pageLabelNameList = [
    "Recipe Details",
    "Ingredients Details",
    "Steps Details",
  ];

  String pageTitle = "";

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  final List<TextEditingController> nameControllers = [];
  final List<TextEditingController> quantityController = [];
  List<Widget> fields = [];
  final List<Widget> fields2 = [];

  final List<TextEditingController> stepController = [];
  final List<Widget> stepImageController = [];
  List<Widget> steps = [];
  List<String> stepImage = [];

  final List<Ingredient> ingredientList = [];
  final List<Step> stepsList = [];

  int currentIndex = 0;
  bool isLoading = false;

  final recipeDetailsKey = GlobalKey<FormState>();
  final ingredientsDetailsKey = GlobalKey<FormState>();
  final stepsDetailsKey = GlobalKey<FormState>();

  late String selectedImagePath = '';
  String selectedCropImagePath = '';
  String selectedImageSize = '';
  String compressImagePath = '';
  String compressImageSize = '';
  String selectedCropImageSize = '';

  void saveRecipeDetails() {
    final bool isValid = recipeDetailsKey.currentState?.validate() ?? false;

    recipeDetailsKey.currentState!.save();

    if (isValid) {
      pageController.jumpToPage(currentIndex + 1);
      currentIndex = currentIndex + 1;
      getPageLabel();
      if (fields.isEmpty) {
        for (int i = 0; i < 2; i++) {
          addDynamicController();
        }
      }
    }
  }

  void addDynamicController() {
    final controller = TextEditingController();
    final controller2 = TextEditingController();
    final field = Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: "Ingredient Name",
        ),
      ),
    );

    final field2 = TextFormField(
      controller: controller2,
      decoration: const InputDecoration(
        border: OutlineInputBorder(),
        labelText: "Quantity",
      ),
    );

    nameControllers.add(controller);
    quantityController.add(controller2);
    fields.add(field);
    fields2.add(field2);
    notifyListeners();
  }

  void saveIngredientsDetails() {
    for (var element in nameControllers) {
      final String ingredientName = element.text;
      if (ingredientName.isNotEmpty) {
        final index = nameControllers.indexOf(element);
        final controller = quantityController[index];

        IngredientDetails ingredient = IngredientDetails(
          id: index,
          name: ingredientName,
          quantity: controller.text,
        );

        ingredientDetailsList.add(ingredient);
      }
    }

    if (ingredientDetailsList.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one instruction'),
        ),
      );
      return;
    }
    pageController.jumpToPage(currentIndex + 1);
    currentIndex = currentIndex + 1;

    getPageLabel();

    if (steps.isEmpty) {
      for (int i = 0; i < 2; i++) {
        addDynamicStepsEditor(index: i);
      }
    }
  }

  void saveRecipe() {
    final bool isValid = recipeDetailsKey.currentState?.validate() ?? false;

    if (isValid) {
      pageController.jumpToPage(currentIndex + 1);
      currentIndex = currentIndex + 1;
      getPageLabel();
    }
  }

  void getPageLabel() {
    pageTitle = pageLabelNameList.elementAt(currentIndex);
    notifyListeners();
  }

  Future<void> addDynamicStepsEditor({required int index}) async {
    final controller = TextEditingController();
    final field = Container(
      margin: const EdgeInsets.only(bottom: 10.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: "Step ${stepController.length + 1}",
        ),
      ),
    );

    final image = GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: CustomTextView(
                  text: 'Upload Image',
                  fontWeight: FontWeight.bold,
                  color: ColorConstant.black900,
                ),
                content: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        getImage(
                          source: ImageSource.camera,
                          isRecipeImage: false,
                          index: index,
                        );
                      },
                      child: CustomTextView(
                        text: 'Camera',
                        fontWeight: FontWeight.normal,
                        color: ColorConstant.black900,
                      ),
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        getImage(
                          source: ImageSource.gallery,
                          isRecipeImage: false,
                          index: index,
                        );
                      },
                      child: CustomTextView(
                        text: 'Gallery',
                        fontWeight: FontWeight.normal,
                        color: ColorConstant.black900,
                      ),
                    )
                  ],
                ),
              );
            });
      },
      child: CustomTextView(
        text: 'Upload Recipe Image',
        textAlign: TextAlign.start,
        color: ColorConstant.black900,
        fontSize: getFontSize(
          16,
        ),
        fontFamily: 'Georgia',
        fontWeight: FontWeight.w700,
      ),
    );
    stepController.add(controller);
    steps.add(field);
    stepImageController.add(image);
    stepImage.add('');
    notifyListeners();
  }

  void updateUI() {
    notifyListeners();
  }

  Future<void> getImage({
    required ImageSource source,
    bool isRecipeImage = false,
    required int index,
  }) async {
    final ImagePicker picker = ImagePicker();
    final image = await picker.pickImage(source: source);
    if (image != null) {
      if (isRecipeImage) {
        selectedImagePath = image.path;
        selectedImageSize =
            "${((File(selectedImagePath)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

        // Crop
        final CroppedFile? cropImageFile = await ImageCropper().cropImage(
          sourcePath: selectedImagePath,
          maxWidth: 512,
          maxHeight: 512,
          compressFormat: ImageCompressFormat.jpg,
        );
        selectedCropImagePath = cropImageFile?.path ?? '';
        selectedCropImageSize =
            "${((File(selectedCropImagePath)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";

        final dir = Directory.systemTemp;
        final targetPath = "${dir.absolute.path}/temp.jpg";
        var compressedFile = await FlutterImageCompress.compressAndGetFile(
            selectedCropImagePath, targetPath,
            quality: 90);
        compressImagePath = compressedFile?.path ?? '';
        compressImageSize =
            "${((File(compressImagePath)).lengthSync() / 1024 / 1024).toStringAsFixed(2)} Mb";
        notifyListeners();
      } else {
        stepImage.insert(index, image.path);
        notifyListeners();
      }
    } else {
      // Get.snackbar("Error", "No Image Selected.",
      //     snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<bool> saveData() async {
    if (stepImage.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please add at least one step'),
        ),
      );
      return false;
    }

    _toggled(true);
    String cookingTime = '';
    if ((preparationHr ?? '').compareTo('0') != 0 &&
        int.parse(preparationHr ?? '0') > 0) {
      cookingTime = '$preparationHr Hr';
    }

    if ((preparationMin ?? '').compareTo('0') != 0 &&
        int.parse(preparationMin ?? '0') > 0) {
      cookingTime = '$cookingTime $preparationMin Min';
    }

    RecipeModel recipeModel = RecipeModel()
      ..recipeName = recipeName
      ..instructions = instructions
      ..time = cookingTime
      ..personalTouch = personalTouch
      ..ingredient = ingredientDetailsList;
    DocumentReference data = await repo.addRecipe(recipeModel);
    recipeModel.referenceId = data.id;
    final recipeImage = await uploadImage(file: File(compressImagePath));

    recipeModel.referenceId = data.id;
    recipeModel.recipeImage = recipeImage;
    for (var element in stepController) {
      if (element.text.isNotEmpty) {
        final index = stepController.indexOf(element);
        final path = stepImage[index];
        String url = "";
        if (path.isNotEmpty) {
          url = await addStepImage(file: File(path));
        }

        if (element.text.isNotEmpty) {
          stepDetailsList.add(StepDetails(
            id: index,
            name: element.text,
            imageUrl: url,
          ));
        }
      }
    }

    recipeModel.recipeImage = recipeImage;
    recipeModel.stepDetails = stepDetailsList;

    await repo.updateRecipeImage(recipeModel);
    _toggled(false);
    return true;
  }

  _toggled(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future<String> uploadImage({
    required File file,
  }) async {
    final storageReference = FirebaseStorage.instance.ref('recipe_images');

    final _ref = storageReference.child(basename(file.path));
    final uploadTask = await _ref.putFile(file);

    if (uploadTask.state == TaskState.success) {
      final downloadImageUrl = FirebaseStorage.instance
          .ref('recipe_images')
          .child(basename(file.path))
          .getDownloadURL();
      return downloadImageUrl;
    }
    return '';
  }

  Future<String> addStepImage({required File file}) async {
    final storageReference = FirebaseStorage.instance.ref('step_images');

    final _ref = storageReference.child(basename(file.path));
    final task = await _ref.putFile(file);
    if (task.state == TaskState.success) {
      final downloadImageUrl = await FirebaseStorage.instance
          .ref('step_images')
          .child(basename(file.path))
          .getDownloadURL();
      return downloadImageUrl;
    }
    return '';
  }

  void canGoBack() {
    if (currentIndex < 3 && currentIndex != 0) {
      pageController.jumpToPage(currentIndex - 1);
      currentIndex = (currentIndex - 1);
      getPageLabel();
    } else if (currentIndex == 0) {
      Navigator.of(context).pop();
    }
    updateUI();
  }

  reorderData({required int oldIndex, required int newIndex}) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final items = fields.removeAt(oldIndex);
    final items2 = fields2.removeAt(oldIndex);
    fields.insert(newIndex, items);
    fields2.insert(newIndex, items2);
    notifyListeners();
  }
}

class Ingredient {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? quantityController = TextEditingController();
  String? name, quantity;

  Ingredient({
    this.name,
    this.quantity,
    this.nameController,
    this.quantityController,
  });
}

class Step {
  TextEditingController? stepController = TextEditingController();
  String? path;

  Step({
    this.stepController,
    this.path,
  });
}
