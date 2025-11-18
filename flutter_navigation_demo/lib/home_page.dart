import 'package:flutter/material.dart';
import 'about_page.dart';
import 'feedback_form_page.dart';
import 'feedback_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const HomeContent(),
    const FeedbackFormPage(),
    const AboutPage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Navigation Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.feedback),
            label: 'Feedback',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.info),
            label: 'About',
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Halaman Utama',
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
                    'Demo Navigasi Flutter',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 10),
                  const Text('Pilih aksi di bawah untuk mencoba navigasi:'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          
          // Tombol untuk navigasi
          FilledButton(
            onPressed: () {
              // Mengirim data ke halaman lain
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const FeedbackDetailPage(
                    data: 'Data dari Home Page: Selamat belajar Flutter!',
                  ),
                ),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.arrow_forward),
                SizedBox(width: 8),
                Text('Lihat Detail dengan Data'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          FilledButton.tonal(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const AboutPage(),
                ),
              );
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.info),
                SizedBox(width: 8),
                Text('Pergi ke About Page'),
              ],
            ),
          ),
          const SizedBox(height: 12),
          
          OutlinedButton(
            onPressed: () async {
              // Menerima data dari halaman lain
              final result = await Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const InputDataPage(),
                ),
              );
              
              if (result != null) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Data diterima: $result'),
                    backgroundColor: Theme.of(context).colorScheme.primary,
                  ),
                );
              }
            },
            child: const Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.input),
                SizedBox(width: 8),
                Text('Input Data & Kembali'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class InputDataPage extends StatefulWidget {
  const InputDataPage({super.key});

  @override
  State<InputDataPage> createState() => _InputDataPageState();
}

class _InputDataPageState extends State<InputDataPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Input Data'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Masukkan Data',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Ketik data di sini',
                border: OutlineInputBorder(),
                hintText: 'Contoh: Hello Flutter!',
              ),
            ),
            const SizedBox(height: 20),
            const Text('Data ini akan dikirim kembali ke halaman sebelumnya'),
            const Spacer(),
            FilledButton(
              onPressed: () {
                if (_controller.text.isNotEmpty) {
                  Navigator.pop(context, _controller.text);
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Silakan masukkan data terlebih dahulu'),
                    ),
                  );
                }
              },
              child: const Text('Kirim Data & Kembali'),
            ),
          ],
        ),
      ),
    );
  }
}