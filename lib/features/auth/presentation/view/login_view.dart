import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venuevendor/features/auth/presentation/view/register_view.dart';

import '../../../../core/common/my_snackbar.dart';
import '../../../home/presentation/view/home_view.dart';
import '../viewmodel/auth_view_model.dart';

class LoginView extends ConsumerWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authViewModel = ref.watch(authViewModelProvider);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 30,
                    fontFamily: 'Brand Bold',
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                _LoginForm(authViewModel: authViewModel),
                const SizedBox(height: 20),
                LoginContainer(
                  emailController: authViewModel.emailController,
                  passwordController: authViewModel.passwordController,
                  handleGoogleSignIn: () async {
                    try {
                      await authViewModel.handleGoogleSignIn(context);
                      // Navigate to HomeView after successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeView()),
                      );
                    } catch (error) {
                      showMySnackBar(message: 'Google sign-in failed: $error');
                    }
                  },
                  handleFacebookSignIn: () async {
                    try {
                      await authViewModel.handleFacebookSignIn(context);
                      // Navigate to HomeView after successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeView()),
                      );
                    } catch (error) {
                      showMySnackBar(message: 'Facebook sign-in failed: $error');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginForm extends StatefulWidget {
  final AuthViewModel authViewModel;

  const _LoginForm({Key? key, required this.authViewModel}) : super(key: key);

  @override
  __LoginFormState createState() => __LoginFormState();
}

class __LoginFormState extends State<_LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          TextFormField(
            controller: _usernameController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Username',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter username';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: _passwordController,
            obscureText: true,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Password',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter password';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                widget.authViewModel.loginUser(
                  _usernameController.text,
                  _passwordController.text,
                );
                // Navigate to HomeView after successful login
                // Navigator.pushReplacement(
                //   context,
                //   MaterialPageRoute(builder: (context) => const HomeView()),
                // );
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

class LoginContainer extends StatelessWidget {
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final VoidCallback handleGoogleSignIn;
  final VoidCallback handleFacebookSignIn;

  const LoginContainer({
    Key? key,
    required this.emailController,
    required this.passwordController,
    required this.handleGoogleSignIn,
    required this.handleFacebookSignIn,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: handleGoogleSignIn,
          icon: Image.asset(
            'assets/icons/google.png',
            height: 24.0,
            width: 24.0,
          ),
          label: const Text('Login with Google'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            side: const BorderSide(color: Colors.black),
          ),
        ),
        const SizedBox(height: 10),
        ElevatedButton.icon(
          onPressed: handleFacebookSignIn,
          icon: const Icon(Icons.facebook, color: Colors.blue),
          label: const Text('Login with Facebook'),
          style: ElevatedButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: Colors.white,
            minimumSize: const Size(double.infinity, 50),
            side: const BorderSide(color: Colors.black),
          ),
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
                  MaterialPageRoute(builder: (context) => const RegisterView()),
                );
              },
              child: const Text('Register'),
            ),
          ],
        ),
      ],
    );
  }
}