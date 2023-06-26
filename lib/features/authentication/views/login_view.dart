import 'package:chipin_blogpost/features/authentication/controller/auth_controller.dart';
import 'package:chipin_blogpost/features/authentication/services/oauth_service.dart';
import 'package:chipin_blogpost/themes.dart/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginView extends StatelessWidget {
  // Create an instance of the LoginController class by assigning it to the loginController variable
  final loginController = LoginController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Form(
        key: loginController.formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // New GitHub Login Button
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Background color
                foregroundColor: Colors.white, // Text color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              icon: const Icon(FontAwesomeIcons.github),
              label: const Text('Login with GitHub'),
              onPressed: () async {
                await OAuthService.initiateGithubOAuth(context);
              },
            ),

            const SizedBox(height: 16),

            const Text(
              'Or',
              style: TextStyle(
                color: Palette.neutral50,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            // Existing form fields and button...
            TextFormField(
              controller: loginController.emailController,
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
                return null;
              },
            ),

            const SizedBox(height: 16),

            TextFormField(
              controller: loginController.passwordController,
              obscureText: true,
              decoration: InputDecoration(
                hintText: 'Password',
                fillColor: Palette.neutral10,
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'Please enter your password';
                }
                return null;
              },
            ),

            const SizedBox(height: 16),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Palette.primary100,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Login'),
              onPressed: () async {
                if (loginController.formKey.currentState != null &&
                    loginController.formKey.currentState!.validate()) {
                  await loginController.login(context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
