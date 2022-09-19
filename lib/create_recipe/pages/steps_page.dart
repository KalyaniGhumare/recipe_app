import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/stores/create_recipe_store.dart';
import 'package:recipe_app/widget/custom_text_view.dart';

class StepsPage extends StatelessWidget {
  const StepsPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CreateRecipeStore>(context);
    return SafeArea(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    GestureDetector(
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
                                        store.getImage(
                                          source: ImageSource.camera,
                                          isRecipeImage: true,
                                          index: -1,
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
                                        store.getImage(
                                          source: ImageSource.gallery,
                                          isRecipeImage: true,
                                          index: -1,
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
                    ),
                    _showImage(
                      path: store.selectedImagePath,
                      context: context,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: GestureDetector(
                          onTap: () => store.addDynamicStepsEditor(
                            index: store.steps.length + 1,
                          ),
                          child: Text(
                            '+ Add Step',
                            overflow: TextOverflow.ellipsis,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: ColorConstant.primaryColor,
                              fontSize: getFontSize(
                                18,
                              ),
                              fontFamily: 'Georgia',
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                    ),
                    _listView(store: store),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
              ),
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(
                  ColorConstant.primaryColor,
                ),
                padding: MaterialStateProperty.all(const EdgeInsets.all(12)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28.0),
                  ),
                ),
              ),
              onPressed: () async {
                final isSave = await store.saveData();
                if (isSave) {
                  Navigator.of(context).pop();
                }
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
    );
  }

  Widget _listView({required CreateRecipeStore store}) {
    return ListView.builder(
      shrinkWrap: true,
      primary: false,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: store.steps.length,
      itemBuilder: (context, index) {
        String stepImage =
            store.stepImage.isNotEmpty ? store.stepImage[index] : '';
        print('index $index stepImage $stepImage');
        return Card(
          elevation: 2.0,
          child: Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 10.0,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                GestureDetector(
                  onTap: () {
                    if (store.steps.length > 1) {
                      store.steps.removeAt(index);
                      store.updateUI();
                    }
                  },
                  child: Align(
                    alignment: Alignment.topRight,
                    child: SizedBox(
                      height: 30.0,
                      width: 30.0,
                      child: Icon(
                        Icons.remove_circle,
                        color: Colors.red.shade400,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  child: store.steps[index],
                ),
                stepImage.isEmpty
                    ? Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: store.stepImageController[index],
                      )
                    : _showImage(
                        path: store.stepImage[index],
                        context: context,
                      ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _showImage({
    required String path,
    required BuildContext context,
  }) {
    print('path $path');
    return Visibility(
      visible: path.isNotEmpty,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Image.file(
          File(
            path,
          ),
          fit: BoxFit.fill,
          height: getVerticalSize(
            200.00,
          ),
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
  }
}
