import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tentang Aplikasi'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Tentang Aplikasi',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Flutter Navigation Demo',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    const Text('Aplikasi ini dibuat untuk demonstrasi:'),
                    const SizedBox(height: 10),
                    _buildFeatureItem('Navigasi antar halaman'),
                    _buildFeatureItem('Pengiriman data'),
                    _buildFeatureItem('Bottom Navigation Bar'),
                    _buildFeatureItem('Material Design 3'),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Kembali ke Home'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        children: [
          Icon(
            Icons.check_circle,
            color: Colors.green.shade600,
            size: 20,
          ),
          const SizedBox(width: 8),
          Text(text),
        ],
      ),
    );
  }
}