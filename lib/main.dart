import 'package:recipe_app/auth/login/login.dart';
import 'package:recipe_app/auth/registration/registration.dart';
import 'package:recipe_app/constant/export.dart';
import 'package:recipe_app/landing/landing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const AppPage(),
    );
  }
}

class AppPage extends StatefulWidget {
  const AppPage({Key? key}) : super(key: key);

  @override
  State<AppPage> createState() => _AppPageState();
}

class _AppPageState extends State<AppPage> {
  var refDatabase = FirebaseDatabase.instance.ref().child("Kategori");

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: ColorConstant.primaryColor,
        fontFamily: 'Georgia',
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: LandingPage.id,
      routes: {
        LandingPage.id: (context) => const LandingPage(),
        LoginPage.id: (context) => const LoginPage(),
        RegistrationPage.id: (context) => const RegistrationPage(),
      },
    );
  }
}
