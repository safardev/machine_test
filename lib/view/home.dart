import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_launcher/url_launcher.dart';
import '../bloc/story_details/story_details_bloc.dart';
import '../bloc/story_details/story_details_event.dart';
import '../bloc/story_details/story_details_state.dart';
import '../bloc/top_stories/top_stories_bloc.dart';
import '../bloc/top_stories/top_stories_state.dart';
import '../repositories/hacker_news_repository.dart';
import '../models/story_model.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Hacker News Top Posts',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: SafeArea(
        child: BlocBuilder<TopStoriesBloc, TopStoriesState>(
          builder: (context, state) {
            if (state is TopStoriesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TopStoriesError) {
              return const Center(child: Text('Failed to load top stories'));
            } else if (state is TopStoriesLoaded) {
              final ids = state.ids;
              return ListView.builder(
                itemCount: ids.length,
                itemBuilder: (context, index) {
                  return BlocProvider(
                    create: (_) => StoryDetailsBloc(HackerNewsRepository())
                      ..add(FetchStoryDetails(ids[index])),
                    child: BlocBuilder<StoryDetailsBloc, StoryDetailsState>(
                      builder: (context, state) {
                        if (state is StoryDetailsLoading) {
                          return const ListTile(title: Text('Loading...'));
                        } else if (state is StoryDetailsError) {
                          return const ListTile(
                              title: Text('Error loading story'));
                        } else if (state is StoryDetailsLoaded) {
                          final Story story = state.story;
                          return ListTile(
                            title: Text(story.title,overflow: TextOverflow.ellipsis,),
                            subtitle: Text(
                              'by ${story.by}'
                            ),
                            trailing: Icon(Icons.arrow_right,color: Colors.blue,),
                            onTap: () async {
                              if (story.url != null) {
                                final Uri url = Uri.parse(story.url!);
                                if (await canLaunchUrl(url)) {
                                  await launchUrl(url,
                                      mode: LaunchMode.inAppBrowserView);
                                } else {
                                  throw 'Could not launch $url';
                                }
                              }
                            },
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
