import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/stores/create_recipe_store.dart';
import 'package:recipe_app/widget/custom_text_view.dart';

class RecipePage extends StatelessWidget {
  const RecipePage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CreateRecipeStore>(context);
    return store.isLoading
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            margin: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Form(
              key: store.recipeDetailsKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          bottom: getVerticalSize(
                            17.00,
                          ),
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Recipe Name",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.black90087,
                                  fontSize: getFontSize(
                                    18,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextFormField(
                              initialValue: 'Chicken Masala',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if ((value ?? '').isEmpty) {
                                  return 'Please Enter Recipe Name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                store.recipeName = value;
                              },
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Instructions",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.black90087,
                                  fontSize: getFontSize(
                                    18,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextFormField(
                              initialValue: 'Chicken Masala',
                              maxLines: 6,
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if ((value ?? '').isEmpty) {
                                  return 'Please Enter Instructions';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                store.instructions = value;
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Preparation Time",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.black90087,
                                  fontSize: getFontSize(
                                    18,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    initialValue: '1 hr',
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if ((value ?? '').isEmpty) {
                                        return 'Please Enter Preparation Time';
                                      }
                                      return null;
                                    },
                                    onSaved: (value) {
                                      store.preparationHr =
                                          (value ?? '0').isEmpty
                                              ? '0'
                                              : '$value';
                                    },
                                  ),
                                ),
                                const SizedBox(
                                  width: 20.0,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    maxLines: 1,
                                    style: const TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w400,
                                    ),
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      return null;
                                    },
                                    onSaved: (value) {
                                      store.preparationMin =
                                          (value ?? '0').isEmpty
                                              ? '0'
                                              : '$value';
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Personal Touch",
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  color: ColorConstant.black90087,
                                  fontSize: getFontSize(
                                    18,
                                  ),
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            TextFormField(
                              maxLines: 4,
                              initialValue: 'Chicken Masala',
                              style: const TextStyle(
                                fontSize: 16.0,
                                fontWeight: FontWeight.w400,
                              ),
                              keyboardType: TextInputType.emailAddress,
                              onSaved: (value) {
                                store.personalTouch = value;
                              },
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(
                                  ColorConstant.primaryColor,
                                ),
                                padding: MaterialStateProperty.all(
                                    const EdgeInsets.all(12)),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(28.0),
                                  ),
                                ),
                              ),
                              onPressed: () async {
                                store.saveRecipeDetails();
                              },
                              child: store.isLoading
                                  ? CircularProgressIndicator(
                                      color: ColorConstant.white900,
                                    )
                                  : CustomTextView(
                                      text: 'Next',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: ColorConstant.white900,
                                    ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
