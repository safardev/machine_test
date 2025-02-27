import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/bloc/top_stories/top_stories_event.dart';
import 'package:machine_test/bloc/top_stories/top_stories_state.dart';

import '../../repositories/hacker_news_repository.dart';

class TopStoriesBloc extends Bloc<TopStoriesEvent, TopStoriesState> {
  final HackerNewsRepository repository;

  TopStoriesBloc(this.repository) : super(TopStoriesLoading()) {
    on<FetchTopStories>((event, emit) async {
      try {
        final ids = await repository.fetchTopStoryIds();
        emit(TopStoriesLoaded(ids));
      } catch (_) {
        emit(TopStoriesError());
      }
    });
  }
}