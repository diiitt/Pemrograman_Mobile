import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:profil_dosen_app/main.dart';

void main() {
  testWidgets('Aplikasi dapat diluncurkan', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Cek hanya app bar dulu
    expect(find.text('Profil Dosen'), findsOneWidget);
  });

  testWidgets('Menampilkan minimal satu card dosen', (WidgetTester tester) async {
    await tester.pumpWidget(const MyApp());
    
    // Cek apakah ada widget Card (lebih general)
    expect(find.byType(Card), findsWidgets);
  });
}
