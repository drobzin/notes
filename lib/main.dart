import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes/bloc/main_bloc.dart';
import 'package:notes/network_repository.dart';

import 'main_page.dart';

void main() {
  runApp(MultiRepositoryProvider(
      providers: [RepositoryProvider(create: (_) => NetworkRepository())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MainBloc(context.read()),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const MainPage(),
      ),
    );
  }
}
