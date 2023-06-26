import 'package:appwrite/appwrite.dart';
import 'package:chipin_blogpost/appwrite/appwrite_constants.dart';
import 'package:chipin_blogpost/appwrite/appwrite_service.dart';
import 'package:chipin_blogpost/features/events/models/attendee_model.dart';
import 'package:chipin_blogpost/features/events/models/event_model.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

class EventService {
  static final Client client = AppwriteService.getClient();
  static final Account account = Account(client);
  static final Databases databases = Databases(client);

  Future<bool> createEvent(MyEventModel event) async {
    try {
      DateTime eventDateTime =
          DateTime.parse('${event.eventDate} ${event.eventTime}');
      String formattedDate =
          DateFormat('yyyy-MM-dd HH:mm:ss').format(eventDateTime);

      // Make the eventID exactly equal to the documentID
      String eventId = const Uuid().v4().replaceAll('-', '');

      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollectionId,
        // Assign the eventId to the documentId to have the same value
        documentId: eventId,
        data: {
          'eventId': eventId,
          'title': event.title,
          'date': formattedDate,
          'location': event.location,
          'creatorId': event.creatorId,
          'description': event.description,
        },
      );
      return true;
    } catch (e) {
      print('Failed to create event: $e');
      return false;
    }
  }

  static Future<bool> joinEvent(AttendeesModel attendee) async {
    try {
      String documentId = const Uuid().v4().replaceAll('-', '');
      await databases.createDocument(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.attendeesCollectionId,
        documentId: documentId,
        data: {
          'userId': attendee.userId,
          'eventId': attendee.eventId,
        },
      );
      return true;
    } catch (e) {
      print('Failed to join event: $e');
      return false;
    }
  }

  Future<List<MyEventModel>> getMyCreatedEvents(String userId) async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollectionId,
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          MyEventModel event = MyEventModel.fromJson(item.data);
          if (event.creatorId == userId) {
            eventList.add(event);
          }
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList;
  }

  Future<List<MyEventModel>> getMyJoinedEvents(String userId) async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.attendeesCollectionId,
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          if (item.data['userId'] == userId) {
            String eventId = item.data['eventId'];
            var eventResponse = await databases.getDocument(
              databaseId: AppwriteConstants.databaseId,
              collectionId: AppwriteConstants.eventsCollectionId,
              documentId: eventId,
            );
            eventList.add(MyEventModel.fromJson(eventResponse.data));
          }
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList;
  }

  static Future<List<MyEventModel>> getAllEvents() async {
    List<MyEventModel> eventList = [];

    try {
      var response = await databases.listDocuments(
        databaseId: AppwriteConstants.databaseId,
        collectionId: AppwriteConstants.eventsCollectionId,
      );

      if (response.documents.isNotEmpty) {
        for (var item in response.documents) {
          eventList.add(
            MyEventModel.fromJson(item.data),
          );
        }
      }
    } catch (e) {
      print('Failed to get events: $e');
    }
    return eventList;
  }
}
