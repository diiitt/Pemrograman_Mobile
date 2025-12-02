import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Survey Form',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const SurveyForm(),
    );
  }
}

class SurveyForm extends StatefulWidget {
  const SurveyForm({super.key});

  @override
  State<SurveyForm> createState() => _SurveyFormState();
}

class _SurveyFormState extends State<SurveyForm> {
  // State untuk mengelola step
  int _currentStep = 0;
  final PageController _pageController = PageController();

  // Data dari step 1
  String _nama = '';
  String _umur = '';
  String _pekerjaan = '';

  // Data dari step 2
  String _genrePilihan = '';
  final Map<String, bool> _hobi = {
    'Membaca': false,
    'Olahraga': false,
    'Musik': false,
    'Traveling': false,
    'Memasak': false,
  };

  // Data dari step 3
  String _feedback = '';

  // Validasi form
  bool get _isStep1Valid =>
      _nama.isNotEmpty && _umur.isNotEmpty && _pekerjaan.isNotEmpty;

  bool get _isStep2Valid => _genrePilihan.isNotEmpty;

  // List step
  final List<String> _stepTitles = [
    'Data Responden',
    'Pertanyaan Pilihan',
    'Feedback',
    'Ringkasan'
  ];

  // Navigasi ke step berikutnya
  void _nextStep() {
    if (_currentStep < _stepTitles.length - 1) {
      setState(() {
        _currentStep++;
      });
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Kembali ke step sebelumnya
  void _previousStep() {
    if (_currentStep > 0) {
      setState(() {
        _currentStep--;
      });
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  // Reset form
  void _resetForm() {
    setState(() {
      _currentStep = 0;
      _nama = '';
      _umur = '';
      _pekerjaan = '';
      _genrePilihan = '';
      _hobi.forEach((key, value) {
        _hobi[key] = false;
      });
      _feedback = '';
    });
    _pageController.jumpToPage(0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Survey Form'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Progress indicator
          _buildProgressIndicator(),
          
          // Konten form dengan PageView
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                // Step 1: Data responden
                _buildStep1(),
                
                // Step 2: Pertanyaan pilihan
                _buildStep2(),
                
                // Step 3: Feedback
                _buildStep3(),
                
                // Step 4: Ringkasan
                _buildStep4(),
              ],
            ),
          ),
          
          // Navigation buttons
          _buildNavigationButtons(),
        ],
      ),
    );
  }

  // Widget untuk progress indicator
  Widget _buildProgressIndicator() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
      child: Column(
        children: [
          // Step titles
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              _stepTitles.length,
              (index) => Column(
                children: [
                  // Step circle
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: index == _currentStep
                          ? Colors.blue
                          : index < _currentStep
                              ? Colors.green
                              : Colors.grey[300],
                    ),
                    child: Center(
                      child: Text(
                        '${index + 1}',
                        style: TextStyle(
                          color: index <= _currentStep ? Colors.white : Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 4),
                  // Step label
                  SizedBox(
                    width: 70,
                    child: Text(
                      _stepTitles[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: index == _currentStep ? FontWeight.bold : FontWeight.normal,
                        color: index <= _currentStep ? Colors.blue : Colors.grey,
                      ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Progress bar
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: LinearProgressIndicator(
              value: (_currentStep + 1) / _stepTitles.length,
              backgroundColor: Colors.grey[200],
              valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
            ),
          ),
        ],
      ),
    );
  }

  // Step 1: Data responden
  Widget _buildStep1() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Data Responden',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Silakan isi data diri Anda',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          // Nama field
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Nama Lengkap',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.person),
            ),
            onChanged: (value) {
              setState(() {
                _nama = value;
              });
            },
            initialValue: _nama,
          ),
          
          const SizedBox(height: 16),
          
          // Umur field
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Umur',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.calendar_today),
            ),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                _umur = value;
              });
            },
            initialValue: _umur,
          ),
          
          const SizedBox(height: 16),
          
          // Pekerjaan field
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Pekerjaan',
              border: OutlineInputBorder(),
              prefixIcon: Icon(Icons.work),
            ),
            onChanged: (value) {
              setState(() {
                _pekerjaan = value;
              });
            },
            initialValue: _pekerjaan,
          ),
        ],
      ),
    );
  }

  // Step 2: Pertanyaan pilihan
  Widget _buildStep2() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Pertanyaan Pilihan',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Jawab pertanyaan berikut',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          // Pertanyaan 1: Genre favorit (radio buttons)
          const Text(
            '1. Genre film favorit Anda?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          
          // Radio buttons untuk genre
          Column(
            children: [
              _buildRadioOption('Action', 'Action'),
              _buildRadioOption('Comedy', 'Comedy'),
              _buildRadioOption('Drama', 'Drama'),
              _buildRadioOption('Horror', 'Horror'),
              _buildRadioOption('Sci-Fi', 'Sci-Fi'),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Pertanyaan 2: Hobi (checkbox)
          const Text(
            '2. Hobi Anda (bisa pilih lebih dari satu)?',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          
          // Checkbox untuk hobi
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: _hobi.keys.map((key) {
              return FilterChip(
                label: Text(key),
                selected: _hobi[key]!,
                onSelected: (bool selected) {
                  setState(() {
                    _hobi[key] = selected;
                  });
                },
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  // Helper untuk membuat radio option
  Widget _buildRadioOption(String label, String value) {
    return RadioListTile(
      title: Text(label),
      value: value,
      groupValue: _genrePilihan,
      onChanged: (String? value) {
        setState(() {
          _genrePilihan = value ?? '';
        });
      },
      contentPadding: EdgeInsets.zero,
    );
  }

  // Step 3: Feedback
  Widget _buildStep3() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Feedback',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Berikan masukan atau saran Anda',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          // Textarea untuk feedback
          TextField(
            decoration: const InputDecoration(
              labelText: 'Masukan Anda',
              border: OutlineInputBorder(),
              alignLabelWithHint: true,
            ),
            maxLines: 8,
            onChanged: (value) {
              setState(() {
                _feedback = value;
              });
            },
          ),
          
          const SizedBox(height: 16),
          
          // Petunjuk
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue[50],
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Row(
              children: [
                Icon(Icons.info, color: Colors.blue, size: 20),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Feedback Anda sangat berharga untuk kami. Silakan berikan masukan, kritik, atau saran untuk perbaikan ke depannya.',
                    style: TextStyle(fontSize: 14, color: Colors.blue),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Step 4: Ringkasan
  Widget _buildStep4() {
    // Mendapatkan hobi yang dipilih
    final selectedHobi = _hobi.entries
        .where((entry) => entry.value)
        .map((entry) => entry.key)
        .toList();
    
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Ringkasan Survey',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          const Text(
            'Berikut adalah data yang telah Anda isi',
            style: TextStyle(color: Colors.grey),
          ),
          const SizedBox(height: 24),
          
          // Card untuk ringkasan
          Card(
            elevation: 4,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Data responden
                  const Text(
                    'Data Responden:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryItem('Nama', _nama),
                  _buildSummaryItem('Umur', _umur),
                  _buildSummaryItem('Pekerjaan', _pekerjaan),
                  
                  const SizedBox(height: 16),
                  
                  // Pertanyaan pilihan
                  const Text(
                    'Pertanyaan Pilihan:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  _buildSummaryItem('Genre Film Favorit', _genrePilihan),
                  _buildSummaryItem(
                    'Hobi', 
                    selectedHobi.isNotEmpty ? selectedHobi.join(', ') : 'Tidak ada'
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Feedback
                  const Text(
                    'Feedback:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                  ),
                  const SizedBox(height: 8),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      _feedback.isNotEmpty ? _feedback : 'Tidak ada feedback',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Pesan terima kasih
          Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.green[50],
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Column(
                children: [
                  Icon(Icons.check_circle, color: Colors.green, size: 48),
                  SizedBox(height: 12),
                  Text(
                    'Terima Kasih!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Survey Anda telah berhasil disimpan. Kami sangat menghargai waktu dan masukan yang Anda berikan.',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.green),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Helper untuk menampilkan item ringkasan
  Widget _buildSummaryItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 150,
            child: Text(
              '$label:',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              value.isNotEmpty ? value : '-',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }

  // Widget untuk navigation buttons
  Widget _buildNavigationButtons() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(top: BorderSide(color: Colors.grey[300]!)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Tombol kembali
          if (_currentStep > 0)
            ElevatedButton(
              onPressed: _previousStep,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.grey[200],
                foregroundColor: Colors.black,
              ),
              child: const Row(
                children: [
                  Icon(Icons.arrow_back, size: 18),
                  SizedBox(width: 4),
                  Text('Kembali'),
                ],
              ),
            )
          else
            const SizedBox(width: 100),
          
          // Tombol selanjutnya / selesai / reset
          if (_currentStep < _stepTitles.length - 1)
            ElevatedButton(
              onPressed: () {
                if (_currentStep == 0 && !_isStep1Valid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap isi semua data responden'),
                    ),
                  );
                  return;
                }
                
                if (_currentStep == 1 && !_isStep2Valid) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Harap pilih genre film favorit'),
                    ),
                  );
                  return;
                }
                
                _nextStep();
              },
              child: const Row(
                children: [
                  Text('Selanjutnya'),
                  SizedBox(width: 4),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
            )
          else
            ElevatedButton(
              onPressed: _resetForm,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
              ),
              child: const Row(
                children: [
                  Icon(Icons.refresh, size: 18),
                  SizedBox(width: 4),
                  Text('Isi Survey Lagi'),
                ],
              ),
            ),
        ],
      ),
    );
  }
}