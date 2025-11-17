import "package:flutter/material.dart";
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 30),
                alignment: Alignment.center,
                color: Colors.white,
                child: Column(children: [Image.asset("assets/login.png")]),
              ),
            ),
            Expanded(
              child: Form(
                key: _formKey,
                child: Column(
                  spacing: 15,
                  children: <Widget>[
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        decoration: InputDecoration(
                          hintText: 'Username',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400],
                          ),

                          prefixIcon: Icon(Icons.person_outline_rounded),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2,
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
                        onChanged: (value) {},
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        obscureText: true,
                        decoration: InputDecoration(
                          hintText: 'Password',
                          hintStyle: TextStyle(
                            fontSize: 15,
                            color: Colors.grey[400],
                          ),

                          prefixIcon: Icon(Icons.lock_outline_rounded),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0),
                            borderSide: BorderSide(
                              color: Colors.blueAccent,
                              width: 2,
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
                        onChanged: (value) {},
                      ),
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            context.go("/HomeScreen");
                          }
                        },
                        child: Text("Login"),
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
