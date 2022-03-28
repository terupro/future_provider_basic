//ソース
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final futureProvider = FutureProvider<String>((ref) async {
  await Future.delayed(Duration(seconds: 5));

  // ここで非同期で取得したい値を提示する
  return 'Hello World';
});

void main() {
  runApp(
    ProviderScope(child: MyApp()),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final future = ref.watch(futureProvider);

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Riverpod'),
        ),
        body: Center(
          child: future.when(
            loading: () => const CircularProgressIndicator(),
            error: (err, stack) => Text('Error: $err'),
            // dataに非同期で取得したい値が格納されている
            data: (data) => Text(data),
          ),
        ),
      ),
    );
  }
}
