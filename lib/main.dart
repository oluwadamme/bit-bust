import 'package:bitbust/src/components/components.dart';
import 'package:bitbust/src/core/push_notification_service.dart';
import 'package:bitbust/src/utils/utils.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  await PushNotificationService.registerNotification();
  await PushNotificationService.initializeLocalNotifications();
  await dotenv.load();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

  // Status bar config
  SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.manual,
    overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom],
  );
  ErrorHandling.init();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  @override
  void initState() {
    super.initState();
    FirebaseMessaging.onBackgroundMessage(PushNotificationService.firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessageOpenedApp.listen((event) {
      Helpers.logc("event:::: $event");
      PushNotificationService.firebaseMessagingBackgroundHandler(event);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BitBust',
      theme: ThemeConfig.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      onGenerateRoute: AppRouter.generateRoute,
      navigatorKey: navigatorKey,
    );
  }
}

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
