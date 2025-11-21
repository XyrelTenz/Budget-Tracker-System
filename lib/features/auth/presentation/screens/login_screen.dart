import "package:flutter/material.dart";
import "package:flutter/gestures.dart";
import 'package:go_router/go_router.dart';
import "package:smart_budget_ph/core/routes/app_routes.dart";

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Capture the theme for cleaner code
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final textTheme = theme.textTheme;

    return Scaffold(
      // 1. Adaptive Background
      backgroundColor: colorScheme.surface,
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
                                // --- USERNAME FIELD ---
                                TextFormField(
                                  // Adaptive Text Color
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: colorScheme
                                          .onSurfaceVariant, // Adaptive Grey
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    // 2. Adaptive Input Borders
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: colorScheme
                                            .outline, // Standard grey outline
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: colorScheme
                                            .primary, // Your Brand Blue
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                        width: 1,
                                      ),
                                    ),
                                    filled: true,
                                    // 3. Adaptive Fill Color (Light Grey in Light, Dark Grey in Dark)
                                    fillColor:
                                        colorScheme.surfaceContainerLowest,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your email';
                                    }
                                    return null;
                                  },
                                ),

                                // --- PASSWORD FIELD ---
                                TextFormField(
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                  ),
                                  obscureText: true,
                                  decoration: InputDecoration(
                                    hintText: 'Password',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_outline_rounded,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        width: 1,
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: colorScheme.primary,
                                        width: 1,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                        width: 1,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(15.0),
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                        width: 1,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        colorScheme.surfaceContainerLowest,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your password';
                                    }
                                    return null;
                                  },
                                ),

                                // --- LOGIN BUTTON ---
                                SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 10,
                                      backgroundColor:
                                          colorScheme.primary, // Brand Blue
                                      shadowColor: colorScheme.primary
                                          .withValues(alpha: 0.5),
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
                                    child: Text(
                                      "LOGIN",
                                      style: TextStyle(
                                        color:
                                            colorScheme.onPrimary, // White Text
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Text(
                                    "Forgot Password?",
                                    style: TextStyle(
                                      color: colorScheme
                                          .onSurfaceVariant, // Adaptive Grey
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

                    // --- FOOTER ---
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30),
                      child: Text.rich(
                        TextSpan(
                          text: 'Don\'t have an account? ',
                          style: TextStyle(
                            fontSize: 16,
                            color: colorScheme.onSurface, // Adapts to Dark Mode
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Register',
                              style: TextStyle(
                                fontSize: 16,
                                color: colorScheme.primary, // Brand Blue
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
