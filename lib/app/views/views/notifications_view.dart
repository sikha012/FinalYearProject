import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:happytails/app/utils/constants.dart';
import 'package:happytails/app/utils/memory_management.dart';

class NotificationsView extends GetView {
  const NotificationsView({Key? key}) : super(key: key);
  String _formatDateTime(String? dateTime) {
    if (dateTime == null) return 'Unknown date';
    // Assuming the date is stored in ISO 8601 format
    final date = DateTime.parse(dateTime).toLocal();
    // Format the date as needed. Here's an example:
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
  }

  @override
  Widget build(BuildContext context) {
    // Fetch the saved notifications from local storage
    final notifications = MemoryManagement.getNotifications();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Notifications'),
        centerTitle: true,
        backgroundColor: Constants.primaryColor,
        foregroundColor: Colors.white,
      ),
      body: notifications.isNotEmpty
          ? ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final notification = notifications[index];
                return Card(
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(notification['title'] ?? 'No Title'),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(notification['body'] ?? 'No Body'),
                        SizedBox(height: 4),
                        Text(
                          'Received: ${_formatDateTime(notification['notificationDate'])}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                    trailing: Text(notification['eventDate'] ?? 'No Date'),
                  ),
                );
              },
            )
          : const Center(
              child: Text(
                'No notifications available',
                style: TextStyle(fontSize: 20),
              ),
            ),
    );
  }
}
