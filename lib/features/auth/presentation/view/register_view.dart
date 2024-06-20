  import 'package:flutter/material.dart';
  import 'package:flutter_riverpod/flutter_riverpod.dart';
  import 'package:permission_handler/permission_handler.dart';
  import '../../../../core/common/my_snackbar.dart';
  import '../../domain/entity/auth_entity.dart';
  import '../viewmodel/auth_view_model.dart';
  import 'login_view.dart';
  import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
  import 'package:google_sign_in/google_sign_in.dart';

  class RegisterView extends ConsumerStatefulWidget {
    const RegisterView({Key? key}) : super(key: key);

    @override
    ConsumerState<RegisterView> createState() => _RegisterViewState();
  }

  class _RegisterViewState extends ConsumerState<RegisterView> {
    final _formKey = GlobalKey<FormState>();
    final TextEditingController _firstNameController = TextEditingController();
    final TextEditingController _lastNameController = TextEditingController();
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    final TextEditingController _confirmPasswordController =
    TextEditingController();
    final TextEditingController _phoneController = TextEditingController();
    final TextEditingController _usernameController = TextEditingController();
    bool isObscure = true;

    final GoogleSignIn _googleSignIn = GoogleSignIn();

    Future<void> _handleGoogleSignUp() async {
      try {
        await _googleSignIn.signIn();
        // Handle successful registration here
      } catch (error) {
        // Handle registration error here
      }
    }

    Future<void> _handleFacebookSignUp() async {
      try {
        final result = await FacebookAuth.instance.login();
        if (result.status == LoginStatus.success) {
          // Handle successful registration here
        } else {
          // Handle registration error here
        }
      } catch (error) {
        // Handle registration error here
      }
    }

    final _gap = const SizedBox(height: 8);

    @override
    Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
          centerTitle: true,
          backgroundColor: Colors.red[50],
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: const InputDecoration(
                              labelText: 'First Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter first name';
                              }
                              return null;
                            },
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: const InputDecoration(
                              labelText: 'Last Name',
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Please enter last name';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    _gap,
                    TextFormField(
                      controller: _phoneController,
                      decoration: const InputDecoration(
                        labelText: 'Phone No',
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter phone number';
                        }
                        return null;
                      }),
                    ),
                    _gap,
                    TextFormField(
                      controller: _usernameController,
                      decoration: const InputDecoration(
                        labelText: 'Username',
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter username';
                        }
                        return null;
                      }),
                    ),
                    _gap,
                    TextFormField(
                      controller: _emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
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
                    _gap,
                    TextFormField(
                      controller: _passwordController,
                      obscureText: isObscure,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
                            });
                          },
                        ),
                      ),
                      validator: ((value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter password';
                        }
                        return null;
                      }),
                    ),
                    _gap,
                    TextFormField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm Password',
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                    ),
                    _gap,
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          var student = AuthEntity(
                            fname: _firstNameController.text,
                            lname: _lastNameController.text,
                            phone: _phoneController.text,
                            username: _usernameController.text,
                            password: _passwordController.text,
                          );

                          // Perform registration logic here
                          // For demonstration, we navigate back to LoginView after registration
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const LoginView()),
                          );

                          // Example usage of showMySnackBar
                          showMySnackBar(
                            message: 'Registration successful!',
                            color: Colors.black,
                          );
                        }
                      },
                      child: const Text('Register'),
                    ),
                    const SizedBox(height: 40),
                    ElevatedButton.icon(
                      onPressed: _handleGoogleSignUp,
                      icon: Image.asset(
                        'assets/icons/google.png',
                        // Ensure you have a Google logo asset
                        height: 24.0,
                        width: 24.0,
                      ),
                      label: const Text('Register with Google'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton.icon(
                      onPressed: _handleFacebookSignUp,
                      icon: const Icon(Icons.facebook, color: Colors.blue),
                      label: const Text('Register with Facebook'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        minimumSize: const Size(double.infinity, 50),
                        side: const BorderSide(color: Colors.black),
                      ),
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    }
  }