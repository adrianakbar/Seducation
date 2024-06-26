import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/views/admin/navbar_admin.dart';
import 'package:flutter_application_1/views/user/navbar_user.dart';
import 'views/user/splashscreen_view.dart';
import 'views/auth/login_view.dart';
import 'views/auth/register_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // Atur rute aplikasi
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashscreenView(),
        '/homepageuser': (context) => const NavbarUser(),
        '/homepageadmin': (context) => const NavbarAdmin(),
        '/register': (context) => RegisterView(),
        '/logout': (context) => LoginView(),
      },
    );
  }
}
