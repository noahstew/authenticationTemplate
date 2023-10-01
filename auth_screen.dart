import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';

// TODO: Adjust to your auth.dart
import 'package:gym_app/authentication/auth.dart';
// TODO: Add following dependencies
/*
  Make sure to adjust for updated packages
  cupertino_icons: ^1.0.2
  firebase_core: ^2.16.0
  firebase_auth: ^4.10.0
  google_fonts: ^6.1.0
*/

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  // Variables effecting user authentication
  bool _isLogin = true;
  bool _loading = false;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  handleSubmit() async {
    if (!_formKey.currentState!.validate()) return;
    final email = _emailController.value.text;
    final password = _passwordController.value.text;

    setState(() {
      _loading = true;
    });

    if (_isLogin) {
      await Auth().signInWithEmailAndPassword(email, password);
    } else {
      await Auth().registerWithEmailAndPassword(email, password);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    // Setting log in message
                    _isLogin ? "Welcome Back!" : 'Welcome to the App!',
                    style: TextStyle(
                      fontSize: 44,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                  // Spacer
                  const SizedBox(height: 30),
                  // Email Box
                  TextFormField(
                    // Authentication
                    controller: _emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // Setting background color
                      filled: true,
                      fillColor: Theme.of(context).primaryColorLight,
                      // Setting inside box
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                      ),
                      prefixIcon: Platform.isIOS
                          ? const Icon(CupertinoIcons.mail)
                          : const Icon(Icons.email_outlined),
                      prefixIconColor: Theme.of(context).primaryColorDark,
                      // Setting border
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 4,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  // Spacer
                  const SizedBox(height: 2),
                  // Password box
                  TextFormField(
                    // Authentication
                    controller: _passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      return null;
                    },
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      // Setting background color
                      filled: true,
                      fillColor: Theme.of(context).primaryColorLight,
                      // Setting inside box
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: Theme.of(context).primaryColorDark,
                      ),
                      prefixIcon: Platform.isIOS
                          ? const Icon(CupertinoIcons.padlock)
                          : const Icon(Icons.key),
                      prefixIconColor: Theme.of(context).primaryColorDark,
                      // Setting border
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                          width: 4,
                        ),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(100),
                        ),
                      ),
                    ),
                  ),
                  // Spacer
                  const SizedBox(
                    height: 10,
                  ),
                  // Submit Button
                  SizedBox(
                    width: 120,
                    height: 40,
                    child: ElevatedButton(
                      onPressed: handleSubmit(),
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColor),
                        elevation: const MaterialStatePropertyAll(4),
                        shadowColor: MaterialStateProperty.all<Color>(
                            Theme.of(context).primaryColorLight),
                      ),

                      // Inside Button
                      child: _loading
                          // Display loading icon
                          ? Container(
                              width: 20,
                              height: 20,
                              decoration:
                                  const BoxDecoration(shape: BoxShape.circle),
                              child: CircularProgressIndicator(
                                color: Theme.of(context).primaryColorLight,
                                strokeWidth: 2,
                              ),
                            )
                          // Display text
                          : Text(
                              _isLogin ? 'Sign in' : 'Register',
                              style: TextStyle(
                                color: Theme.of(context).primaryColorLight,
                                fontSize: 20,
                              ),
                            ),
                    ),
                  ),
                  // Toggle between register and sign in.
                  TextButton(
                    onPressed: () {
                      setState(() {
                        _isLogin = !_isLogin;
                      });
                    },
                    child: Text(
                      _isLogin
                          ? 'Do not have an account? Register now'
                          : 'Have an account? Sign in',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
