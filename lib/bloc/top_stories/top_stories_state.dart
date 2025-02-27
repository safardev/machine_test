abstract class TopStoriesState {}

class TopStoriesLoading extends TopStoriesState {}

class TopStoriesLoaded extends TopStoriesState {
  final List<int> ids;
  TopStoriesLoaded(this.ids);
}

class TopStoriesError extends TopStoriesState {}
