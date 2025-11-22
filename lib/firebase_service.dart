
import 'package:firebase_messaging/firebase_messaging.dart';

class FirebaseService {
 static Future<void> initialize() async{
   await FirebaseMessaging.instance.requestPermission(
         alert : true,
         announcement : false,
         badge : true,
         carPlay : false,
         criticalAlert : false,
         provisional : false,
         sound : true,
         providesAppNotificationSettings : false
    );
   //? Foreground
   FirebaseMessaging.onMessage.listen(_handleNotificationMessage);

   //? Backgroud
   FirebaseMessaging.onMessageOpenedApp.listen(_handleNotificationMessage);

   //? Terminated

   FirebaseMessaging.onBackgroundMessage(_handleTerminatedNotification);

 }

 static Future<String?> getFcmToken() async{
   return FirebaseMessaging.instance.getToken();
 }

 static void onTokenRefreash(){
   FirebaseMessaging.instance.onTokenRefresh.listen((token) {
     print(token);
     //! call Update Token API
   });
 }

static void _handleNotificationMessage(RemoteMessage message){
  print(message.data);
  print(message.notification!.title);
  print(message.notification!.body);
}


}

Future<void> _handleTerminatedNotification(RemoteMessage message) async{

}