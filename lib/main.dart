import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:mobilicis/fcm_api.dart';
import 'package:mobilicis/pages/home_page.dart';
import 'package:mobilicis/pages/notification_page.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mobilicis/redux/reducer.dart';
import 'package:mobilicis/redux/states/filter_state.dart';
import 'package:redux/redux.dart';

final navigatorKey = GlobalKey<NavigatorState>();

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

void main() async {
  await dotenv.load(fileName: ".env");
  HttpOverrides.global = MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await FCMApi().initNotification();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final Store<SelectedFitlersState> _selectedFiltersStore =
      Store<SelectedFitlersState>(
    selectedFiltersReducer,
    initialState: SelectedFitlersState(selectedFilters: {
      "make": [],
      "condition": [],
      "storage": [],
      "ram": []
    }),
  );

  @override
  Widget build(BuildContext context) {
    debugInvertOversizedImages = true;
    return StoreProvider(
      store: _selectedFiltersStore,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          textTheme: GoogleFonts.comfortaaTextTheme(
            Theme.of(context).textTheme,
          ),
          scaffoldBackgroundColor: Colors.transparent,
          useMaterial3: true,
        ),
        navigatorKey: navigatorKey,
        home: const HomePage(),
        routes: {
          NotificationPage.route: (context) => const NotificationPage(),
        },
      ),
    );
  }
}
