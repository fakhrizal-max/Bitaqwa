
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:bitaqwa/enum/kategori_doa_enum.dart';
import 'package:bitaqwa/data/kategori_doa_ext.dart';
import 'package:bitaqwa/presentation/screen/doa_list_screen.dart';

class DoaDoaPage extends StatefulWidget {
  const DoaDoaPage({super.key});

  @override
  State<DoaDoaPage> createState() => _DoaDoaPageState();
}

class _DoaDoaPageState extends State<DoaDoaPage> {
  Timer? _timer;
  DateTime _sekarang = DateTime.now();

  @override
  void initState() {
    super.initState();

    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        setState(() {
          _sekarang = DateTime.now();
        });
      },
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffaf5fb),
      appBar: AppBar(
        backgroundColor: const Color(0xfff17860),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).maybePop();
          },
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'Doa-doa',
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: _buildCategoryGrid(),
          ),
        ],
      ),
    );
  }

  // GAMBAR ATAS DAN JAM REAL-TIME
  Widget _buildHeader() {
    final jam = _sekarang.hour.toString().padLeft(2, '0');
    final menit = _sekarang.minute.toString().padLeft(2, '0');
    final detik = _sekarang.second.toString().padLeft(2, '0');

    return SizedBox(
      width: double.infinity,
      height: 158,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'assets/images/siang.png',
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                color: const Color(0xffbdeaff),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: Text(
                '$jam:$menit:$detik',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      color: Colors.black54,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // MENU 6 KATEGORI
  Widget _buildCategoryGrid() {
    final categories = [
      DoaCategory.etikaBaik,
      DoaCategory.sholat,
      DoaCategory.perjalanan,
      DoaCategory.makananMinuman,
      DoaCategory.pagiMalam,
      DoaCategory.rumah,
    ];

    return GridView.builder(
      padding: const EdgeInsets.all(6),
      itemCount: categories.length,
      gridDelegate:
          const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
        childAspectRatio: 0.85,
      ),
      itemBuilder: (context, index) {
        final category = categories[index];

        return Material(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {
              debugPrint(
                'Kategori ditekan: ${category.title}',
              );

              Navigator.of(context).push(
                MaterialPageRoute<void>(
                  builder: (context) => DoaListScreen(
                    category: category,
                  ),
                ),
              );
            },
            child: SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.all(6),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Center(
                        child: Image.asset(
                          category.image,
                          fit: BoxFit.contain,
                          errorBuilder: (
                            context,
                            error,
                            stackTrace,
                          ) {
                            return const Icon(
                              Icons.image_not_supported,
                              size: 40,
                              color: Colors.grey,
                            );
                          },
                        ),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      category.title,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'PoppinsMedium',
                        fontSize: 9,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
