import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test/bloc/story_details/story_details_event.dart';
import 'package:machine_test/bloc/story_details/story_details_state.dart';

import '../../models/story_model.dart';
import '../../repositories/hacker_news_repository.dart';

class StoryDetailsBloc extends Bloc<StoryDetailsEvent, StoryDetailsState> {
  final HackerNewsRepository repository;

  StoryDetailsBloc(this.repository) : super(StoryDetailsLoading()) {
    on<FetchStoryDetails>((event, emit) async {
      try {
        final details = await repository.fetchStoryDetails(event.id);
        emit(StoryDetailsLoaded(Story.fromJson(details)));
      } catch (_) {
        emit(StoryDetailsError());
      }
    });
  }
}
