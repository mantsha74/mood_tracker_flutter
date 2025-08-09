import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'data/repo/auth_repo.dart';
import 'data/repo/mood_repo.dart';
import 'features/auth/auth_screen.dart';
import 'features/home/home_screen.dart';
import 'state/auth_controller.dart';

class App extends StatelessWidget {
  const App({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (_) => AuthRepo()),
        Provider(create: (_) => MoodRepo()),
        ChangeNotifierProvider(create: (c) => AuthController(c.read<AuthRepo>())),
      ],
      child: const MaterialApp(debugShowCheckedModeBanner:false, home: _Gate()),
    );
  }
}

class _Gate extends StatelessWidget {
  const _Gate({super.key});
  @override
  Widget build(BuildContext context) {
    final user = context.watch<AuthController>().user;
    return user==null ? const AuthScreen() : const HomeScreen();
  }
}
