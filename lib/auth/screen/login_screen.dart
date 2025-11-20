import "package:flutter/material.dart";
import "package:flutter/gestures.dart";
import 'package:go_router/go_router.dart';
import 'package:smart_budget_ph/routes/helper/routes.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.center,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: Image.asset(
                                "assets/login.png",
                                fit: BoxFit.contain,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Form(
                            key: _formKey,
                            child: Column(
                              spacing: 15,
                              children: <Widget>[
                                TextFormField(
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[400],
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.person_outline_rounded,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF0046FF),
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),
                                TextFormField(
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: Colors.grey[400],
                                    ),
                                    prefixIcon: const Icon(
                                      Icons.lock_outline_rounded,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        width: 1,
                                        color: Colors.grey,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Color(0xFF0046FF),
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: const BorderSide(
                                        color: Colors.red,
                                        width: 1,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor: Colors.grey[50],
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor: const Color(0xFF0046FF),
                                      shadowColor: const Color(0xFF0046FF),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                          15.0,
                                        ),
                                      ),
                                    ),
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        context.go(Routes.home);
                                      }
                                    },
                                    child: const Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "FORGOT PASSWORD",
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text.rich(
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register',
                              style: const TextStyle(
                                fontSize: 16,
                                color: Color(0xFF0046FF),
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(Routes.register);
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
