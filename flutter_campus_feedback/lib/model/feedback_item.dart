class FeedbackItem {
  final String id;
  final String nama;
  final String nim;
  final String fakultas;
  final List<String> fasilitas;
  final int nilaiKepuasan; // UBAH: double → int
  final String jenisFeedback;
  final bool setujuSyarat;
  final DateTime tanggal;

  FeedbackItem({
    required this.id,
    required this.nama,
    required this.nim,
    required this.fakultas,
    required this.fasilitas,
    required this.nilaiKepuasan, // UBAH: double → int
    required this.jenisFeedback,
    required this.setujuSyarat,
    required this.tanggal,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nama': nama,
      'nim': nim,
      'fakultas': fakultas,
      'fasilitas': fasilitas,
      'nilaiKepuasan': nilaiKepuasan, // UBAH: double → int
      'jenisFeedback': jenisFeedback,
      'setujuSyarat': setujuSyarat,
      'tanggal': tanggal.toIso8601String(),
    };
  }

  factory FeedbackItem.fromMap(Map<String, dynamic> map) {
    return FeedbackItem(
      id: map['id'],
      nama: map['nama'],
      nim: map['nim'],
      fakultas: map['fakultas'],
      fasilitas: List<String>.from(map['fasilitas']),
      nilaiKepuasan: map['nilaiKepuasan'], // UBAH: double → int
      jenisFeedback: map['jenisFeedback'],
      setujuSyarat: map['setujuSyarat'],
      tanggal: DateTime.parse(map['tanggal']),
    );
  }
}