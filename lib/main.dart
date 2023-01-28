import 'package:flutter/material.dart';
import 'package:money_app_flutter/domain/repositories/preferences_repository.dart';
import 'package:money_app_flutter/presentation/di/app_module.dart';
import 'package:money_app_flutter/presentation/screens/assets_screen.dart';
import 'package:money_app_flutter/presentation/screens/categories_screen.dart';
import 'package:money_app_flutter/presentation/screens/profile_screen.dart';
import 'package:money_app_flutter/presentation/screens/sign_in_screen.dart';
import 'package:money_app_flutter/presentation/screens/sign_up_screen.dart';
import 'package:money_app_flutter/presentation/screens/transactions_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  AppModule().provideDependencies();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  late PreferencesRepository _preferencesRepository;

  MyApp({super.key}) {
    _preferencesRepository = AppModule.getPreferencesRepository();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _preferencesRepository.restoreSavedApiToken(),
        builder: (context, token) {
          if (token.connectionState != ConnectionState.done) {
            return const Center(child: CircularProgressIndicator());
          }
          return MaterialApp(
            builder: (context, navigator) {
              return Overlay(
                initialEntries: [
                  OverlayEntry(
                    builder: (context) {
                      return Scaffold(
                        body: SafeArea(child: navigator!),
                      );
                    },
                  ),
                ],
              );
            },
            routes: {
              '/sign-in': (_) => SignInScreen(),
              '/sign-up': (_) => SignUpScreen(),
              '/profile': (_) => const ProfileScreen(),
              '/assets': (_) => const AssetsScreen(),
              '/categories': (_) => const CategoriesScreen(),
              '/transactions': (_) => const TransactionsScreen(),
            },
            initialRoute: token.data == null ? "/sign-in" : "/profile",
          );
        });
  }
}
