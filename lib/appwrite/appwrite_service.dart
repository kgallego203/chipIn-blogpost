import 'package:chipin_blogpost/appwrite/appwrite_constants.dart';
import 'package:appwrite/appwrite.dart';

class AppwriteService {
  static const String endPoint = AppwriteConstants.apiEndpoint;
  static const String projectId = AppwriteConstants.projectId;

  static Client getClient() {
    final Client client = Client()
      ..setEndpoint(endPoint)
      ..setProject(projectId);
    return client;
  }
}
