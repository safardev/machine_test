import '../../models/story_model.dart';

abstract class StoryDetailsState {}

class StoryDetailsLoading extends StoryDetailsState {}

class StoryDetailsLoaded extends StoryDetailsState {
  final Story story;
  StoryDetailsLoaded(this.story);
}

class StoryDetailsError extends StoryDetailsState {}
