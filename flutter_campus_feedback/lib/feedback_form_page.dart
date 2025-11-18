import 'package:flutter/material.dart';
import 'model/feedback_item.dart';

class FeedbackFormPage extends StatefulWidget {
  final Function(FeedbackItem) onFeedbackSubmitted;

  const FeedbackFormPage({super.key, required this.onFeedbackSubmitted});

  @override
  State<FeedbackFormPage> createState() => _FeedbackFormPageState();
}

class _FeedbackFormPageState extends State<FeedbackFormPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _namaController = TextEditingController();
  final TextEditingController _nimController = TextEditingController();
  
  String _selectedFakultas = 'Fakultas Sains dan Teknologi';
  final List<String> _fasilitasList = [];
  int _nilaiKepuasan = 3; // UBAH: double → int
  String _selectedJenisFeedback = 'Saran';
  bool _setujuSyarat = false;

  final List<String> _fakultasOptions = [
    'Fakultas Sains dan Teknologi',
    'Fakultas Kedoteran',
    'Fakultas Ekonomi dan Bisnis Islam',
    'Fakultas Syariah',
    'Fakultas Ushuluddin Dan Studi Agama',
    'Fakultas Tarbiyah Dan Keguruan',
    'Fakultas Adab Dan Humaniora',
    'Fakultas Dakwah',
  ];

  final List<String> _fasilitasOptions = [
    'Perpustakaan',
    'Laboratorium',
    'Ruang Kelas',
    'Fasilitas Olahraga',
    'Kantin',
    'WiFi Kampus',
    'Parkir',
  ];

  final List<String> _jenisFeedbackOptions = [
    'Saran',
    'Keluhan',
    'Apresiasi',
  ];

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_fasilitasList.isEmpty) {
        _showFasilitasDialog();
        return;
      }

      if (!_setujuSyarat) {
        _showSetujuDialog();
        return;
      }

      final feedback = FeedbackItem(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        nama: _namaController.text,
        nim: _nimController.text,
        fakultas: _selectedFakultas,
        fasilitas: _fasilitasList,
        nilaiKepuasan: _nilaiKepuasan, // SEKARANG INT
        jenisFeedback: _selectedJenisFeedback,
        setujuSyarat: _setujuSyarat,
        tanggal: DateTime.now(),
      );

      widget.onFeedbackSubmitted(feedback);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Feedback berhasil disimpan!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      Navigator.pop(context);
    }
  }

  void _showSetujuDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Konfirmasi'),
        content: const Text('Anda harus menyetujui syarat dan ketentuan sebelum menyimpan feedback.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void _showFasilitasDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Peringatan'),
        content: const Text('Pilih minimal satu fasilitas yang akan dinilai.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  String? _nimValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'NIM harus diisi';
    }
    if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      return 'NIM harus berupa angka';
    }
    if (value.length < 8) {
      return 'NIM minimal 8 digit';
    }
    return null;
  }

  String? _namaValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Nama mahasiswa harus diisi';
    }
    if (value.length < 2) {
      return 'Nama terlalu pendek';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Form Feedback Mahasiswa'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              // Nama Mahasiswa
              TextFormField(
                controller: _namaController,
                decoration: const InputDecoration(
                  labelText: 'Nama Mahasiswa',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                  hintText: 'Masukkan nama lengkap',
                ),
                validator: _namaValidator,
              ),
              const SizedBox(height: 16),

              // NIM
              TextFormField(
                controller: _nimController,
                decoration: const InputDecoration(
                  labelText: 'NIM',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.numbers),
                  hintText: 'Masukkan NIM',
                ),
                keyboardType: TextInputType.number,
                validator: _nimValidator,
              ),
              const SizedBox(height: 16),

              // Fakultas
              DropdownButtonFormField<String>(
                value: _selectedFakultas,
                decoration: const InputDecoration(
                  labelText: 'Fakultas',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.school),
                ),
                items: _fakultasOptions.map((fakultas) {
                  return DropdownMenuItem(
                    value: fakultas,
                    child: Text(fakultas),
                  );
                }).toList(),
                onChanged: (String? value) {
                  if (value != null) {
                    setState(() {
                      _selectedFakultas = value;
                    });
                  }
                },
              ),
              const SizedBox(height: 16),

              // Fasilitas yang Dinilai
              const Text(
                'Fasilitas yang Dinilai:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              ..._fasilitasOptions.map((fasilitas) {
                return CheckboxListTile(
                  title: Text(fasilitas),
                  value: _fasilitasList.contains(fasilitas),
                  onChanged: (bool? value) {
                    setState(() {
                      if (value != null && value) {
                        _fasilitasList.add(fasilitas);
                      } else {
                        _fasilitasList.remove(fasilitas);
                      }
                    });
                  },
                  contentPadding: EdgeInsets.zero,
                );
              }),
              if (_fasilitasList.isEmpty)
                const Padding(
                  padding: EdgeInsets.only(top: 8.0),
                  child: Text(
                    '* Pilih minimal satu fasilitas',
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                ),
              const SizedBox(height: 16),

              // Nilai Kepuasan - BAGIAN YANG DIUBAH
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Nilai Kepuasan:',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '$_nilaiKepuasan', // UBAH: tanpa .0
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      Slider(
                        value: _nilaiKepuasan.toDouble(), // Konversi ke double untuk slider
                        min: 1,
                        max: 5,
                        divisions: 4,
                        label: '$_nilaiKepuasan', // UBAH: tanpa .0
                        onChanged: (double value) {
                          setState(() {
                            _nilaiKepuasan = value.round(); // Konversi ke int
                          });
                        },
                      ),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('1 (Sangat Buruk)'),
                          Text('5 (Sangat Baik)'),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Jenis Feedback
              const Text(
                'Jenis Feedback:',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              ..._jenisFeedbackOptions.map((jenis) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  child: RadioListTile<String>(
                    title: Text(jenis),
                    value: jenis,
                    groupValue: _selectedJenisFeedback,
                    onChanged: (String? value) {
                      if (value != null) {
                        setState(() {
                          _selectedJenisFeedback = value;
                        });
                      }
                    },
                  ),
                );
              }),
              const SizedBox(height: 16),

              // Setuju Syarat & Ketentuan
              Card(
                child: SwitchListTile(
                  title: const Text(
                    'Saya setuju dengan syarat dan ketentuan',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: !_setujuSyarat
                      ? const Text(
                          '* Harus disetujui untuk melanjutkan',
                          style: TextStyle(color: Colors.red),
                        )
                      : null,
                  value: _setujuSyarat,
                  onChanged: (bool value) {
                    setState(() {
                      _setujuSyarat = value;
                    });
                  },
                ),
              ),
              const SizedBox(height: 24),

              // Tombol Simpan
              ElevatedButton(
                onPressed: _submitForm,
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50),
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Theme.of(context).colorScheme.onPrimary,
                ),
                child: const Text(
                  'Simpan Feedback',
                  style: TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 8),
              
              // Tombol Batal
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Batal'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _namaController.dispose();
    _nimController.dispose();
    super.dispose();
  }
}