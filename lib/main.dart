import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:turfix_admin/firebase_options.dart';
import 'package:turfix_admin/view/auth/splash_screen.dart';
import 'package:turfix_admin/view_model/booking_provider.dart';
import 'package:turfix_admin/view_model/common_provider.dart';
import 'package:turfix_admin/view_model/owner_provider.dart';
import 'package:turfix_admin/view_model/turf_provider.dart';
import 'package:turfix_admin/view_model/user_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => CommonProvider()),
        ChangeNotifierProvider(create: (context) => UsersProvider()),
        ChangeNotifierProvider(create: (context) => AdminOwnersProvider()),
        ChangeNotifierProvider(create: (context) => AdminTurfsProvider()),
        ChangeNotifierProvider(create: (context) => AdminBookingsProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class BookingProvider {}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
