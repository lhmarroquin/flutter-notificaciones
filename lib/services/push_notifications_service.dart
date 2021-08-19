
import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotificationService {

  static FirebaseMessaging messaging = FirebaseMessaging.instance;
  static String? token;
  static StreamController<RemoteMessage> _messageStream = StreamController.broadcast();
  static Stream<RemoteMessage> get messagesStream => _messageStream.stream;

  static Future _backgroundHandler(RemoteMessage message) async {

    print('onBackground Handler ${ message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.title ?? 'No title');
    //_messageStream.add(message.data['product'] ?? 'No data');
    _messageStream.add(message);

  }

  static Future _onMessageHandler(RemoteMessage message) async {

    print('onMessage Handler ${ message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.title ?? 'No title');
    //_messageStream.add(message.data['product'] ?? 'No data');
    _messageStream.add(message);

  }

  static Future _onMessageOpenApp(RemoteMessage message) async {

    print('onMessageOpenApp Handler ${ message.messageId}');
    print(message.data);
    //_messageStream.add(message.notification?.title ?? 'No title');
    //_messageStream.add(message.data['product'] ?? 'No data');
    _messageStream.add(message);

  }

  static Future initializeApp() async {

    // Push Notifications
    await Firebase.initializeApp();
    await requestPermission();

    token = await FirebaseMessaging.instance.getToken();
    print(token);

    //fUZmm3Z2SmiRf3nMMjjyc0:APA91bGdheFLRV_rMRsyUXrbl3At7UAQ318t4uJEG9A16g82qyClxKLkH_T66omTeDtXMGNbRLtdBTSWc3x9Zhu0k-6CA8jHxY7HVqnjXQusjjUj2UrTCTO5wGeXngFJpnYjFmnSCU-4

    // Handlers
    FirebaseMessaging.onBackgroundMessage(_backgroundHandler);
    FirebaseMessaging.onMessage.listen(_onMessageHandler);
    FirebaseMessaging.onMessageOpenedApp.listen(_onMessageOpenApp);

    // Local Notifications


  }

  static requestPermission() async {

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('User push notification status ${settings.authorizationStatus}');

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print('User granted permission');
    } else if (settings.authorizationStatus == AuthorizationStatus.provisional) {
      print('User granted provisional permission');
    } else {
      print('User declined or has not accepted permission');
    }


  }

  static closeStreams() {
    _messageStream.close();
  }

}


/*Variant: debug
Config: debug
Store: C:\Users\lhmar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 7D:56:ED:6E:A5:1A:76:3D:F5:74:E2:71:34:11:54:FB
SHA1: 09:C5:EA:EA:7D:B6:AD:D9:CE:F0:E0:D9:03:C8:3C:57:4D:1A:D3:91
SHA-256: 3A:A7:97:C1:74:11:F7:3E:3F:DE:70:60:53:B8:06:4C:98:03:7D:0F:6D:4A:C1:4B:B6:8D:9B:83:B2:9A:74:D7
Valid until: Saturday, October 30, 2049
----------
Variant: release
Config: debug
Store: C:\Users\lhmar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 7D:56:ED:6E:A5:1A:76:3D:F5:74:E2:71:34:11:54:FB
SHA1: 09:C5:EA:EA:7D:B6:AD:D9:CE:F0:E0:D9:03:C8:3C:57:4D:1A:D3:91
SHA-256: 3A:A7:97:C1:74:11:F7:3E:3F:DE:70:60:53:B8:06:4C:98:03:7D:0F:6D:4A:C1:4B:B6:8D:9B:83:B2:9A:74:D7
Valid until: Saturday, October 30, 2049
----------*/
/*
Variant: profile
Config: debug
Store: C:\Users\lhmar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 7D:56:ED:6E:A5:1A:76:3D:F5:74:E2:71:34:11:54:FB
SHA1: 09:C5:EA:EA:7D:B6:AD:D9:CE:F0:E0:D9:03:C8:3C:57:4D:1A:D3:91
SHA-256: 3A:A7:97:C1:74:11:F7:3E:3F:DE:70:60:53:B8:06:4C:98:03:7D:0F:6D:4A:C1:4B:B6:8D:9B:83:B2:9A:74:D7
Valid until: Saturday, October 30, 2049
----------
Variant: debugAndroidTest
Config: debug
Store: C:\Users\lhmar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 7D:56:ED:6E:A5:1A:76:3D:F5:74:E2:71:34:11:54:FB
SHA1: 09:C5:EA:EA:7D:B6:AD:D9:CE:F0:E0:D9:03:C8:3C:57:4D:1A:D3:91
SHA-256: 3A:A7:97:C1:74:11:F7:3E:3F:DE:70:60:53:B8:06:4C:98:03:7D:0F:6D:4A:C1:4B:B6:8D:9B:83:B2:9A:74:D7
Valid until: Saturday, October 30, 2049
----------
Variant: debugUnitTest
Config: debug
Store: C:\Users\lhmar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 7D:56:ED:6E:A5:1A:76:3D:F5:74:E2:71:34:11:54:FB
SHA1: 09:C5:EA:EA:7D:B6:AD:D9:CE:F0:E0:D9:03:C8:3C:57:4D:1A:D3:91
SHA-256: 3A:A7:97:C1:74:11:F7:3E:3F:DE:70:60:53:B8:06:4C:98:03:7D:0F:6D:4A:C1:4B:B6:8D:9B:83:B2:9A:74:D7
Valid until: Saturday, October 30, 2049
----------
Variant: releaseUnitTest
Config: debug
Store: C:\Users\lhmar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 7D:56:ED:6E:A5:1A:76:3D:F5:74:E2:71:34:11:54:FB
SHA1: 09:C5:EA:EA:7D:B6:AD:D9:CE:F0:E0:D9:03:C8:3C:57:4D:1A:D3:91
SHA-256: 3A:A7:97:C1:74:11:F7:3E:3F:DE:70:60:53:B8:06:4C:98:03:7D:0F:6D:4A:C1:4B:B6:8D:9B:83:B2:9A:74:D7
Valid until: Saturday, October 30, 2049
----------
Variant: profileUnitTest
Config: debug
Store: C:\Users\lhmar\.android\debug.keystore
Alias: AndroidDebugKey
MD5: 7D:56:ED:6E:A5:1A:76:3D:F5:74:E2:71:34:11:54:FB
SHA1: 09:C5:EA:EA:7D:B6:AD:D9:CE:F0:E0:D9:03:C8:3C:57:4D:1A:D3:91
SHA-256: 3A:A7:97:C1:74:11:F7:3E:3F:DE:70:60:53:B8:06:4C:98:03:7D:0F:6D:4A:C1:4B:B6:8D:9B:83:B2:9A:74:D7
Valid until: Saturday, October 30, 2049*/
