import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import '../screen/register_screen.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final GoogleSignIn _googleSignIn = GoogleSignIn();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleGoogleSignIn(BuildContext context) async {
    try {
      await _googleSignIn.signIn();
      // Handle successful login here
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Google sign-in failed: $error')),
      );
    }
  }

  Future<void> _handleAppleSignIn(BuildContext context) async {
    try {
      final credential = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
      );
      // Handle successful login here
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Apple sign-in failed: $error')),
      );
    }
  }

  Future<void> _handleFacebookSignIn(BuildContext context) async {
    try {
    final result = await FacebookAuth.instance.login();
    if (result.status == LoginStatus.success) {
    // Handle successful login here
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[50],
      ),
      backgroundColor: Colors.red[50],
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: LoginContainer(
            formKey: _formKey,
            emailController: _emailController,
            passwordController: _passwordController,
            handleGoogleSignIn: _handleGoogleSignIn,
            handleAppleSignIn: _handleAppleSignIn,
            handleFacebookSignIn: _handleFacebookSignIn,
          ),
        ),
      ),
    );
  }
}

class LoginContainer extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final Future<void> Function(BuildContext context) handleGoogleSignIn;
  final Future<void> Function(BuildContext context) handleAppleSignIn;
  final Future<void> Function(BuildContext context) handleFacebookSignIn;

  const LoginContainer({
    super.key,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.handleGoogleSignIn,
    required this.handleAppleSignIn,
    required this.handleFacebookSignIn,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Tablet or larger screen
          return _buildWideContainer(context);
        } else {
          // Mobile screen
          return _buildNarrowContainer(context);
        }
      },
    );
  }

  Widget _buildNarrowContainer(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Image.asset(
            'assets/icons/Venue.png',
            height: 200.0,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(
              labelText: 'Email',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your email';
              }
              if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Please enter a valid email address';
              }
              return null;
            },
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: passwordController,
            decoration: const InputDecoration(
              labelText: 'Password',
              border: OutlineInputBorder(),
            ),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter your password';
              }
              return null;
            },
          ),
          Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () {
                // Handle forgot password here
              },
              child: const Text('Forgot Password?'),
            ),
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                // Perform login action
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Logging in')),
                );
                // Add your login logic here
              }
            },
            child: const Text('Login'),
          ),
          const SizedBox(height: 40),
          ElevatedButton.icon(
            onPressed: () => handleGoogleSignIn(context),
            icon: Image.asset(
              'assets/icons/google.png',
              height: 24.0,
              width: 24.0,
            ),
            label: const Text('Login with Google'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black, backgroundColor: Colors.white,
              minimumSize: const Size(double.infinity, 50),
              side: const BorderSide(color: Colors.black),
            ),
          ),
          const SizedBox(height: 10),
          ElevatedButton.icon(
            onPressed: () => handleFacebookSignIn(context),
            icon: const Icon(Icons.facebook, color: Colors.blue),
            label: const Text('Login with Facebook'),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                minimumSize: const Size(double.infinity, 50),
                side: const BorderSide(color: Colors.black)
            ),
          ),
          const SizedBox(height: 10),
          SignInWithAppleButton(
            onPressed: () => handleAppleSignIn(context),
            style: SignInWithAppleButtonStyle.black,
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have an account?"),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const RegisterScreen()),
                  );
                },
                child: const Text('Register'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWideContainer(BuildContext context) {
    return Form(
      key: formKey,
      child: Center(
        child: Container(
          width: 600,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/icons/Venue.png',
                height: 200.0,
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your password';
                  }
                  return null;
                },
              ),
              Align(
                alignment: Alignment.centerRight,
                child: TextButton(
                  onPressed: () {
                    // Handle forgot password here
                  },
                  child: const Text('Forgot Password?'),
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // Perform login action
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Logging in')),
                    );
                    // Add your login logic here
                  }
                },
                child: const Text('Login'),
              ),
              const SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () => handleGoogleSignIn(context),
                icon: Image.asset(
                  'assets/icons/google.png',
                  height: 24.0,
                  width: 24.0,
                ),
                label: const Text('Login with Google'),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.black, backgroundColor: Colors.white,
                  minimumSize: const Size(double.infinity, 50),
                  side: const BorderSide(color: Colors.black),
                ),
              ),
              const SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () => handleFacebookSignIn(context),
                icon: const Icon(Icons.facebook, color: Colors.blue),
                label: const Text('Login with Facebook'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    minimumSize: const Size(double.infinity, 50),
                    side: const BorderSide(color: Colors.black)
                ),
              ),
              const SizedBox(height: 10),
              SignInWithAppleButton(
                onPressed: () => handleAppleSignIn(context),
                style: SignInWithAppleButtonStyle.black,
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Don't have an account?"),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const RegisterScreen()),
                      );
                    },
                    child: const Text('Register'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

