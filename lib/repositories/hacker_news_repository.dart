import 'package:dio/dio.dart';

const String topStoriesUrl = 'https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty';
const String itemUrl = 'https://hacker-news.firebaseio.com/v0/item/';

class HackerNewsRepository {
  final Dio _dio = Dio();

  Future<List<int>> fetchTopStoryIds() async {
    try {
      final response = await _dio.get(topStoriesUrl);
      return List<int>.from(response.data);
    } catch (e) {
      throw Exception('Failed to load top stories');
    }
  }

  Future<Map<String, dynamic>> fetchStoryDetails(int id) async {
    try {
      final response = await _dio.get('$itemUrl$id.json?print=pretty');
      return response.data;
    } catch (e) {
      throw Exception('Failed to load story details');
    }
  }
}
