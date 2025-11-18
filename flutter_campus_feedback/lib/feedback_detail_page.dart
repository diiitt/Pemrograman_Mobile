import 'package:flutter/material.dart';
import 'model/feedback_item.dart';

class FeedbackDetailPage extends StatelessWidget {
  final FeedbackItem feedback;
  final VoidCallback onDelete;

  const FeedbackDetailPage({
    super.key,
    required this.feedback,
    required this.onDelete,
  });

  void _showDeleteDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi Hapus'),
        content: const Text('Apakah Anda yakin ingin menghapus feedback ini?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              onDelete();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Feedback berhasil dihapus!'),
                  backgroundColor: Colors.red,
                ),
              );
            },
            child: const Text('Hapus', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

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
            // Header
            Center(
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    const Icon(Icons.feedback, size: 48, color: Colors.blue),
                    const SizedBox(height: 8),
                    Text(
                      feedback.jenisFeedback,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Data Mahasiswa
            const Text(
              'Data Mahasiswa:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            _buildDetailItem('Nama', feedback.nama),
            _buildDetailItem('NIM', feedback.nim),
            _buildDetailItem('Fakultas', feedback.fakultas),
            const SizedBox(height: 16),

            // Fasilitas yang Dinilai
            const Text(
              'Fasilitas yang Dinilai:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              children: feedback.fasilitas.map((fasilitas) {
                return Chip(
                  label: Text(fasilitas),
                  backgroundColor: Colors.green.withOpacity(0.2),
                );
              }).toList(),
            ),
            const SizedBox(height: 16),

            // Nilai Kepuasan - BAGIAN YANG DIUBAH
            const Text(
              'Nilai Kepuasan:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: LinearProgressIndicator(
                    value: feedback.nilaiKepuasan / 5, // Tetap bagi dengan 5 untuk progress
                    backgroundColor: Colors.grey[300],
                    color: _getRatingColor(feedback.nilaiKepuasan.toDouble()),
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  '${feedback.nilaiKepuasan}/5', // UBAH: tanpa .0
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: _getRatingColor(feedback.nilaiKepuasan.toDouble()),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Status Setuju
            _buildDetailItem(
              'Status Setuju Syarat & Ketentuan',
              feedback.setujuSyarat ? 'Ya' : 'Tidak',
            ),
            _buildDetailItem(
              'Tanggal Submit',
              '${feedback.tanggal.day}/${feedback.tanggal.month}/${feedback.tanggal.year}',
            ),
            const Spacer(),

            // Tombol-tombol
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Kembali'),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () => _showDeleteDialog(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    child: const Text(
                      'Hapus',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }

  Color _getRatingColor(double rating) {
    if (rating >= 4) return Colors.green;
    if (rating >= 3) return Colors.blue;
    if (rating >= 2) return Colors.orange;
    return Colors.red;
  }
}