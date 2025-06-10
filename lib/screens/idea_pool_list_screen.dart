import 'package:flutter/material.dart';
import 'package:thinktankapp/data/models/idea.dart';

class IdeaPoolListScreen extends StatelessWidget {
  final List<Idea> ideas;
  final Function(Idea) onReviewIdea;
  final VoidCallback onViewReviewedIdeas;
  final VoidCallback onBack;

  const IdeaPoolListScreen({
    super.key,
    required this.ideas,
    required this.onReviewIdea,
    required this.onViewReviewedIdeas,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: const Text(
          "Review Submitted Ideas",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Color(0xFFFAA60C)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
        actions: [
          TextButton(
            onPressed: onViewReviewedIdeas,
            child: const Text(
              "View Reviewed",
              style: TextStyle(
                color: Color(0xFFFAA60C),
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: ideas.length,
        itemBuilder: (context, index) {
          final idea = ideas[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Card(
              elevation: 8,
              color: const Color(0xFF1A1A1A),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      idea.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      idea.description,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white.withAlpha((0.8 * 255).toInt()),
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Submitted by: ${idea.user?.firstName} ${idea.user?.lastName}',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white.withAlpha((0.7 * 255).toInt()),
                          ),
                        ),
                        ElevatedButton.icon(
                          onPressed: () => onReviewIdea(idea),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFFFAA60C),
                            foregroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16,
                              vertical: 8,
                            ),
                          ),
                          icon: const Icon(Icons.rate_review),
                          label: const Text(
                            'Review',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
} 