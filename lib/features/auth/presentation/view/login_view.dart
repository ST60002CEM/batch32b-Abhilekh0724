import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:venuevendor/features/auth/presentation/view/register_view.dart';
import '../../../home/presentation/view/home_view.dart';
import '../viewmodel/auth_view_model.dart';

class LoginView extends ConsumerStatefulWidget {
  const LoginView({Key? key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                const SizedBox(height: 20),
                _LoginForm(
                  authViewModel: authViewModel,
                  formKey: _formKey,
                  emailController: _emailController,
                  passwordController: _passwordController,
                ),
                const SizedBox(height: 20),
                LoginContainer(
                  emailController: _emailController,
                  passwordController: _passwordController,
                  handleGoogleSignIn: () async {
                    try {
                      await authViewModel.handleGoogleSignIn(context);
                      // Navigate to HomeView after successful login
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => const HomeView()),
                      );
                    } catch (error) {
                      showMySnackBar(context, 'Google sign-in failed: $error');
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
                      showMySnackBar(context, 'Facebook sign-in failed: $error');
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

class _LoginForm extends ConsumerStatefulWidget {
  final AuthViewModel authViewModel;
  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  const _LoginForm({
    Key? key,
    required this.authViewModel,
    required this.formKey,
    required this.emailController,
    required this.passwordController,
  }) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<_LoginForm> {
  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
                    Image.asset(
            'assets/icons/Venue.png',
            height: 200.0,
          ),
          const SizedBox(height: 20),
          TextFormField(
            controller: widget.emailController,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Email',
            ),
            validator: (value) {
              if (value!.isEmpty) {
                return 'Please enter Email';
              }
              return null;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: widget.passwordController,
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
            onPressed: () async {
              if (widget.formKey.currentState!.validate()) {
                await ref.read(authViewModelProvider.notifier).loginUser(
                  widget.emailController.text,
                  widget.passwordController.text,
                );
                // Navigator to HomeView after successful login
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const HomeView()),
                );
              }
            },
            child: const Text('Login'),
          ),
        ],
      ),
    );
  }
}

class LoginContainer extends ConsumerStatefulWidget {
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
  _LoginContainerState createState() => _LoginContainerState();
}

class _LoginContainerState extends ConsumerState<LoginContainer> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        const SizedBox(height: 20),
        ElevatedButton.icon(
          onPressed: widget.handleGoogleSignIn,
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
          onPressed: widget.handleFacebookSignIn,
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

void showMySnackBar(BuildContext context, String message) {
  final snackBar = SnackBar(content: Text(message));
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
