import 'package:chipin_blogpost/appwrite/appwrite_service.dart';
import 'package:chipin_blogpost/features/home_page.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

class OAuthService {
  static final Client client = AppwriteService.getClient();
  static final Account account = Account(client);
  // * Function for GithHub OAuth
  static Future<void> initiateGithubOAuth(context) async {
    try {
      await account.createOAuth2Session(
        provider: 'github',
      );
      // Navigate to the home screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePage()),
      );
    } on AppwriteException catch (e) {
      print('Appwrite Exception: ${e.message}');
    } catch (e) {
      print('Unknown Exception: $e');
    }
  }
}
