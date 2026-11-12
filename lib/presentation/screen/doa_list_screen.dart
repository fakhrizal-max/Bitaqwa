import 'package:flutter/material.dart';
import 'package:bitaqwa/enum/kategori_doa_enum.dart';
import 'package:bitaqwa/data/kategori_doa_ext.dart';
import 'package:bitaqwa/data/doa_data.dart';
import 'package:bitaqwa/presentation/screen/detail_doa_screen.dart';

class DoaListScreen extends StatelessWidget {
  final DoaCategory category;

  const DoaListScreen({
    super.key,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    final doaList = doaData[category] ?? [];

    return Scaffold(
      backgroundColor: const Color(0xffF5F8F5),

      // APP BAR
      appBar: AppBar(
        backgroundColor: const Color(0xff167D61),
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          category.title,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 0.3,
          ),
        ),
      ),

      // DAFTAR DOA
      body: ListView.builder(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        itemCount: doaList.length,
        itemBuilder: (context, index) {
          final doa = doaList[index];

          return Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 7,
            ),
            child: InkWell(
              borderRadius: BorderRadius.circular(18),

              // BUKA DETAIL DOA
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailDoaScreen(
                      judul: doa.title,
                      doaArab: doa.arabicText,
                      arti: doa.translation,
                      reference: doa.reference,
                    ),
                  ),
                );
              },

              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  border: Border.all(
                    color: const Color(0xffE3EEE8),
                    width: 1,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xff174D39)
                          .withValues(alpha: 0.05),
                      blurRadius: 12,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // GAMBAR DOA SESUAI DATA
                    Container(
                      width: 58,
                      height: 58,
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xffEAF5EF),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Image.asset(
                        doa.image,
                        width: 42,
                        height: 42,
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(width: 14),

                    // JUDUL DOA
                    Expanded(
                      child: Text(
                        doa.title,
                        style: const TextStyle(
                          fontFamily: 'PoppinsMedium',
                          fontSize: 13,
                          height: 1.5,
                          fontWeight: FontWeight.w600,
                          color: Color(0xff24483B),
                        ),
                      ),
                    ),

                    const SizedBox(width: 8),

                    // ICON PANAH
                    Container(
                      width: 30,
                      height: 30,
                      decoration: BoxDecoration(
                        color: const Color(0xffEAF5EF),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Icons.chevron_right_rounded,
                        color: Color(0xff167D61),
                        size: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}