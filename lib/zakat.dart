import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ZakatPage extends StatefulWidget {
  const ZakatPage({super.key});

  @override
  State<ZakatPage> createState() => _ZakatPageState();
}

class _ZakatPageState extends State<ZakatPage> {
  final TextEditingController hartaController = TextEditingController();

  static const Color primary = Color(0xff16866B);
  static const Color background = Color(0xffF5F8F6);
  static const Color darkText = Color(0xff183A32);
  static const Color softOrange = Color(0xffE2F3EC);
  static const Color softPurple = Color(0xffE8F0FF);

  // Acuan harga emas per gram.
  // Perbarui jika harga emas berubah.
  final int hargaEmas = 2564000;
  final int nisabGram = 85;

  bool sudahHaul = false;
  bool sudahDihitung = false;

  int totalHarta = 0;
  int zakat = 0;

  int get nisabRupiah => hargaEmas * nisabGram;

  // Format angka dengan titik setiap tiga digit.
  String formatAngka(String angka) {
    final digits = angka.replaceAll(RegExp(r'[^0-9]'), '');

    if (digits.isEmpty) return '';

    return digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );
  }

  String formatRupiah(int angka) {
    return 'Rp ${formatAngka(angka.toString())}';
  }

  void tampilkanPesan(String pesan) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(pesan),
          behavior: SnackBarBehavior.floating,
          backgroundColor: darkText,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
      );
  }

  void hitungZakat() {
    final input = hartaController.text.replaceAll('.', '').trim();

    if (input.isEmpty) {
      tampilkanPesan('Masukkan total harta terlebih dahulu.');
      return;
    }

    final harta = int.tryParse(input);

    if (harta == null || harta <= 0) {
      tampilkanPesan('Total harta harus lebih dari Rp 0.');
      return;
    }

    FocusScope.of(context).unfocus();

    setState(() {
      totalHarta = harta;
      sudahDihitung = true;

      if (totalHarta >= nisabRupiah && sudahHaul) {
        zakat = (totalHarta * 0.025).round();
      } else {
        zakat = 0;
      }
    });
  }

  @override
  void dispose() {
    hartaController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: background,

      // AppBar menggunakan warna primary.
      appBar: AppBar(
        backgroundColor: primary,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Zakat',
          style: TextStyle(
            fontSize: 20,
            letterSpacing: 0.3,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar utama
            ClipRRect(
              borderRadius: BorderRadius.circular(22),
              child: Image.asset(
                'assets/images/zakat_detail.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: softOrange,
                      borderRadius: BorderRadius.circular(22),
                    ),
                    child: const Icon(
                      Icons.volunteer_activism_rounded,
                      color: primary,
                      size: 75,
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Hitung Zakatmu',
              style: TextStyle(
                color: darkText,
                fontSize: 26,
                letterSpacing: -0.4,
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 6),

            const Text(
              'Hitung zakat berdasarkan total harta yang kamu miliki.',
              style: TextStyle(
                color: Colors.black54,
                fontSize: 14,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 20),

            // Informasi nisab
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: softOrange,
                borderRadius: BorderRadius.circular(22),
              ),
              child: Row(
                children: [
                  Container(
                    width: 46,
                    height: 46,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: const Icon(
                      Icons.workspace_premium_rounded,
                      color: primary,
                      size: 27,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Nisab Zakat',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          '$nisabGram gram emas',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.black54,
                          ),
                        ),

                        const SizedBox(height: 3),

                        Text(
                          formatRupiah(nisabRupiah),
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                            color: darkText,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            const Text(
              'Data Zakat',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: darkText,
              ),
            ),

            const SizedBox(height: 12),

            // Input total harta
            _buildHartaInput(),

            const SizedBox(height: 16),

            // Pilihan haul
            _buildHaulCard(),

            const SizedBox(height: 20),

            // Tombol hitung
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton.icon(
                onPressed: hitungZakat,
                icon: const Icon(Icons.calculate_rounded),
                label: const Text(
                  'Hitung Zakat',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  foregroundColor: Colors.white,
                  elevation: 2,
                  shadowColor: primary.withValues(alpha: 0.22),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18),
                  ),
                ),
              ),
            ),

            // Hasil muncul setelah tombol ditekan.
            if (sudahDihitung) ...[
              const SizedBox(height: 28),

              const Text(
                'Hasil Perhitungan',
                style: TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.bold,
                  color: darkText,
                ),
              ),

              const SizedBox(height: 12),

              // Total harta
              _buildHasilCard(
                judul: 'Total Harta',
                nilai: formatRupiah(totalHarta),
                icon: Icons.account_balance_wallet_rounded,
                warna: softPurple,
                iconColor: const Color(0xff5878B9),
              ),

              const SizedBox(height: 12),

              // Zakat yang harus dibayar
              _buildHasilCard(
                judul: 'Zakat 2,5%',
                nilai: formatRupiah(zakat),
                icon: Icons.volunteer_activism_rounded,
                warna: softOrange,
                iconColor: primary,
              ),

              const SizedBox(height: 14),

              // Status wajib atau belum wajib zakat
              _buildStatusZakat(),
            ],
          ],
        ),
      ),
    );
  }

  // Widget input total harta.
  Widget _buildHartaInput() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: const Color(0xffD8E9E1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: softOrange,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.payments_rounded,
                  color: primary,
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Harta',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Masukkan jumlah hartamu',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          TextField(
            controller: hartaController,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              _RupiahInputFormatter(),
            ],
            onChanged: (_) {
              if (sudahDihitung) {
                setState(() {
                  sudahDihitung = false;
                });
              }
            },
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: darkText,
            ),
            decoration: InputDecoration(
              prefixText: 'Rp ',
              prefixStyle: const TextStyle(
                color: darkText,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              hintText: '0',
              hintStyle: const TextStyle(
                color: Colors.black26,
              ),
              filled: true,
              fillColor: const Color(0xffF7FAF8),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 14,
                vertical: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: Color(0xffD8E9E1),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16),
                borderSide: const BorderSide(
                  color: primary,
                  width: 1.5,
                ),
              ),
            ),
          ),

          const SizedBox(height: 8),

          const Text(
            'Contoh: 100000000 akan menjadi 100.000.000',
            style: TextStyle(
              color: Colors.black45,
              fontSize: 11,
            ),
          ),
        ],
      ),
    );
  }

  // Widget pilihan haul.
  Widget _buildHaulCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(22),
        border: Border.all(
          color: sudahHaul
              ? primary
              : const Color(0xffffe3d6),
          width: sudahHaul ? 1.5 : 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: softPurple,
                  borderRadius: BorderRadius.circular(13),
                ),
                child: const Icon(
                  Icons.calendar_month_rounded,
                  color: Color(0xff8870c9),
                ),
              ),

              const SizedBox(width: 12),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Masa Haul',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: darkText,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      'Kepemilikan selama 1 tahun Hijriah',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          const Divider(color: Color(0xffD8E9E1)),

          CheckboxListTile(
            contentPadding: EdgeInsets.zero,
            controlAffinity: ListTileControlAffinity.leading,
            activeColor: primary,
            title: Text(
              'Harta sudah dimiliki selama 1 tahun Hijriah',
              style: TextStyle(
                color: darkText,
                fontSize: 13,
                fontWeight: sudahHaul
                    ? FontWeight.bold
                    : FontWeight.normal,
              ),
            ),
            value: sudahHaul,
            onChanged: (value) {
              setState(() {
                sudahHaul = value ?? false;
                sudahDihitung = false;
              });
            },
          ),
        ],
      ),
    );
  }

  // Widget hasil perhitungan.
  Widget _buildHasilCard({
    required String judul,
    required String nilai,
    required IconData icon,
    required Color warna,
    required Color iconColor,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: warna,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.8),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 26,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 13,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  nilai,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Status wajib atau belum wajib zakat.
  Widget _buildStatusZakat() {
    final bool cukupNisab = totalHarta >= nisabRupiah;

    final Color statusColor;
    final Color statusBackground;
    final IconData statusIcon;
    final String judul;
    final String deskripsi;

    if (!cukupNisab) {
      statusColor = const Color(0xffb77928);
      statusBackground = const Color(0xffFFF3D9);
      statusIcon = Icons.info_outline_rounded;
      judul = 'Belum Wajib Zakat';
      deskripsi =
          'Total hartamu belum mencapai nisab ${formatRupiah(nisabRupiah)}.';
    } else if (!sudahHaul) {
      statusColor = const Color(0xff5878B9);
      statusBackground = softPurple;
      statusIcon = Icons.hourglass_top_rounded;
      judul = 'Belum Wajib Zakat';
      deskripsi =
          'Harta sudah mencapai nisab, tetapi masa haul satu tahun Hijriah belum terpenuhi.';
    } else {
      statusColor = const Color(0xff16866B);
      statusBackground = const Color(0xffE2F3EC);
      statusIcon = Icons.check_circle_outline_rounded;
      judul = 'Wajib Zakat';
      deskripsi =
          'Harta mencapai nisab dan haul. Zakat yang dihitung adalah 2,5% dari total harta.';
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: statusBackground,
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            statusIcon,
            color: statusColor,
            size: 30,
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  judul,
                  style: TextStyle(
                    color: statusColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 17,
                  ),
                ),

                const SizedBox(height: 6),

                Text(
                  deskripsi,
                  style: const TextStyle(
                    color: darkText,
                    fontSize: 13,
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Formatter input angka tanpa package intl.
class _RupiahInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final digits = newValue.text.replaceAll(
      RegExp(r'[^0-9]'),
      '',
    );

    if (digits.isEmpty) {
      return const TextEditingValue(
        text: '',
        selection: TextSelection.collapsed(offset: 0),
      );
    }

    final formatted = digits.replaceAllMapped(
      RegExp(r'\B(?=(\d{3})+(?!\d))'),
      (match) => '.',
    );

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(
        offset: formatted.length,
      ),
    );
  }
}