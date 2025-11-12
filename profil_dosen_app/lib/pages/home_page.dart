import 'package:flutter/material.dart';
import '../models/dosen_model.dart';
import '../widgets/dosen_card.dart';
import 'detail_page.dart'; // ✅ TAMBAHKAN IMPORT INI

class HomePage extends StatelessWidget {
  final List<Dosen> listDosen = [
    Dosen(
      id: '1',
      nama: 'AHMAD NASUKHA, S.Hum., M.S.I.',
      nip: '19880722 202203 1 001',
      email: '-',
      jabatan: 'Dosen Tetap',
      bidang: 'Sistem Informasi',
      foto: 'assets/ahmad.jpg',
      deskripsi: 'Spesialis dalam bidang pemograman mobile dan pakar dalam bidanng AI.',
      pendidikan: 'S2 - Magister Sistem Informasi',
      mataKuliah: ['pemograman mobile'],
    ),
    Dosen(
      id: '2',
      nama: 'HERY AFRIYADI, SE., S.Kom,M.Si',
      nip: '19710415 200012 1 001',
      email: '-',
      jabatan: 'Dosen Tetap',
      bidang: 'Sistem Informasi',
      foto: 'assets/siti.jpg',
      deskripsi: 'Pakar dalam bidang Metodologi Penelitian Dan Riset.',
      pendidikan: 'S2 - Magister Sistem Informasi',
      mataKuliah: ['Metodologi Penelitian Dan Riset', 'Testing dan Implementasi System'],
    ),
    Dosen(
      id: '3',
      nama: 'MUTAMASSIKIN, M.Kom',
      nip: '19900409 201903 1 014',
      email: '-',
      jabatan: 'Dosen Tetap',
      bidang: 'Sistem Informasi',
      foto: 'assets/budi.jpg',
      deskripsi: 'Ahli dalam jaringan komputer.',
      pendidikan: 'S2 - Magister Komputer',
      mataKuliah: ['Pengantar Ilmu komputer', 'Manajemen Proyek Sistem Informasi'],
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profil Dosen',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: Colors.blue[700],
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue[700]!, Colors.blue[100]!],
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Daftar Dosen UIN STS JAMBI ',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  ),
                ),
                child: ListView.builder(
                  padding: EdgeInsets.all(16),
                  itemCount: listDosen.length,
                  itemBuilder: (context, index) {
                    return DosenCard(
                      dosen: listDosen[index],
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DetailPage(dosen: listDosen[index]), // ✅ PERBAIKI: Detail_Pages -> DetailPage
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}