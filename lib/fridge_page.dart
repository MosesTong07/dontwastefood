import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final supabase = Supabase.instance.client;

class FridgePage extends StatefulWidget {
  const FridgePage({Key? key}) : super(key: key);

  @override
  State<FridgePage> createState() => _FridgePageState();
}

class _FridgePageState extends State<FridgePage> {
  final _stream = supabase
      .from('FridgeToContent')
      .stream(primaryKey: ['fridge_content_id']);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Fridge Contents')),
      body: StreamBuilder(
        stream: _stream,
        builder: (content, snapshot) {
          if (!snapshot.hasData) {
            return const CircularProgressIndicator();
          }
          final data = snapshot.data!;
          if (data.isEmpty) {
            return const Text("No data");
          }
          return Text(data.toString());
        },
      ),
    );
  }
}
