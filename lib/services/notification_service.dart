import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:coupler_app/color_scheme.dart';
import 'package:flutter/material.dart';

class NotificationService {
  Future<void> initializeAwesomeNotifications() async {
    AwesomeNotifications().initialize(
        // set the icon to null if you want to use the default app icon
        null,
        [
          NotificationChannel(
              channelGroupKey: 'reminders',
              channelKey: 'reminders-q1',
              channelName: 'Coupler Reminders',
              channelDescription: 'Coupler reminders',
              defaultColor: CustomeColorScheme['dark'],
              ledColor: CustomeColorScheme['light'])
        ],
        // Channel groups are only visual and are not required
        channelGroups: [
          NotificationChannelGroup(
              channelGroupKey: 'basic_channel_group',
              channelGroupName: 'Basic group')
        ],
        debug: true);
  }

  Future<void> requestNotificationsPermission() async {
    AwesomeNotifications().isNotificationAllowed().then((isAllowed) {
      if (!isAllowed) {
        // This is just a basic example. For real apps, you must show some
        // friendly dialog box before call the request method.
        // This is very important to not harm the user experience
        AwesomeNotifications().requestPermissionToSendNotifications();
      } else {
        print('Notifications Allowedd!');
      }
    });
  }

  Future<void> sendInstantNotification() async {
    AwesomeNotifications().createNotification(
        content: NotificationContent(
      id: 10,
      channelKey: 'basic_channel',
      actionType: ActionType.DismissAction,
      title: 'Hello World!',
      body: 'This is my first notification!',
    ));
  }

  Future<List<NotificationModel>> getPendingNotifications() async {
    List<NotificationModel> pendingNotifications =
        await AwesomeNotifications().listScheduledNotifications();

    // for (final item in pendingNotifications) {
    //   print(item.content);
    // }

    return pendingNotifications;
  }

  Future<void> scheduleNotifications(
      int frequency, int periodInDays, String title, String body) async {
    var now = DateTime.now();
    var interval = Duration(days: periodInDays) ~/ frequency;

    await AwesomeNotifications().cancelAll();

    for (int i = 0; i < frequency; i++) {
      var scheduledTime = now.add(interval * (i + 1));

      print(
          '${scheduledTime.day}-${scheduledTime.month}-${scheduledTime.year} ${scheduledTime.hour}:${scheduledTime.minute} __ ${body}');

      AwesomeNotifications().createNotification(
          schedule: NotificationCalendar(
              day: scheduledTime.day,
              month: scheduledTime.month,
              year: scheduledTime.year,
              hour: scheduledTime.hour,
              minute: scheduledTime.minute),
          content: NotificationContent(
              id: i,
              groupKey: 'reminders',
              channelKey: 'basic_channel',
              actionType: ActionType.DismissAction,
              title: title,
              body: body,
              wakeUpScreen: true,
              category: NotificationCategory.Reminder));
    }
  }
}
