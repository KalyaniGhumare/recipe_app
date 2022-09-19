import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/create_recipe/create_recipe.dart';
import 'package:recipe_app/home/recipe_card.dart';
import 'package:recipe_app/stores/home_store.dart';
import 'package:recipe_app/widget/custom_text_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeStore(),
      builder: (context, snapshot) {
        final store = Provider.of<HomeStore>(context);
        return SafeArea(
          child: Scaffold(
            floatingActionButton: FloatingActionButton(
              backgroundColor: ColorConstant.primaryColor,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const CreateRecipePage(),
                  ),
                ).then((value) => store.fetchAllRecipes());
              },
              child: Icon(
                Icons.add,
                color: ColorConstant.white900,
              ),
            ),
            body: Container(
              color: Colors.grey.shade100,
              margin: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 20.0,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomTextView(
                    text: 'Recipes',
                    textAlign: TextAlign.center,
                    color: ColorConstant.primaryColor,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                  const SizedBox(
                    height: 10.0,
                  ),
                  Expanded(
                    child: store.isLoading
                        ? Center(
                            child: CircularProgressIndicator(
                              color: ColorConstant.primaryColor,
                            ),
                          )
                        : store.recipeList.isEmpty
                            ? Center(
                                child: CustomTextView(
                                  text:
                                      "Please add new recipes to see more details",
                                  textAlign: TextAlign.center,
                                  marginRight: 10.0,
                                  marginLeft: 10,
                                  maxLines: 2,
                                  color: ColorConstant.black900,
                                  fontSize: 18.0,
                                ),
                              )
                            : ListView.builder(
                                itemCount: store.recipeList.length,
                                itemBuilder: (context, index) => RecipeCard(
                                  recipeModel: store.recipeList[index],
                                ),
                              ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
