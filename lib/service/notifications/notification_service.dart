import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:hotelin/main.dart';
import 'package:hotelin/view/notification_page.dart';

class NotificationService {
  static Future<void> initializeNotification() async {
    // Initialize Awesome Notifications
    await AwesomeNotifications().initialize(
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
          defaultColor: const Color(0xFF9D50DD),
          ledColor: Colors.white,
          importance: NotificationImportance.Max,
          channelShowBadge: true,
          playSound: true,
          criticalAlerts: true,
        )
      ],
      channelGroups: [
        NotificationChannelGroup(
          channelGroupKey: 'basic_channel_group',
          channelGroupName: 'Basic notifications group',
        )
      ],
      debug: true,
    );

    // Request notification permissions
    await AwesomeNotifications().isNotificationAllowed().then(
      (isAllowed) {
        if (!isAllowed) {
          AwesomeNotifications().requestPermissionToSendNotifications();
        }
      },
    );

    // Set notification listeners
    await AwesomeNotifications().setListeners(
      onActionReceivedMethod: _onActionReceivedMethod,
      onNotificationCreatedMethod: _onNotificationCreateMethod,
      onNotificationDisplayedMethod: _onNotificationDisplayedMethod,
      onDismissActionReceivedMethod: _onDismissActionReceivedMethod,
    );
  }

// Listeners

  static Future<void> _onNotificationCreateMethod(
    ReceivedNotification receivedNotification,
  ) async {
    debugPrint('Notification created: ${receivedNotification.title}');
  }

  static Future<void> _onNotificationDisplayedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    debugPrint('Notification displayed: ${receivedNotification.title}');
  }

  static Future<void> _onDismissActionReceivedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    debugPrint('Notification dismissed: ${receivedNotification.title}');
  }

  static Future<void> _onActionReceivedMethod(
    ReceivedNotification receivedNotification,
  ) async {
    debugPrint('Notification action received');
    final payload = receivedNotification.payload;
    if (payload == null) return;
    if (payload['navigate'] == 'true') {
      debugPrint(MyApp.navigatorKey.currentContext.toString());
      Navigator.push(
        MyApp.navigatorKey.currentContext!,
        MaterialPageRoute(
          builder: (_) => NotificationPage(
            title: receivedNotification.title,
            message: receivedNotification.body,
            bookingId: payload['bookingId'],
            hotelName: payload['hotelName'],
            roomType: payload['roomType'],
            bedType: payload['bedType'],
            price: payload['price'],
            bookedAt: payload['bookedAt'] != null
                ? DateTime.parse(payload['bookedAt']!)
                : null,
          ),
        ),
      );
    }
  }

  static Future<void> createNotification({
    required final int id,
    required final String bookingId,
    required final String title,
    required final String body,
    required final String hotelName,
    required final String roomType,
    required final String bedType,
    required final String price,
    final DateTime? bookedAt,
    final String? summary,
    final Map<String, String>? payload,
    final ActionType actionType = ActionType.Default,
    final NotificationLayout notificationLayout = NotificationLayout.Default,
    final NotificationCategory? category,
    final String? bigPicture,
    final List<NotificationActionButton>? actionButtons,
    final bool scheduled = false,
    final Duration? interval,
  }) async {
    assert(!scheduled || (scheduled && interval != null));

    final Map<String, String> completePayload = {
      'navigate': 'true',
      'bookingId': bookingId,
      'hotelName': hotelName,
      'roomType': roomType,
      'bedType': bedType,
      'price': price,
      if (bookedAt != null) 'bookedAt': bookedAt.toIso8601String(),
      ...?payload, // Include any additional payload items
    };

    debugPrint(
        'Creating notification with payload: $completePayload'); // Debug payload content

    await AwesomeNotifications().createNotification(
      content: NotificationContent(
        id: id,
        channelKey: 'basic_channel',
        title: title,
        body: body,
        actionType: actionType,
        notificationLayout: notificationLayout,
        summary: summary,
        category: category,
        payload: completePayload,
        bigPicture: bigPicture,
      ),
      actionButtons: actionButtons,
      schedule: scheduled
          ? NotificationInterval(
              interval: interval,
              timeZone:
                  await AwesomeNotifications().getLocalTimeZoneIdentifier(),
              preciseAlarm: true,
            )
          : null,
    );
  }
}
