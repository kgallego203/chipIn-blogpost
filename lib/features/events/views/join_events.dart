import 'package:chipin_blogpost/features/authentication/services/auth_service.dart';
import 'package:chipin_blogpost/features/events/models/attendee_model.dart';
import 'package:chipin_blogpost/features/events/models/event_model.dart';
import 'package:chipin_blogpost/features/events/services/event_service.dart';
import 'package:chipin_blogpost/features/events/widgets/event_card.dart';
import 'package:flutter/material.dart';

class JoinEventsScreen extends StatefulWidget {
  final EventService eventService;

  const JoinEventsScreen({required this.eventService});

  @override
  _JoinEventsScreenState createState() => _JoinEventsScreenState();
}

class _JoinEventsScreenState extends State<JoinEventsScreen> {
  Future<void> joinEvent(MyEventModel event) async {
    AttendeesModel myAttendeeModel = AttendeesModel(
      eventId: event.eventId,
      userId: currentUserId,
    );
    bool result = await EventService.joinEvent(myAttendeeModel);
    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully joined event!'),
          duration: Duration(seconds: 2),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Failed to join event. Please try again.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }

  List<MyEventModel> allEvents = [];
  String currentUserId = '';

  @override
  void initState() {
    super.initState();
    fetchAllEvents();
    getCurrentUserId();
  }

  Future<void> getCurrentUserId() async {
    currentUserId = await AuthService.getCreatorId();
  }

  Future<void> fetchAllEvents() async {
    try {
      List<MyEventModel> events = await EventService.getAllEvents();
      setState(() {
        allEvents = events;
      });
    } catch (error) {
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (allEvents.isEmpty) {
      return const Center(
        child: Text('No events to join'),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Join Events'),
        ),
        body: ListView.builder(
          itemCount: allEvents.length,
          itemBuilder: (context, index) {
            MyEventModel event = allEvents[index];
            bool showJoinButton = event.creatorId != currentUserId;
            return EventCard(
              event: event,
              showJoinButton: showJoinButton,
              onJoinPressed: () => joinEvent(event),
            );
          },
        ),
      );
    }
  }
}
