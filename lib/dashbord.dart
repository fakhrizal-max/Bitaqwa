import 'dart:async';
import 'package:flutter/material.dart';

class ScreenDashboard extends StatefulWidget {
  const ScreenDashboard({super.key});

  @override
  State<ScreenDashboard> createState() => _ScreenDashboardState();
}

class _ScreenDashboardState extends State<ScreenDashboard> {
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (timer) {
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // =====================================================
  // WIDGET UTAMA
  // =====================================================

  Widget dashboardWidget() {
    return Scaffold(
      backgroundColor: const Color(0xfff5f5f5),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [

              topWidget(),

              menuWidget(),

              inspirationWidget(),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  // =====================================================
  // WIDGET TOP
  // =====================================================

  Widget topWidget() {
    return SizedBox(
      width: double.infinity,
      height: 200,

      child: Stack(
        children: [

          Positioned.fill(
            child: Image.asset(
              getBackground(),
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            left: 0,
            right: 0,
            bottom: 20,

            child: Column(
              children: [

                Text(
                  getGreeting(),
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 5),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 5,
                  ),

                  decoration: BoxDecoration(
                    color: Colors.white.withValues(
                      alpha: 0.85,
                    ),
                    borderRadius: BorderRadius.circular(5),
                  ),

                  child: const Text(
                    "Assalamualaikum",
                    style: TextStyle(
                      fontSize: 9,
                      color: Colors.grey,
                    ),
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  getTime(),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    shadows: [
                      Shadow(
                        color: Colors.black54,
                        blurRadius: 4,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // =====================================================
  // WIDGET MENU
  // =====================================================

  Widget menuWidget() {
    return Container(
      width: double.infinity,

      margin: const EdgeInsets.symmetric(
        horizontal: 15,
        vertical: 10,
      ),

      padding: const EdgeInsets.only(
        top: 15,
        bottom: 15,
        left: 8,
        right: 8,
      ),

      decoration: BoxDecoration(
        color: const Color(0xffef765d),
        borderRadius: BorderRadius.circular(25),
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: [

          menuItem(
            image: "assets/images/doa-doa.jpeg",
            title: "Doa-doa",
            onTap: () {
              Navigator.pushNamed(context, "/doa-doa");
            },
          ),

          menuItem(
            image: "assets/images/zakat.jpeg",
            title: "Zakat",
            onTap: () {
              Navigator.pushNamed(context, "/zakat");
            },
          ),

          menuItem(
            image: "assets/images/jadwal_sholat.jpeg",
            title: "Jadwal Sholat",
            onTap: () {
              Navigator.pushNamed(context, "/jadwal-sholat");
            },
          ),

          menuItem(
            image: "assets/images/video_kajian.jpeg",
            title: "Video Kajian",
            onTap: () {
              Navigator.pushNamed(context, "/video-kajian");
            },
          ),
        ],
      ),
    );
  }

  // =====================================================
  // WIDGET INSPIRATION
  // =====================================================

  Widget inspirationWidget() {
    return Column(
      children: [

        Container(
          width: double.infinity,

          padding: const EdgeInsets.only(
            left: 12,
            right: 12,
            top: 12,
          ),

          child: const Text(
            "Inspirasi",
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
        ),

        const SizedBox(height: 5),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),

            child: Image.asset(
              "assets/images/tahajud.jpeg",
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),

        const SizedBox(height: 10),

        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
          ),

          child: ClipRRect(
            borderRadius: BorderRadius.circular(2),

            child: Image.asset(
              "assets/images/tahajud.jpeg",
              width: double.infinity,
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
      ],
    );
  }

  // =====================================================
  // WIDGET ITEM MENU
  // =====================================================

  Widget menuItem({
    required String image,
    required String title,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,

      child: SizedBox(
        width: 72,

        child: Column(
          children: [

            SizedBox(
              width: 55,
              height: 55,

              child: Image.asset(
                image,
                fit: BoxFit.contain,
              ),
            ),

            const SizedBox(height: 3),

            Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,

              style: const TextStyle(
                color: Colors.white,
                fontSize: 8,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // =====================================================
  // FUNGSI BACKGROUND
  // =====================================================

  String getBackground() {
    int jam = DateTime.now().hour;

    if (jam >= 5 && jam < 15) {
      return "assets/images/siang.jpeg";
    } else if (jam >= 15 && jam < 18) {
      return "assets/images/sore.jpeg";
    } else {
      return "assets/images/malam.jpeg";
    }
  }

  // =====================================================
  // FUNGSI GREETING
  // =====================================================

  String getGreeting() {
    int jam = DateTime.now().hour;

    if (jam >= 5 && jam < 11) {
      return "Selamat Pagi";
    } else if (jam >= 11 && jam < 15) {
      return "Selamat Siang";
    } else if (jam >= 15 && jam < 18) {
      return "Selamat Sore";
    } else {
      return "Selamat Malam";
    }
  }

  // =====================================================
  // FUNGSI JAM
  // =====================================================

  String getTime() {
    DateTime sekarang = DateTime.now();

    String jam = sekarang.hour.toString().padLeft(2, '0');
    String menit = sekarang.minute.toString().padLeft(2, '0');
    String detik = sekarang.second.toString().padLeft(2, '0');

    return "$jam:$menit:$detik";
  }

  // =====================================================
  // BUILD
  // =====================================================

  @override
  Widget build(BuildContext context) {
    return dashboardWidget();
  }
}