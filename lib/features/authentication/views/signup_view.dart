import 'package:chipin_blogpost/features/authentication/controller/auth_controller.dart';
import 'package:chipin_blogpost/features/authentication/services/oauth_service.dart';
import 'package:chipin_blogpost/themes.dart/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class SignUpView extends StatelessWidget {
  SignUpView({Key? key});

  final _signUpController = SignUpController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // GitHub Sign Up Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(FontAwesomeIcons.github),
              label: const Text('Sign Up with GitHub'),
              onPressed: () {
                OAuthService.initiateGithubOAuth(context);
              },
            ),
            const SizedBox(height: 16),
            // "Or" line
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Palette.neutral50,
                    thickness: 1,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: Text(
                    'Or',
                    style: TextStyle(
                      color: Palette.neutral50,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Divider(
                    color: Palette.neutral50,
                    thickness: 1,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Form(
              key: _signUpController.formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Text form field for the user's first name
                  TextFormField(
                    controller: _signUpController.firstNameController,
                    decoration: InputDecoration(
                      hintText: 'First Name',
                      fillColor: Palette.neutral10,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your first name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Text form field for the user's last name
                  TextFormField(
                    controller: _signUpController.lastNameController,
                    decoration: InputDecoration(
                      hintText: 'Last Name',
                      fillColor: Palette.neutral10,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your last name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Text form field for the user's email address
                  TextFormField(
                    controller: _signUpController.emailController,
                    decoration: InputDecoration(
                      hintText: 'Email',
                      fillColor: Palette.neutral10,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Text form field for the user's desired username
                  TextFormField(
                    controller: _signUpController.usernameController,
                    decoration: InputDecoration(
                      hintText: 'Username',
                      fillColor: Palette.neutral10,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Text form field for the user's desired password
                  TextFormField(
                    controller: _signUpController.passwordController,
                    decoration: InputDecoration(
                      hintText: 'Password',
                      fillColor: Palette.neutral10,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter a password';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Text form field to confirm the user's desired password
                  TextFormField(
                    controller: _signUpController.confirmPasswordController,
                    decoration: InputDecoration(
                      hintText: 'Confirm Password',
                      fillColor: Palette.neutral10,
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please confirm your password';
                      }
                      if (value != _signUpController.passwordController.text) {
                        return 'Passwords do not match';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  // Button to submit the form and sign up the user
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Palette.primary100,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text('Sign Up'),
                    onPressed: () async {
                      if (_signUpController.formKey.currentState != null &&
                          _signUpController.formKey.currentState!.validate()) {
                        await _signUpController.signUp(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
