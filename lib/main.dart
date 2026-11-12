import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'view/LoginView.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: const String.fromEnvironment(
      'SUPABASE_URL',
      defaultValue: 'https://pvrhfcdtqwcmysdbzjsu.supabase.co',
    ),
    publishableKey: const String.fromEnvironment(
      'SUPABASE_KEY',
      defaultValue: 'sb_publishable_XKZqW3aLL6rqlWACPoRx2w_l-RsovkT',
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginView(),
      debugShowCheckedModeBanner: false,
    );
  }
}