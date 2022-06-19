import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:salon_provider/feature/server/helper/sp_helpar.dart';
import 'package:salon_provider/feature/server/service/server_salon.dart';

class NotificationHelper {
  initialNotification() async {
    FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;
    firebaseMessaging.subscribeToTopic('all');
    final fcmToken = await firebaseMessaging.getToken();

    await SPHelper.spHelper.setFcmToken(fcmToken);
    await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      ServerProvider.instance.getMyBookings();
    });
  }
}
