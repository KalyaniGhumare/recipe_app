import 'package:recipe_app/constant/export.dart';

import 'package:recipe_app/stores/create_recipe_store.dart';
import 'package:recipe_app/utils/dimensions.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class CreateRecipePage extends StatelessWidget {
  const CreateRecipePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => CreateRecipeStore(
        context: context,
      ),
      builder: (context, _) {
        final store = Provider.of<CreateRecipeStore>(context);
        return Scaffold(
          body: SafeArea(
            child: Column(
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
                            left: getHorizontalSize(
                              25.00,
                            ),
                            top: getVerticalSize(
                              24.00,
                            ),
                            bottom: getVerticalSize(
                              27.00,
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              // Navigator.of(context).pop();
                              store.canGoBack();
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
                                      child: Text(
                                        "Create New Recipe",
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        textScaleFactor: 1.0,
                                        style: TextStyle(
                                          color: ColorConstant.black900,
                                          fontSize: getFontSize(
                                            16,
                                          ),
                                          fontFamily: 'Georgia',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                        left: getHorizontalSize(
                                          10.00,
                                        ),
                                        top: getVerticalSize(
                                          10.00,
                                        ),
                                        right: getHorizontalSize(
                                          20.00,
                                        ),
                                      ),
                                      child: Text(
                                        store.pageTitle,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: ColorConstant.black900,
                                          fontSize: getFontSize(
                                            14,
                                          ),
                                          fontFamily: 'Georgia',
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.center,
                                      child: Container(
                                        height: getVerticalSize(
                                          7.00,
                                        ),
                                        margin: EdgeInsets.only(
                                          left: getHorizontalSize(
                                            27.00,
                                          ),
                                          top: getVerticalSize(
                                            18.00,
                                          ),
                                          right: getHorizontalSize(
                                            47.00,
                                          ),
                                        ),
                                        child: SmoothPageIndicator(
                                          count: store.onRecipePages.length,
                                          controller: store.pageController,
                                          axisDirection: Axis.horizontal,
                                          effect: ScrollingDotsEffect(
                                            spacing: 10,
                                            activeDotColor:
                                                ColorConstant.primaryColor,
                                            dotColor: ColorConstant.blueGray100,
                                            dotHeight: getVerticalSize(
                                              7.00,
                                            ),
                                            dotWidth: getHorizontalSize(
                                              7.00,
                                            ),
                                          ),
                                        ),
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
                  child: PageView.builder(
                    // itemCount: 4,
                    physics: const NeverScrollableScrollPhysics(),
                    controller: store.pageController,
                    itemBuilder: (context, position) {
                      // _controller.currentIndex(position);
                      return store
                          .onRecipePages[position % store.onRecipePages.length];
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
