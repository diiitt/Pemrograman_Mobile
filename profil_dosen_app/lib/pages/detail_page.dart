import 'package:flutter/material.dart';
import '../models/dosen_model.dart';

class DetailPage extends StatelessWidget {
  final Dosen dosen;

  const DetailPage({Key? key, required this.dosen}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 250.0,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                dosen.nama,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [Colors.blue[700]!, Colors.blue[400]!],
                  ),
                ),
                child: Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Card Informasi Pribadi
                  _buildInfoCard(
                    title: 'Informasi Pribadi',
                    children: [
                      _buildInfoItem('NIP', dosen.nip),
                      _buildInfoItem('Email', dosen.email),
                      _buildInfoItem('Jabatan', dosen.jabatan),
                      _buildInfoItem('Bidang Keahlian', dosen.bidang),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Card Pendidikan
                  _buildInfoCard(
                    title: 'Pendidikan',
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Row(
                          children: [
                            Icon(Icons.school, color: Colors.blue, size: 20),
                            SizedBox(width: 12),
                            Expanded(
                              child: Text(
                                dosen.pendidikan,
                                style: TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Card Mata Kuliah
                  _buildInfoCard(
                    title: 'Mata Kuliah yang Diampu',
                    children: [
                      Wrap(
                        spacing: 8,
                        runSpacing: 8,
                        children: dosen.mataKuliah.map((mk) {
                          return Chip(
                            label: Text(
                              mk,
                              style: TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.blue[600],
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                  
                  SizedBox(height: 16),
                  
                  // Card Deskripsi
                  _buildInfoCard(
                    title: 'Deskripsi',
                    children: [
                      Text(
                        dosen.deskripsi,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context);
        },
        child: Icon(Icons.arrow_back),
        backgroundColor: Colors.blue[700],
      ),
    );
  }

  Widget _buildInfoCard({required String title, required List<Widget> children}) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[700],
              ),
            ),
            SizedBox(height: 12),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildInfoItem(String label, String value) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 120,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
          ),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              value,
              style: TextStyle(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }
}