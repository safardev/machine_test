class Story {
  final String title;
  final String by;
  final String? url;

  Story({required this.title, required this.by, this.url});

  factory Story.fromJson(Map<String, dynamic> json) {
    return Story(
      title: json['title'] ?? 'No title',
      by: json['by'] ?? 'Unknown',
      url: json['url'],
    );
  }
}
