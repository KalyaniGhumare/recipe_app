import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/stores/create_recipe_store.dart';
import 'package:recipe_app/widget/custom_text_view.dart';

class IngredientsPage extends StatefulWidget {
  const IngredientsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<IngredientsPage> createState() => _IngredientsPageState();
}

class _IngredientsPageState extends State<IngredientsPage> {
  Widget _listView({required CreateRecipeStore store}) {
    return ReorderableListView(
      onReorder: (oldIndex, newIndex) => store.reorderData(
        newIndex: newIndex,
        oldIndex: oldIndex,
      ),
      children: <Widget>[
        for (final items in store.fields)
          Card(
            key: ValueKey(items),
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
                      if (store.fields.length > 1) {
                        final index = store.fields.indexOf(items);
                        store.fields.removeAt(index);
                        store.fields2.removeAt(index);
                        setState(() {});
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
                    child: items,
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 10.0),
                    child: store.fields2[store.fields.indexOf(items)],
                  ),
                ],
              ),
            ),
          )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = Provider.of<CreateRecipeStore>(context);
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 20.0,
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 20.0),
                child: GestureDetector(
                  onTap: () => store.addDynamicController(),
                  child: Text(
                    '+ Add',
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
            Expanded(
                child: _listView(
              store: store,
            )),
            const SizedBox(
              height: 40,
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
                store.saveIngredientsDetails();
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
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
