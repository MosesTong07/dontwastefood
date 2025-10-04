import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'fridge_page.dart';

Future<void> main() async {
  await Supabase.initialize(
    url: "https://drmqslzwrbpmbhyfwgma.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImRybXFzbHp3cmJwbWJoeWZ3Z21hIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTk0NzcxNTMsImV4cCI6MjA3NTA1MzE1M30.2KnlY3mI2fqB32TLTy0QkSIDMtZF_8CzIiXhfpQwog4",
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FridgePage(),
    );
  }
}
