import 'package:cafem/controller/Auth_controller.dart';
import 'package:cafem/controller/food_controller.dart';
import 'package:cafem/firebase_options.dart';
import 'package:cafem/views/home_Screen.dart';
import 'package:cafem/views/sign_in_screen.dart';
import 'package:cafem/views/sign_up_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

enum Routes { splash, signin, signnup, homescreen }

final navigatorKey = GlobalKey<NavigatorState>();
BuildContext get appContext => navigatorKey.currentState!.context;

Logger logger = Logger();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(Cafem());
}

class Cafem extends StatelessWidget {
  Cafem({super.key});
  GoRouter router = GoRouter(
    navigatorKey: navigatorKey,
    routes: [
      GoRoute(
        path: '/',
        name: Routes.signin.name,
        builder: (context, state) => SignInScreen(),
      ),
      GoRoute(
        path: '/signup',
        name: Routes.signnup.name,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: '/home',
        name: Routes.homescreen.name,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(430, 932),
      child: MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthController()),
            ChangeNotifierProvider(create: (_) => FoodController()),
          ],
          child: MaterialApp.router(
            debugShowCheckedModeBanner: false,
            routerConfig: router,
          )),
    );
  }
}
