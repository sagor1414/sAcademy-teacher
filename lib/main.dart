import 'package:edgefly_academy_admin/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'app/auth/view/signin_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'app/home_screen/view/home_screen.dart';
import 'app/settings/view/setting_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var isLogin = false;
  var auth = FirebaseAuth.instance;
  //checking if user logged in or not
  chekIfLogin() async {
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  @override
  void initState() {
    chekIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      getPages: [
        GetPage(
            name: '/',
            page: () => isLogin ? const HomeScreen() : const SigninScreen()),
        GetPage(name: '/settings', page: () => const SettingScreen()),
      ],
      title: 'Edge fly Academy',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: isLogin ? const HomeScreen() : const SigninScreen(),
    );
  }
}
