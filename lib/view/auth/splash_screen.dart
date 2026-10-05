import 'dart:async';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:turfix_admin/view/auth/login_screen.dart';
import 'package:turfix_admin/view/screens/admin_screens/admin_main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Timer(const Duration(seconds: 3), () {
        if (!context.mounted) return;

        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const AuthGate()),
          (route) => false,
        );
      });
    });

    return Scaffold(
      backgroundColor: Colors.black,
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/turfix image.jpeg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class AuthGate extends StatelessWidget {
  const AuthGate({super.key});

  Future<Widget> checkAuth() async {
    final user = FirebaseAuth.instance.currentUser;

    // Not logged in
    if (user == null) {
      return LoginScreen();
    }

    // Check admin document
    final doc = await FirebaseFirestore.instance
        .collection('admin')
        .doc(user.uid)
        .get();

    // Admin document doesn't exist
    if (!doc.exists) {
      await FirebaseAuth.instance.signOut();
      return LoginScreen();
    }

    // Admin exists
    return const AdminMainScreen();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
      future: checkAuth(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // Error
        if (snapshot.hasError) {
          return LoginScreen();
        }

        // Result
        if (snapshot.hasData) {
          return snapshot.data!;
        }

        return LoginScreen();
      },
    );
  }
}

// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:turfix_admin/view/auth/login_screen.dart';
// class SplashScreen extends StatelessWidget {
//   const SplashScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     Timer(Duration(seconds: 3), () {
//       Navigator.pushAndRemoveUntil(
//         context,
//         MaterialPageRoute(builder: (context) => LoginScreen()),
//         (route) => false,
//       );
//     });
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(
//             image: AssetImage("assets/images/turfix image.jpeg"),
//             fit: BoxFit.cover,
//           ),
//         ),
//         // child: Image.asset("assets/images/turfixImage.jpeg", fit: BoxFit.cover)
//       ),
//     );
//   }
// }
