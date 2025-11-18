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
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Logo UIN - HANYA DI ABOUT PAGE
            Container(
              width: 200,
              height: 200,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Image.asset(
                'assets/images/uin_Logo.jpg',
                fit: BoxFit.contain,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    decoration: BoxDecoration(
                      color: Colors.green[800],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.account_balance,
                          size: 60,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'UIN STS\nJAMBI',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),

            // Informasi Aplikasi
            const Text(
              'UIN Sulthan Thaha Saifuddin Jambi',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Program Studi Sistem Informasi',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            const SizedBox(height: 32),

            // Card Informasi
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildInfoItem(
                      'Mata Kuliah',
                      'Pemrograman Mobile',
                    ),
                    const Divider(),
                    _buildInfoItem(
                      'Dosen Pengampu',
                      'Ahmad Nasukha, S.Hum., M.S.I',
                    ),
                    const Divider(),
                    _buildInfoItem(
                      'Nama Aplikasi',
                      'Campus Feedback',
                    ),
                    const Divider(),
                    _buildInfoItem(
                      'Pengembang',
                      'Adhitya Apriliandi',
                    ),
                    const Divider(),
                    _buildInfoItem(
                      'Tahun Akademik',
                      '2025/2026',
                    ),
                  ],
                ),
              ),
            ),
            const Spacer(),

            
            // Tombol Kembali
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali ke Beranda'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}