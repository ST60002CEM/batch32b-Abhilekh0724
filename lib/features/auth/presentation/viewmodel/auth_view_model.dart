import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../screen/dashboard_screen.dart';
import '../view/register_view.dart'; // Replace with your dashboard screen import

final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) => AuthViewModel());

class AuthViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> loginStudent(String username, String password) async {
    // Replace with your login logic
    // For demonstration, we just print the username and password
    print('Logging in with username: $username and password: $password');
  }

  void openRegisterView(BuildContext context) {
    // Navigate to RegisterScreen or handle register logic
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      // Handle successful login here
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $error')),
      );
    }
  }

  Future<void> handleFacebookSignIn(BuildContext context) async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        // Handle successful login here
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Facebook sign-in failed: ${result.status}')),
        );
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Facebook sign-in failed: $error')),
      );
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
