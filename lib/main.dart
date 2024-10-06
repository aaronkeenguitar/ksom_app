import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'models/user.dart';
import 'pages/home_page.dart';
import 'pages/LoginSignUp_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp(
    options: FirebaseOptions(
    apiKey: 'AIzaSyAE5uYFiPamj8BbCj4O08hmQ6zpZFuawXY',
    appId: '1:634451119941:android:eb4b78e5cfda6ff3f4382c',
    messagingSenderId: 'sendid',
    projectId: 'k-s-o-m-app-2u92g1',
    storageBucket: 'k-s-o-m-app-2u92g1.appspot.com',
  )
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        // Check for errors
        if (snapshot.hasError) {
          return MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error initializing Firebase: ${snapshot.error}'),
              ),
            ),
          );
        }

        // Once complete, show your application
        if (snapshot.connectionState == ConnectionState.done) {
          return MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (_) => UserProvider()),
            ],
            child: MaterialApp(
              title: 'Instrument Tabs',
              theme: ThemeData(
                primarySwatch: Colors.blue,
              ),
              home: Consumer<UserProvider>(
                builder: (context, userProvider, _) {
                  return userProvider.user == null ? LoginSignUpPage() : HomePage();
                },
              ),
            ),
          );
        }

        // Otherwise, show something whilst waiting for initialization to complete
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          ),
        );
      },
    );
  }
}