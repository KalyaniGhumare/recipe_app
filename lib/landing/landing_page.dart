import 'package:recipe_app/auth/login/login.dart';
import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/data/sp_pref.dart';
import 'package:recipe_app/home/home.dart';
import 'package:recipe_app/stores/login_store.dart';
import 'package:recipe_app/utils/shared_pref_key.dart';

class LandingPage extends StatefulWidget {
  static const String id = 'splash';

  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage>
    with SingleTickerProviderStateMixin {
  AnimationController? controller;
  Animation? animation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(duration: const Duration(seconds: 2), vsync: this);
    animation = ColorTween(
      begin: ColorConstant.accentColor,
      end: ColorConstant.primaryColor,
    ).animate(controller!);
    controller?.forward();

    controller?.addListener(() {
      setState(() {});
    });

    _checkUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation?.value,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: DefaultTextStyle(
                style: const TextStyle(
                  fontSize: 36.0,
                  fontWeight: FontWeight.bold,
                ),
                child: AnimatedTextKit(
                  animatedTexts: [
                    TyperAnimatedText(
                      'Recipe App',
                      textAlign: TextAlign.center,
                      speed: const Duration(milliseconds: 100),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 28.0,
            ),
            CircularProgressIndicator(
              color: ColorConstant.white900,
            )
            //GoogleSignInButton(),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  Future<void> _checkUser() async {
    final _user = await SharedPref().read(SharedPrefKeys.SP_KEY_USER);
    print('_user ${_user.toString()}');
    if (_user == null) {
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const LoginPage()),
            (route) => false),
      );
    } else {
      Future.delayed(
        const Duration(seconds: 3),
        () => Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => const HomePage()),
            (route) => false),
      );
    }
  }
}
