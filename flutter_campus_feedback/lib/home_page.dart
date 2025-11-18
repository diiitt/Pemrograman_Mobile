import 'package:flutter/material.dart';
import 'feedback_form_page.dart';
import 'feedback_list_page.dart';
import 'about_page.dart';
import 'model/feedback_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<FeedbackItem> feedbackList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Campus Feedback'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo Flutter - HANYA DI HOME PAGE
            Container(
              width: 120,
              height: 120,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/flutter_Logo.png',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[500],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Icon(
                      Icons.flutter_dash,
                      size: 60,
                      color: Colors.white,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            
            // Nama Aplikasi
            const Text(
              'Campus Feedback',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Aplikasi Kuesioner Kepuasan Mahasiswa',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 40),
            
            // Tombol-tombol navigasi
            Column(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => FeedbackFormPage(
                          onFeedbackSubmitted: (feedback) {
                            setState(() {
                              feedbackList.add(feedback);
                            });
                          },
                        ),
                      ),
                    );
                  },
                  icon: const Icon(Icons.feedback),
                  label: const Text('Formulir Feedback'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: feedbackList.isEmpty
                      ? null
                      : () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FeedbackListPage(
                                feedbackList: feedbackList,
                                onFeedbackDeleted: (index) {
                                  setState(() {
                                    feedbackList.removeAt(index);
                                  });
                                },
                              ),
                            ),
                          );
                        },
                  icon: const Icon(Icons.list),
                  label: const Text('Daftar Feedback'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
                const SizedBox(height: 15),
                ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AboutPage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.info),
                  label: const Text('Tentang Aplikasi'),
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                  ),
                ),
              ],
            ),
            const Spacer(),
            
            // Teks motivasi
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Text(
                '"Coding adalah seni memecahkan masalah dengan logika dan kreativitas."',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}