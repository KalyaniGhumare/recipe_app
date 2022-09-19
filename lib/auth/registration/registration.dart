import 'package:flutter/gestures.dart';
import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/stores/registration_store.dart';
import 'package:recipe_app/utils/snackbar_utils.dart';
import 'package:recipe_app/widget/custom_text_view.dart';

class RegistrationPage extends StatelessWidget {
  static const String id = 'registration';

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => RegistrationStore(),
        builder: (context, snapshot) {
          final store = Provider.of<RegistrationStore>(context);

          store.showMessage = (String message) {
            showSnackBar(context, message);
          };

          return SafeArea(
            child: Scaffold(
              body: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: 20.0,
                ),
                child: Form(
                  key: store.formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: GestureDetector(
                          onTap: () => Navigator.of(context).pop(),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10.0, vertical: 20.0),
                            child: Icon(
                              Icons.arrow_back,
                              color: ColorConstant.black900,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 30.0,
                      ),
                      Expanded(
                        child: ListView(
                          children: [
                            const CustomTextView(
                              text: "Let's Get Started",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.w700,
                              fontSize: 22,
                            ),
                            const SizedBox(
                              height: 10.0,
                            ),
                            const CustomTextView(
                              text:
                                  "Create an account to Recipe App to get all features",
                              maxLines: 2,
                              textAlign: TextAlign.center,
                              fontWeight: FontWeight.normal,
                              fontSize: 16,
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                              child: TextFormField(
                                // controller: firstNameController,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'First Name',
                                    textScaleFactor: 1.0,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onSaved: (value) {
                                  store.fName = value;
                                },
                                validator: (value) {
                                  if ((value ?? '').isEmpty) {
                                    return 'Please Enter First Name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                              child: TextFormField(
                                // controller: firstNameController,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.text,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'Last Name',
                                    textScaleFactor: 1.0,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                onSaved: (value) {
                                  store.lName = value;
                                },
                                validator: (value) {
                                  if ((value ?? '').isEmpty) {
                                    return 'Please Enter Last Name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(30.0),
                                ),
                              ),
                              child: TextFormField(
                                // controller: firstNameController,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                keyboardType: TextInputType.emailAddress,
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'Email',
                                    textScaleFactor: 1.0,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                validator: (value) {
                                  if ((value ?? '').isEmpty) {
                                    return 'Please Enter Email';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  store.email = value;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20.0,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey,
                                ),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(28.0),
                                ),
                              ),
                              child: TextFormField(
                                // controller: firstNameController,
                                style: const TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w400,
                                ),
                                decoration: const InputDecoration(
                                  border: InputBorder.none,
                                  label: Text(
                                    'Password',
                                    textScaleFactor: 1.0,
                                  ),
                                  labelStyle: TextStyle(
                                    fontSize: 16.0,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                                validator: (value) {
                                  if ((value ?? '').isEmpty) {
                                    return 'Please Enter Password';
                                  } else if ((value ?? '').length < 10) {
                                    return 'Please Enter Valid Password';
                                  }
                                  return null;
                                },
                                onSaved: (value) {
                                  store.password = value;
                                },
                              ),
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
                                final isCreate = await store.signUpUser();
                                if (isCreate) {
                                  Navigator.of(context).pop();
                                }
                              },
                              child: store.isLoading
                                  ? CircularProgressIndicator(
                                      color: ColorConstant.white900,
                                    )
                                  : CustomTextView(
                                      text: 'Sign Up',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: ColorConstant.white900,
                                    ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text: 'Already have an account?',
                                style: TextStyle(
                                  fontWeight: FontWeight.normal,
                                  color: ColorConstant.black900,
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: ' Login here',
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      color: ColorConstant.primaryColor,
                                    ),
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                const RegistrationPage(),
                                          ),
                                        );
                                      },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }
}
