import 'package:flutter/material.dart';
import 'dashbord.dart';
import 'doa_doa.dart';
import 'zakat.dart';
import 'jadwal_sholat.dart';
import 'video_kajian.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      // home: const ScreenDashboard(),
      routes: {
        "/": (context) => const ScreenDashboard(),
        "/doa-doa": (context) => const DoaDoaPage(),
        "/zakat": (context) => const ZakatPage(),
        "/jadwal-sholat": (context) => const JadwalSholatPage(),
        "/video-kajian": (context) => const VideoKajianPage(),
      },
    );
  }
}