import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../../../screen/dashboard_screen.dart';
import '../../domain/entity/auth_entity.dart';
import '../../domain/usecases/auth_usecase.dart';
import '../view/register_view.dart'; // Replace with your register screen import

final authViewModelProvider = ChangeNotifierProvider<AuthViewModel>((ref) => AuthViewModel(authUseCase: ref.read(authUseCaseProvider)));

class AuthViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  bool _isLoading = false;
  String? _error;
  AuthEntity? _currentUser;

  bool get isLoading => _isLoading;
  String? get error => _error;
  AuthEntity? get user => _currentUser;

  final AuthUseCase authUseCase;

  AuthViewModel({required this.authUseCase}) {
    _fetchCurrentUser();
  }

  Future<void> _fetchCurrentUser() async {
    _setLoading(true);
    var result = await authUseCase.getCurrentUser();
    result.fold(
          (failure) {
        _setLoading(false);
        _setError(failure.error);
      },
          (user) {
        _currentUser = user;
        _setError(null);
        _setLoading(false);
      },
    );
  }

  Future<void> loginUser(BuildContext context, String email, String password) async {
    _setLoading(true);
    var data = await authUseCase.loginUser(email, password);
    data.fold(
          (failure) {
        _setLoading(false);
        _setError(failure.error);
        showMySnackBar(context, message: failure.error, color: Colors.red);
      },
          (success) {
        _setLoading(false);
        _setError(null);
        showMySnackBar(context, message: "Successfully logged in");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      },
    );
  }

  void openRegisterView(BuildContext context) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterView()));
  }

  void openLoginView(BuildContext context) {
    Navigator.pop(context);
  }

  Future<void> handleGoogleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const DashboardScreen()),
      );
    } catch (error) {
      _handleSignInError(context, 'Google sign-in failed: $error');
    }
  }

  Future<void> handleFacebookSignIn(BuildContext context) async {
    try {
      final result = await FacebookAuth.instance.login();
      if (result.status == LoginStatus.success) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DashboardScreen()),
        );
      } else {
        _handleSignInError(context, 'Facebook sign-in failed: ${result.status}');
      }
    } catch (error) {
      _handleSignInError(context, 'Facebook sign-in failed: $error');
    }
  }

  Future<void> registerUser(BuildContext context, AuthEntity user) async {
    _setLoading(true);
    var data = await authUseCase.registerUser(user);
    data.fold(
          (failure) {
        _setLoading(false);
        _setError(failure.error);
        showMySnackBar(context, message: failure.error, color: Colors.red);
      },
          (success) {
        _setLoading(false);
        _setError(null);
        showMySnackBar(context, message: "Successfully registered");
        openLoginView(context);
      },
    );
  }

  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String? error) {
    _error = error;
    notifyListeners();
  }

  void _handleSignInError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}

// Function to show a Snackbar
void showMySnackBar(BuildContext context, {required String message, Color color = Colors.green}) {
  final snackBar = SnackBar(content: Text(message), backgroundColor: color);
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
