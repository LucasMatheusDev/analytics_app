import 'package:analytics_app/analytics_app.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

import 'app/pages/modules/home_page/home_data_source.dart';
import 'app/pages/modules/home_page/home_page.dart';
import 'app/pages/modules/login/login_data_source.dart';
import 'app/pages/modules/login/login_page.dart';

void main() {
  runApp(const MyApp());
}

final getIt = GetIt.instance;

const isAnalyticsMode = true;

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    if (isAnalyticsMode) {
      getIt.registerFactory<MockHomeDataSource>(
        () => MockHomeDataSource(),
      );
      getIt.registerFactory<MockLoginDataSource>(
        () => MockLoginDataSource(),
      );
    } else {
      getIt.registerFactory<HomeDataSource>(
        () => HomeDataSourceImpl(),
      );
      getIt.registerFactory<LoginDataSource>(
        () => LoginDataSourceImpl(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnalyticsApp(
      // Pass true to activate the analytics mode.
      isActivateAnalytics: isAnalyticsMode,
      // Pass the MaterialApp widget as a parameter to
      // the materialApp parameter and add the navigatorObservers
      // parameter to the MaterialApp widget.
      materialApp: (observer) => MaterialApp(
        /// Add the observer to the MaterialApp.
        navigatorObservers: [observer],
        initialRoute: '/',
        title: 'Flutter Demo',
        routes: {
          '/': (context) => const InitialPage(),
          '/home': (context) => MyHomePage(
                dataSource: isAnalyticsMode
                    ? getIt.get<MockHomeDataSource>()
                    : getIt.get<HomeDataSource>(),
              ),
          '/login': (context) => LoginPage(
                dataSource: isAnalyticsMode
                    ? getIt.get<MockLoginDataSource>()
                    : getIt.get<LoginDataSource>(),
              ),
        },
      ),
    );
  }
}

class InitialPage extends StatelessWidget {
  const InitialPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Initial Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Initial Page',
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/login');
              },
              child: const Text('Go to other page'),
            ),
          ],
        ),
      ),
    );
  }
}
