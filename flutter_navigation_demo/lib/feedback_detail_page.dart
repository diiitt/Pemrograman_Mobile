import 'package:flutter/material.dart';

class FeedbackDetailPage extends StatelessWidget {
  final String feedbackData;

  const FeedbackDetailPage({
    super.key,
    required this.feedbackData,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Detail Feedback:',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  feedbackData,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Feedback berhasil dikirim!');
                    },
                    child: const Text('Konfirmasi Kirim'),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      Navigator.pop(context, 'Feedback dibatalkan');
                    },
                    child: const Text('Kembali & Edit'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}