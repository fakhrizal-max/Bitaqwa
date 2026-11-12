import 'package:flutter/material.dart';

class DetailDoaScreen extends StatelessWidget {
  final String judul;
  final String doaArab;
  final String arti;
  final String reference;

  const DetailDoaScreen({
    super.key,
    required this.judul,
    required this.doaArab,
    required this.arti,
    required this.reference,
  });

  static const Color peach = Color(0xff167D61);
  static const Color darkBrown = Color(0xff24483B);
  static const Color softPeach = Color(0xffEAF5EF);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_rounded,
            color: Colors.white,
          ),
        ),
        title: Text(
          judul,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(20, 24, 20, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // IKON DOA
                Container(
                  width: 72,
                  height: 72,
                  decoration: BoxDecoration(
                    color: const Color(0xffEAF5EF),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.8),
                      width: 2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff174D39)
                            .withValues(alpha: 0.12),
                        blurRadius: 16,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.auto_awesome_rounded,
                    color: peach,
                    size: 34,
                  ),
                ),

                const SizedBox(height: 24),

                // KARTU ISI DOA
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 22,
                    vertical: 28,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xffFFFFFF)
                        .withValues(alpha: 0.97),
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: const Color(0xffE3EEE8),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff174D39)
                            .withValues(alpha: 0.08),
                        blurRadius: 24,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // LABEL DOA
                      _sectionTitle('Bacaan Doa'),

                      const SizedBox(height: 24),

                      // TEKS ARAB
                      SizedBox(
                        width: double.infinity,
                        child: Text(
                          doaArab,
                          textAlign: TextAlign.center,
                          textDirection: TextDirection.rtl,
                          style: const TextStyle(
                            fontSize: 29,
                            height: 2.1,
                            color: darkBrown,
                          ),
                        ),
                      ),

                      const SizedBox(height: 28),

                      _divider(),

                      const SizedBox(height: 24),

                      // ARTI
                      _sectionTitle('Artinya'),

                      const SizedBox(height: 14),

                      Text(
                        arti,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 15,
                          height: 1.9,
                          color: darkBrown,
                        ),
                      ),

                      const SizedBox(height: 28),

                      _divider(),

                      const SizedBox(height: 24),

                      // REFERENSI
                      _sectionTitle('Referensi'),

                      const SizedBox(height: 14),

                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: softPeach,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(
                            color: const Color(0xffD8EADF),
                          ),
                        ),
                        child: Text(
                          reference,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 13,
                            height: 1.8,
                            color: darkBrown,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 22),

                // PENUTUP
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 18,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withValues(alpha: 0.25),
                    ),
                  ),
                  child: const Text(
                    'Semoga bermanfaat',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 13,
                      fontStyle: FontStyle.italic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Column(
      children: [
        Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: 'PoppinsMedium',
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: peach,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 40,
          height: 3,
          decoration: BoxDecoration(
            color: peach.withValues(alpha: 0.65),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ],
    );
  }

  Widget _divider() {
    return Container(
      height: 1,
      color: peach.withValues(alpha: 0.2),
    );
  }
}
