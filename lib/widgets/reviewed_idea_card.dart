import 'package:flutter/material.dart';
import 'package:thinktankapp/data/models/idea.dart';

class ReviewedIdeaCard extends StatelessWidget {
  final Idea idea;
  final Function(Idea) onEditFeedback;
  final Function(Idea) onDeleteFeedback;
  final bool isAdmin;

  const ReviewedIdeaCard({
    super.key,
    required this.idea,
    required this.onEditFeedback,
    required this.onDeleteFeedback,
    required this.isAdmin,
  });

  // Helper to get status icon
  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Approved':
        return Icons.check_circle;
      case 'Rejected':
        return Icons.cancel;
      case 'Pending':
      default:
        return Icons.hourglass_empty;
    }
  }

  // Helper to get status color
  Color _getStatusColor(String status) {
    switch (status) {
      case 'Approved':
        return Colors.green;
      case 'Rejected':
        return Colors.red;
      case 'Pending':
      default:
        return Colors.orange;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: const Color(0xFF1E1E1E), // Dark grey background for card
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Idea Title and Admin Actions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Text(
                    idea.title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
                if (isAdmin) // Only show actions if user is admin
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(
                          Icons.edit,
                          color: const Color(0xFFFAA60C),
                          size: 20,
                        ),
                        onPressed: () => onEditFeedback(idea),
                      ),
                      IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 20,
                        ),
                        onPressed: () => onDeleteFeedback(idea),
                      ),
                    ],
                  ),
              ],
            ),
            const SizedBox(height: 8),

            // Submitter Name
            if (idea.user != null)
              Text(
                'Submitted by: ${idea.user!.firstName} ${idea.user!.lastName}',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white.withOpacity(0.7),
                ),
              ),
            const SizedBox(height: 8),

            // Idea Description
            Text(
              idea.description,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.white,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),

            // Feedback Section
            Card(
              color: const Color(0xFF2A2A2A), // Slightly darker grey for feedback card
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Feedback",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFFFAA60C),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      idea.feedback?.isNotEmpty == true
                          ? idea.feedback!.first.comment
                          : "No feedback provided",
                      style: const TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          _getStatusIcon(idea.status),
                          color: _getStatusColor(idea.status),
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          idea.status,
                          style: TextStyle(
                            fontSize: 12,
                            color: _getStatusColor(idea.status),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
} 