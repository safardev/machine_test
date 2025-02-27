import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/repositories/hacker_news_repository.dart';
import 'package:machine_test/view/home.dart';

import 'bloc/top_stories/top_stories_bloc.dart';
import 'bloc/top_stories/top_stories_event.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              TopStoriesBloc(HackerNewsRepository())..add(FetchTopStories()),
        ),
      ],
      child: MaterialApp(
        title: 'Machine Test',
        debugShowCheckedModeBanner: false,
        theme:ThemeData(primarySwatch: Colors.blue),
        home: Home(),
      ),
    );
  }
}
