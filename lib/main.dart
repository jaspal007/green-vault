import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:green_vault/firebase_options.dart';
import 'package:green_vault/screens/main_screen.dart';
import 'package:green_vault/screens/splash_screen.dart';
import 'package:page_transition/page_transition.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message: ${message.messageId}");
  displayLocalNotification(message.data);
  // Handle the incoming message here
}

void setupFirebaseMessaging() {
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    print("Handling a foreground message: ${message.messageId}");
  displayLocalNotification(message.data);
    // Handle the incoming message here
  });
}
Future<void> displayLocalNotification(Map<String, dynamic> data) async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  const AndroidNotificationDetails androidPlatformChannelSpecifics =
      AndroidNotificationDetails(
    'your_channel_id',
    'your_channel_name',
    importance: Importance.max,
    priority: Priority.high,
    ticker: 'ticker',
  );

  const NotificationDetails platformChannelSpecifics =
      NotificationDetails(android: androidPlatformChannelSpecifics);

  await flutterLocalNotificationsPlugin.show(
    0,
    data['title'],
    data['body'],
    platformChannelSpecifics,
    payload: 'item x',
  );
}

Future<void> requestNotificationPermissions() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  NotificationSettings settings = await messaging.requestPermission(
    alert: true,
    badge: true,
    sound: true,
  );

  print('User granted permission: ${settings.authorizationStatus}');
}

Future<String?> getFcmToken() async {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  String? token = await messaging.getToken();
  print("token: $token");
  return token;
}

Future<void> initNotifications() async {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  const AndroidInitializationSettings androidInitializationSettings =
      AndroidInitializationSettings('app_icon');

  const DarwinInitializationSettings darwinInitializationSettings =
      DarwinInitializationSettings(
          onDidReceiveLocalNotification: onDidReceiveLocalNotification);

  const InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: darwinInitializationSettings);

  await flutterLocalNotificationsPlugin.initialize(
    initializationSettings,
    onDidReceiveNotificationResponse: (details) {
      print(details.payload);
    },
    onDidReceiveBackgroundNotificationResponse: (details) => print(details.payload),
  );
}

Future<void> onDidReceiveLocalNotification(
    int id, String? title, String? body, String? payload) async {
  // Handle when a notification is tapped while the app is in the foreground
}

// Future<void> selectNotification(String payload) async {
  // Handle when a notification is tapped while the app is in the background or terminated
// }

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    getFcmToken();
    requestNotificationPermissions();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle: GoogleFonts.merriweather(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.transparent,
        textTheme: TextTheme(
          bodyLarge: GoogleFonts.merriweather(color: Colors.indigo),
          bodyMedium: GoogleFonts.merriweather(
            color: Colors.black,
            fontSize: 30,
            fontWeight: FontWeight.bold,
          ),
          bodySmall: GoogleFonts.merriweather(color: Colors.green),
          titleLarge: GoogleFonts.merriweather(color: Colors.yellow),
          titleMedium: GoogleFonts.merriweather(color: Colors.pink),
          titleSmall: GoogleFonts.merriweather(color: Colors.red),
          headlineLarge: GoogleFonts.merriweather(backgroundColor: Colors.grey),
          headlineMedium:
              GoogleFonts.merriweather(backgroundColor: Colors.orange),
          headlineSmall: GoogleFonts.merriweather(backgroundColor: Colors.red),
        ),
        textButtonTheme: const TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: MaterialStatePropertyAll(Colors.black),
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        duration: 300,
        splash: const SplashScreen(),
        nextScreen: const MyHome(),
        backgroundColor: Colors.white,
        splashTransition: SplashTransition.fadeTransition,
        splashIconSize: 100,
        pageTransitionType: PageTransitionType.bottomToTop,
      ),
    );
  }
}
