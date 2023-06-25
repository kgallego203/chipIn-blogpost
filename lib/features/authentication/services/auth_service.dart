import 'package:appwrite/models.dart';
import 'package:chipin_blogpost/appwrite/appwrite_service.dart';
import 'package:flutter/material.dart';
import 'package:appwrite/appwrite.dart';

class AuthService {
  static final Client client = AppwriteService.getClient();
  static final Account account = Account(client);
  static final Databases databases = Databases(client);

  // * SIGN UP METHOD
  static Future<void> createUser(String firstname, String lastname,
      String username, String email, String password) async {
    try {
      await account.create(
        name: '$firstname $lastname',
        userId: username,
        email: email,
        password: password,
      );

      print('User created successfully');
    } catch (error) {
      print('Error creating user: $error');
      throw error;
    }
  }

  // * LOGIN METHOD
  static Future<void> createSession(
      BuildContext context, String email, String password) async {
    try {
      await account.createEmailSession(
        email: email,
        password: password,
      );
      print('Session created successfully');
    } catch (error) {
      print('Error creating session: $error');
      throw error;
    }
  }

  // * This method retrieves the currently logged in user's ID
  static Future<String> getCreatorId() async {
    try {
      // Use the get method of the account object to retrieve the currently logged in user's details
      User response = await account.get();
      return response.$id; // Return the user's ID
    } catch (e) {
      print('Failed to get user ID: $e');
      throw e;
    }
  }

  // * LOGOUT METHOD
  static Future<void> logout() async {
    try {
      // Use the deleteSession method of the account object to delete the current session
      await account.deleteSession(sessionId: 'current');
      print('Logged out successfully');
    } catch (e) {
      print('Failed to logout: $e');
      throw e;
    }
  }

// * This method retrieves the currently logged in user's details and returns their name
  static Future<String> getUserName() async {
    try {
      // Use the get method of the account object to retrieve the currently logged in user's details
      User response = await account.get();
      return response.name; // Return the user's name
    } catch (e) {
      print('Failed to get user name: $e');
      throw e;
    }
  }
}
