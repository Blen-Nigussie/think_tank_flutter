import 'user.dart';

class FeedbackItem {
  final String id;
  final String comment;
  final String status;

  FeedbackItem({
    required this.id,
    required this.comment,
    required this.status,
  });
}

class Idea {
  final String id;
  final String title;
  final String description;
  final String status;
  final User? user;
  final List<FeedbackItem>? feedback;

  Idea({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    this.user,
    this.feedback,
  });

  get tags => null;
} 