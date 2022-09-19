import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/model/receipe_model.dart';
import 'package:recipe_app/recipe_details/recipe_details.dart';
import 'package:recipe_app/widget/custom_text_view.dart';

class RecipeCard extends StatelessWidget {
  final RecipeModel recipeModel;

  const RecipeCard({
    Key? key,
    required this.recipeModel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => RecipeDetails(
              id: recipeModel.id ?? '',
            ),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Card(
          elevation: 2.0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: Colors.white.withOpacity(0.6),
                  offset: const Offset(
                    0.0,
                    10.0,
                  ),
                  blurRadius: 10.0,
                  spreadRadius: -6.0,
                ),
              ],
              image: DecorationImage(
                colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.35),
                  BlendMode.multiply,
                ),
                image: NetworkImage(recipeModel.recipeImage ?? ''),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5.0),
                    child: CustomTextView(
                      text: recipeModel.recipeName ?? "",
                      fontSize: 19,
                      color: Colors.white,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.8),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.star,
                                color: ColorConstant.primaryColor,
                                size: 18,
                              ),
                              const SizedBox(width: 7),
                              const Flexible(
                                child: CustomTextView(
                                  text: "rating",
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const Spacer(),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          margin: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.schedule,
                                color: ColorConstant.primaryColor,
                                size: 18,
                              ),
                              const SizedBox(width: 7),
                              Flexible(
                                child: CustomTextView(
                                  text: '${recipeModel.time}',
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
