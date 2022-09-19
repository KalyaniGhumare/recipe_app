import 'package:flutter/gestures.dart';
import 'package:recipe_app/auth/registration/registration.dart';
import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/home/home.dart';
import 'package:recipe_app/stores/login_store.dart';
import 'package:recipe_app/widget/custom_text_view.dart';

class LoginPage extends StatelessWidget {
  static const String id = 'login';

  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => LoginStore(),
      builder: (context, _) {
        final store = Provider.of<LoginStore>(context);
        return SafeArea(
          child: Scaffold(
            body: Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20.0,
              ),
              child: Form(
                key: store.formKey,
                child: Align(
                  alignment: Alignment.center,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const CustomTextView(
                          text: "Welcome Back!",
                          maxLines: 2,
                          textAlign: TextAlign.center,
                          fontWeight: FontWeight.w700,
                          fontSize: 22,
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        const CustomTextView(
                          text: "Log in to your existing account to Recipe App",
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
                            initialValue: 'kalyani@gmail.com',
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
                            initialValue: 'Qwerty123456',
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
                            final isLogin =
                                await store.signInUsingEmailPassword();
                            if (isLogin) {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => HomePage()),
                                  (route) => false);
                            }
                          },
                          child: store.isLoading
                              ? CircularProgressIndicator(
                                  color: ColorConstant.white900,
                                )
                              : CustomTextView(
                                  text: 'Sign In',
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
                            text: 'New Account Here?',
                            style: TextStyle(
                              fontWeight: FontWeight.normal,
                              color: ColorConstant.black900,
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: ' Sign Up',
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
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
