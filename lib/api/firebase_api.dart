import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:nihongo/main.dart';

class FirebaseApi {
  // create an instance of Firebase Messaging
  final _firebaseMessage = FirebaseMessaging.instance;

  // function to initialize notifications
  Future<void> initNotifications() async {
    // request premission from user (will prompt user)
    await _firebaseMessage.requestPermission();

    // fetch the FCM token for this device
    final fCMToken = await _firebaseMessage.getToken();

    // print the token (normally you would send this to your server)
    print('Token: $fCMToken');

    // initialize further setting for push noti
    initPushNotifications();
  }

  // functions to handle received messages
  void handleMessage(RemoteMessage? message) {
    //if the message is null, do nothing
    if (message == null) return;

    // navigate to new screen when message is received and user taps notification
    navigatorKey.currentState?.pushNamed(
      '/notification_screen',
      arguments: message,
    );
  }

  // functions to initialize foreground and background settings
  Future initPushNotifications() async {
    // handle notification if the app was terminated and now opened
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);

    // attach event listeners for when a notification opens the app
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
  }
}