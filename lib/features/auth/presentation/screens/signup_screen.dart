import "package:flutter/material.dart";
import "package:flutter/gestures.dart";
import 'package:go_router/go_router.dart';
import "package:smart_budget_ph/core/routes/app_routes.dart";

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Controllers are needed to compare password values
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  // State variables
  bool _isPasswordVisible = false;
  bool _isConfirmPasswordVisible = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignup() async {
    // Hide keyboard
    FocusScope.of(context).unfocus();

    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // SIMULATION: Network request
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    // Navigate to Home or Verify Email screen
    context.go(Routes.setpin);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final borderRadius = BorderRadius.circular(15.0);

    return Scaffold(
      backgroundColor: colorScheme.surface,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.go(Routes.login),
          icon: Container(
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: colorScheme.onSurface,
              size: 20,
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverFillRemaining(
              hasScrollBody: false,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 24,
                ),
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // --- LOGO SECTION ---
                          Container(
                            constraints: const BoxConstraints(maxHeight: 180),
                            padding: const EdgeInsets.symmetric(vertical: 20),
                            alignment: Alignment.center,
                            child: Image.asset(
                              "assets/signup.png",
                              fit: BoxFit.contain,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // --- FORM SECTION ---
                          Form(
                            key: _formKey,
                            child: Column(
                              spacing: 16,
                              children: <Widget>[
                                // --- USERNAME ---
                                TextFormField(
                                  textInputAction: TextInputAction.next,
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Username',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        colorScheme.surfaceContainerLowest,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter your username';
                                    }
                                    return null;
                                  },
                                ),

                                // --- PASSWORD ---
                                TextFormField(
                                  controller: _passwordController,
                                  textInputAction: TextInputAction.next,
                                  obscureText: !_isPasswordVisible,
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                  ),
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
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isPasswordVisible =
                                              !_isPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _isPasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        colorScheme.surfaceContainerLowest,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a password';
                                    }
                                    if (value.length < 6) {
                                      return 'Password must be at least 6 characters';
                                    }
                                    return null;
                                  },
                                ),

                                // --- CONFIRM PASSWORD ---
                                TextFormField(
                                  controller: _confirmPasswordController,
                                  textInputAction: TextInputAction.done,
                                  onFieldSubmitted: (_) => _handleSignup(),
                                  obscureText: !_isConfirmPasswordVisible,
                                  style: TextStyle(
                                    color: colorScheme.onSurface,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Confirm Password',
                                    hintStyle: TextStyle(
                                      fontSize: 15,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.lock_clock_sharp,
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                    suffixIcon: IconButton(
                                      onPressed: () {
                                        setState(() {
                                          _isConfirmPasswordVisible =
                                              !_isConfirmPasswordVisible;
                                        });
                                      },
                                      icon: Icon(
                                        _isConfirmPasswordVisible
                                            ? Icons.visibility_outlined
                                            : Icons.visibility_off_outlined,
                                        color: colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.outline,
                                      ),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.primary,
                                        width: 2,
                                      ),
                                    ),
                                    errorBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                      ),
                                    ),
                                    focusedErrorBorder: OutlineInputBorder(
                                      borderRadius: borderRadius,
                                      borderSide: BorderSide(
                                        color: colorScheme.error,
                                        width: 2,
                                      ),
                                    ),
                                    filled: true,
                                    fillColor:
                                        colorScheme.surfaceContainerLowest,
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

                                const SizedBox(height: 10),

                                // --- REGISTER BUTTON ---
                                SizedBox(
                                  width: double.infinity,
                                  height: 54,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      elevation: 4,
                                      backgroundColor: colorScheme.primary,
                                      foregroundColor: colorScheme.onPrimary,
                                      shadowColor: colorScheme.primary
                                          .withValues(alpha: 0.4),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: borderRadius,
                                      ),
                                    ),
                                    onPressed: _isLoading
                                        ? null
                                        : _handleSignup,
                                    child: _isLoading
                                        ? SizedBox(
                                            height: 24,
                                            width: 24,
                                            child: CircularProgressIndicator(
                                              color: colorScheme.onPrimary,
                                              strokeWidth: 2.5,
                                            ),
                                          )
                                        : const Text(
                                            "REGISTER",
                                            style: TextStyle(
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.2,
                                            ),
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
                          text: 'Already have an account? ',
                          style: TextStyle(
                            fontSize: 15,
                            color: colorScheme.onSurfaceVariant,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: 'Login',
                              style: TextStyle(
                                fontSize: 15,
                                color: colorScheme.primary,
                                fontWeight: FontWeight.bold,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  context.go(Routes.setpin);
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
