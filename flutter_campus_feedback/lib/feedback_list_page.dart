import 'package:flutter/material.dart';
import 'feedback_detail_page.dart';
import 'model/feedback_item.dart';

class FeedbackListPage extends StatelessWidget {
  final List<FeedbackItem> feedbackList;
  final Function(int) onFeedbackDeleted;

  const FeedbackListPage({
    super.key,
    required this.feedbackList,
    required this.onFeedbackDeleted,
  });

  IconData _getFeedbackIcon(String jenisFeedback) {
    switch (jenisFeedback) {
      case 'Apresiasi':
        return Icons.thumb_up;
      case 'Saran':
        return Icons.lightbulb;
      case 'Keluhan':
        return Icons.warning;
      default:
        return Icons.feedback;
    }
  }

  Color _getFeedbackColor(String jenisFeedback) {
    switch (jenisFeedback) {
      case 'Apresiasi':
        return Colors.green;
      case 'Saran':
        return Colors.blue;
      case 'Keluhan':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Daftar Feedback'),
      ),
      body: feedbackList.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.feedback, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'Belum ada feedback',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: feedbackList.length,
              itemBuilder: (context, index) {
                final feedback = feedbackList[index];
                return Card(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      _getFeedbackIcon(feedback.jenisFeedback),
                      color: _getFeedbackColor(feedback.jenisFeedback),
                    ),
                    title: Text(feedback.nama),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(feedback.fakultas),
                        Text('Nilai: ${feedback.nilaiKepuasan}'), // UBAH: tanpa .0
                      ],
                    ),
                    trailing: Chip(
                      label: Text(feedback.jenisFeedback),
                      backgroundColor: _getFeedbackColor(feedback.jenisFeedback)
                          .withOpacity(0.2),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => FeedbackDetailPage(
                            feedback: feedback,
                            onDelete: () {
                              onFeedbackDeleted(index);
                              Navigator.pop(context);
                            },
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}