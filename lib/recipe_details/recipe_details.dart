import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/model/ingredient_details.dart';
import 'package:recipe_app/model/step_details.dart';
import 'package:recipe_app/stores/recipe_details_store.dart';
import 'package:recipe_app/utils/dimensions.dart';
import 'package:recipe_app/widget/custom_text_view.dart';

class RecipeDetails extends StatelessWidget {
  final String id;

  const RecipeDetails({
    Key? key,
    required this.id,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RecipeDetailsStore(id: id),
      builder: (context, snapshot) {
        final store = Provider.of<RecipeDetailsStore>(context);
        return Scaffold(
          body: Container(
            margin:
                const EdgeInsets.symmetric(horizontal: 10.0, vertical: 40.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstant.gray100,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                            top: getVerticalSize(
                              24.00,
                            ),
                            bottom: getVerticalSize(
                              27.00,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            constraints: BoxConstraints(
                              minHeight: getSize(
                                29.00,
                              ),
                              minWidth: getSize(
                                29.00,
                              ),
                            ),
                            padding: const EdgeInsets.all(0),
                            icon: Container(
                              width: getSize(
                                29.00,
                              ),
                              height: getSize(
                                29.00,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConstant.gray100,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    14.50,
                                  ),
                                ),
                              ),
                              padding: EdgeInsets.only(
                                left: getHorizontalSize(
                                  DimensionConstant.xxs,
                                ),
                                top: getVerticalSize(
                                  DimensionConstant.xxs,
                                ),
                                right: getHorizontalSize(
                                  DimensionConstant.xxs,
                                ),
                                bottom: getVerticalSize(
                                  DimensionConstant.xxs,
                                ),
                              ),
                              child: Icon(
                                Icons.arrow_back,
                                color: ColorConstant.black900,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Center(
                            child: Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(
                                  top: getVerticalSize(
                                    32.00,
                                  ),
                                  bottom: getVerticalSize(
                                    11.00,
                                  ),
                                ),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: CustomTextView(
                                        text: "Recipe Details",
                                        textAlign: TextAlign.center,
                                        color: ColorConstant.black900,
                                        fontSize: getFontSize(
                                          18,
                                        ),
                                        fontFamily: 'Georgia',
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: store.isLoading
                      ? const CircularProgressIndicator()
                      : ListView(
                          children: [
                            Container(
                              color: Colors.grey,
                              height: 200.0,
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                store.recipeDetails.recipeImage ?? '',
                              ),
                            ),
                            _singleData(
                              title: "Recipe Name",
                              value: store.recipeDetails.recipeName ?? '',
                            ),
                            _singleData(
                              title: "Instruction",
                              value: store.recipeDetails.instructions ?? '',
                            ),
                            _singleData(
                              title: "Prepared Time",
                              value: store.recipeDetails.time ?? '',
                            ),
                            _singleData(
                              title: "Personal Touch",
                              value: store.recipeDetails.personalTouch ?? '',
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(
                                horizontal: 10.0,
                              ),
                              child: CustomTextView(
                                text: 'Ingredient Details',
                                fontSize: 14.0,
                                color: ColorConstant.black90087,
                              ),
                            ),
                            const SizedBox(
                              height: 6.0,
                            ),
                            ...(store.recipeDetails.ingredient ?? []).map(
                              (e) => _singleInstruction(ingredient: e),
                            ),
                            Visibility(
                              visible: (store.recipeDetails.stepDetails ?? [])
                                  .isNotEmpty,
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  Container(
                                    margin: const EdgeInsets.symmetric(
                                      horizontal: 10.0,
                                    ),
                                    child: CustomTextView(
                                      text: 'Step Details',
                                      fontSize: 14.0,
                                      color: ColorConstant.black90087,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 6.0,
                                  ),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount:
                                          (store.recipeDetails.stepDetails ??
                                                  [])
                                              .length,
                                      itemBuilder: (context, index) {
                                        final step = store
                                            .recipeDetails.stepDetails![index];
                                        return _singleSteps(
                                          index: index + 1,
                                          stepDetails: step,
                                          context: context,
                                        );
                                      }),
                                ],
                              ),
                            ),
                            _singleData(
                              title: "Personal Touch",
                              value: store.recipeDetails.personalTouch ?? '',
                            ),
                          ],
                        ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _singleData({
    required String title,
    required String value,
  }) {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 8.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CustomTextView(
            text: title,
            fontSize: 14.0,
            color: ColorConstant.black90087,
          ),
          const SizedBox(
            height: 6.0,
          ),
          CustomTextView(
            text: value,
            fontSize: 16.0,
          ),
        ],
      ),
    );
  }

  Widget _singleInstruction({
    required IngredientDetails ingredient,
  }) {
    return (ingredient.name ?? '').isNotEmpty
        ? Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10.0,
              vertical: 5.0,
            ),
            child: CustomTextView(
              text: '${ingredient.name} : ${ingredient.quantity}',
              fontSize: 16.0,
            ),
          )
        : const SizedBox();
  }

  Widget _singleSteps({
    required int index,
    required StepDetails stepDetails,
    required BuildContext context,
  }) {
    return (stepDetails.name ?? '').isNotEmpty
        ? Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 10.0,
                  vertical: 5.0,
                ),
                child: CustomTextView(
                  text: '$index. ${stepDetails.name}',
                  fontSize: 16.0,
                ),
              ),
              (stepDetails.imageUrl ?? '').isNotEmpty
                  ? Container(
                      height: 160,
                      width: MediaQuery.of(context).size.width,
                      margin: const EdgeInsets.symmetric(
                        horizontal: 10.0,
                        vertical: 5.0,
                      ),
                      child: Image.network(
                        stepDetails.imageUrl ?? '',
                        fit: BoxFit.fill,
                      ),
                    )
                  : const SizedBox(),
            ],
          )
        : const SizedBox();
  }
}
