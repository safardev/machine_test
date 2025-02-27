abstract class StoryDetailsEvent {
  final int id;
  StoryDetailsEvent(this.id);
}

class FetchStoryDetails extends StoryDetailsEvent {
  FetchStoryDetails(int id) : super(id);
}
