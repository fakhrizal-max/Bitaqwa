import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class JadwalSholatPage extends StatefulWidget {
  const JadwalSholatPage({super.key});

  @override
  State<JadwalSholatPage> createState() => _JadwalSholatPageState();
}

class _JadwalSholatPageState extends State<JadwalSholatPage> {
  static const Color peach = Color(0xff167D61);
  static const Color peachDark = Color(0xff105E49);
  static const Color pageBg = Color(0xffF3F8F5);
  static const Color ink = Color(0xff24483B);
  static const Color muted = Color(0xff788B82);

  bool loading = true;

  String lokasi = 'Mendeteksi lokasi...';
  String tanggalAPI = '';

  Map<String, String> jadwal = {};

  DateTime sekarang = DateTime.now();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) {
        if (!mounted) return;

        setState(() {
          sekarang = DateTime.now();
        });
      },
    );

    ambilLokasiDanJadwal();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  // Tanggal menggunakan bahasa Indonesia.
  String get hariTanggal {
    const hari = [
      'Senin',
      'Selasa',
      'Rabu',
      'Kamis',
      'Jumat',
      'Sabtu',
      'Minggu',
    ];

    const bulan = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];

    return '${hari[sekarang.weekday - 1]}, '
        '${sekarang.day} ${bulan[sekarang.month - 1]} '
        '${sekarang.year}';
  }

  String get jamSekarang {
    final jam = sekarang.hour.toString().padLeft(2, '0');
    final menit = sekarang.minute.toString().padLeft(2, '0');

    return '$jam:$menit';
  }

  // Mengambil lokasi GPS dan jadwal sholat.
  Future<void> ambilLokasiDanJadwal() async {
    if (!mounted) return;

    setState(() {
      loading = true;
      lokasi = 'Mendeteksi lokasi...';
    });

    try {
      final gpsAktif =
          await Geolocator.isLocationServiceEnabled();

      if (!gpsAktif) {
        if (!mounted) return;

        setState(() {
          lokasi = 'GPS tidak aktif';
          loading = false;
        });
        return;
      }

      var izin = await Geolocator.checkPermission();

      if (izin == LocationPermission.denied) {
        izin = await Geolocator.requestPermission();
      }

      if (izin == LocationPermission.denied ||
          izin == LocationPermission.deniedForever) {
        if (!mounted) return;

        setState(() {
          lokasi = 'Izin lokasi belum diberikan';
          loading = false;
        });
        return;
      }

      final posisi = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
        ),
      );

      // Ambil nama desa, kecamatan, kabupaten, dan provinsi.
      await ambilNamaLokasi(
        posisi.latitude,
        posisi.longitude,
      );

      // Ambil jadwal berdasarkan koordinat GPS.
      await ambilJadwalDariKoordinat(
        posisi.latitude,
        posisi.longitude,
      );
    } catch (_) {
      if (!mounted) return;

      setState(() {
        lokasi = 'Lokasi tidak tersedia';
        loading = false;
      });
    }
  }

  // Mengambil nama wilayah dari koordinat GPS.
  Future<void> ambilNamaLokasi(
    double latitude,
    double longitude,
  ) async {
    try {
      final uri = Uri.https(
        'nominatim.openstreetmap.org',
        '/reverse',
        {
          'format': 'jsonv2',
          'lat': latitude.toString(),
          'lon': longitude.toString(),
          'zoom': '18',
          'addressdetails': '1',
          'accept-language': 'id',
        },
      );

      final response = await http.get(
        uri,
        headers: {
          'User-Agent': 'BitaqwaApp/1.0',
        },
      ).timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Gagal mendapatkan alamat');
      }

      final data =
          jsonDecode(response.body) as Map<String, dynamic>;

      final address =
          data['address'] as Map<String, dynamic>?;

      if (address == null) {
        throw Exception('Data alamat kosong');
      }

      // DESA / KELURAHAN
      final desa = _ambilNilai(address, [
        'village',
        'hamlet',
        'quarter',
        'neighbourhood',
        'suburb',
        'residential',
      ]);

      // KECAMATAN
      final kecamatan = _ambilNilai(address, [
        'city_district',
        'district',
        'borough',
      ]);

      // KABUPATEN / KOTA
      final kabupatenKota = _ambilNilai(address, [
        'city',
        'town',
        'county',
        'municipality',
      ]);

      // PROVINSI
      final provinsi = _ambilNilai(address, [
        'state',
      ]);

      // Hindari mengulang nama wilayah yang sama.
      final bagian = <String>[];

      void tambah(String? nama) {
        if (nama == null || nama.trim().isEmpty) return;

        final sudahAda = bagian.any(
          (item) => item.toLowerCase() == nama.toLowerCase(),
        );

        if (!sudahAda) {
          bagian.add(nama);
        }
      }

      if (desa != null) {
        tambah(desa);
      }

      if (kecamatan != null) {
        tambah(
          kecamatan.toLowerCase().startsWith('kec.')
              ? kecamatan
              : 'Kec. $kecamatan',
        );
      }

      tambah(kabupatenKota);
      tambah(provinsi);

      final hasil = bagian.isEmpty
          ? 'Lokasi Anda'
          : bagian.join(', ');

      if (!mounted) return;

      setState(() {
        lokasi = hasil;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        lokasi = 'Lokasi Anda';
      });
    }
  }

  // Mencari nilai pertama yang tersedia dari beberapa nama field.
  String? _ambilNilai(
    Map<String, dynamic> address,
    List<String> keys,
  ) {
    for (final key in keys) {
      final value = address[key];

      if (value != null && value.toString().trim().isNotEmpty) {
        return value.toString().trim();
      }
    }

    return null;
  }

  // Jadwal sholat dari API Aladhan.
  Future<void> ambilJadwalDariKoordinat(
    double latitude,
    double longitude,
  ) async {
    try {
      final uri = Uri.https(
        'api.aladhan.com',
        '/v1/timings',
        {
          'latitude': latitude.toString(),
          'longitude': longitude.toString(),
          'method': '20',
        },
      );

      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 15));

      if (response.statusCode != 200) {
        throw Exception('Gagal mengambil jadwal');
      }

      final data =
          jsonDecode(response.body) as Map<String, dynamic>;

      if (data['code'] != 200 || data['data'] == null) {
        throw Exception('Data jadwal tidak tersedia');
      }

      final timings =
          data['data']['timings'] as Map<String, dynamic>;

      final readableDate =
          data['data']['date']['readable'].toString();

      if (!mounted) return;

      setState(() {
        tanggalAPI = readableDate;

        jadwal = {
          'Subuh': _formatJam(timings['Fajr']),
          'Dzuhur': _formatJam(timings['Dhuhr']),
          'Ashar': _formatJam(timings['Asr']),
          'Maghrib': _formatJam(timings['Maghrib']),
          'Isya': _formatJam(timings['Isha']),
        };

        loading = false;
      });
    } catch (_) {
      if (!mounted) return;

      setState(() {
        jadwal = {};
        loading = false;
      });
    }
  }

  String _formatJam(dynamic value) {
    final teks = value.toString();
    return teks.length >= 5 ? teks.substring(0, 5) : teks;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: pageBg,
      appBar: AppBar(
        backgroundColor: const Color(0xff167D61),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
        ),
        title: const Text(
          'Jadwal Sholat',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            letterSpacing: 0.2,
          ),
        ),
      ),
      body: RefreshIndicator(
        color: peachDark,
        onRefresh: ambilLokasiDanJadwal,
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // HEADER LANGIT
              SizedBox(
                height: 290,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/langit_jdwl.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          color: const Color(0xff698795),
                          alignment: Alignment.center,
                          child: const Icon(
                            Icons.cloud_rounded,
                            color: Colors.white,
                            size: 65,
                          ),
                        );
                      },
                    ),

                    // Lapisan agar teks terbaca.
                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.05),
                            const Color(0xff254454)
                              .withValues(alpha: 0.65),
                          ],
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(
                        20,
                        24,
                        20,
                        22,
                      ),
                      child: Column(
                        children: [
                          Text(
                            hariTanggal,
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.w800,
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 7,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            'Waktu Sekarang',
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                            ),
                          ),

                          const SizedBox(height: 2),

                          Text(
                            jamSekarang,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 43,
                              fontWeight: FontWeight.w900,
                              letterSpacing: 1,
                              fontFeatures: [
                                FontFeature.tabularFigures(),
                              ],
                              shadows: [
                                Shadow(
                                  color: Colors.black26,
                                  blurRadius: 8,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 10),

                          // Lokasi langsung menyatu dengan langit.
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment:
                                CrossAxisAlignment.start,
                            children: [
                              const Padding(
                                padding: EdgeInsets.only(top: 2),
                                child: Icon(
                                  Icons.location_on_rounded,
                                  color: Color(0xffffc29f),
                                  size: 17,
                                ),
                              ),
                              const SizedBox(width: 5),
                              Flexible(
                                child: Text(
                                  lokasi,
                                  textAlign: TextAlign.center,
                                  maxLines: 3,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    height: 1.5,
                                    fontWeight: FontWeight.w600,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black26,
                                        blurRadius: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),

              // KARTU JADWAL
              Transform.translate(
                offset: const Offset(0, -18),
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 18,
                  ),
                  padding: const EdgeInsets.fromLTRB(
                    17,
                    19,
                    17,
                    14,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    border: Border.all(
                      color: const Color(0xffE3EEE8),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xff38566d)
                          .withValues(alpha: 0.09),
                        blurRadius: 22,
                        offset: const Offset(0, 7),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(
                          left: 3,
                          bottom: 9,
                        ),
                        child: Text(
                          'Waktu Sholat Hari Ini',
                          style: TextStyle(
                            color: ink,
                            fontSize: 19,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),

                      if (loading)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 35,
                          ),
                          child: Center(
                            child: CircularProgressIndicator(
                              color: peach,
                            ),
                          ),
                        )
                      else if (jadwal.isEmpty)
                        const Padding(
                          padding: EdgeInsets.symmetric(
                            vertical: 25,
                          ),
                          child: Center(
                            child: Text(
                              'Jadwal belum tersedia.\n'
                              'Periksa GPS dan koneksi internet.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: muted,
                                height: 1.6,
                              ),
                            ),
                          ),
                        )
                      else
                        ...jadwal.entries.map(
                          (entry) => _jadwalCard(
                            nama: entry.key,
                            waktu: entry.value,
                            terakhir:
                                entry.key == jadwal.keys.last,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              // PENGINGAT
              Padding(
                padding: const EdgeInsets.fromLTRB(
                  22,
                  0,
                  22,
                  30,
                ),
                child: Column(
                  children: [
                    const Icon(
                      Icons.mosque_rounded,
                      size: 29,
                      color: Color(0xffad765f),
                    ),
                    const SizedBox(height: 9),
                    const Text(
                      'Jangan tinggalkan sholat,',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff795548),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const Text(
                      'sesibuk apa pun harimu.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xff795548),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Container(
                      width: 60,
                      height: 3,
                      decoration: BoxDecoration(
                        color: const Color(0xff9CCDB8),
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    if (tanggalAPI.isNotEmpty) ...[
                      const SizedBox(height: 12),
                      Text(
                        'Data tanggal API: $tanggalAPI',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: muted,
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Kartu untuk setiap waktu sholat.
  Widget _jadwalCard({
    required String nama,
    required String waktu,
    required bool terakhir,
  }) {
    final IconData ikon;
    final Color warna;
    final Color latar;
    final String keterangan;

    switch (nama) {
      case 'Subuh':
        ikon = Icons.nightlight_round;
        warna = const Color(0xff579ed2);
        latar = const Color(0xffe7f2ff);
        keterangan = 'Awal pagi';
        break;

      case 'Dzuhur':
        ikon = Icons.wb_sunny_rounded;
        warna = const Color(0xffe9a32d);
        latar = const Color(0xfffff1d9);
        keterangan = 'Tengah hari';
        break;

      case 'Ashar':
        ikon = Icons.wb_twilight_rounded;
        warna = const Color(0xffed8b52);
        latar = const Color(0xffffe9de);
        keterangan = 'Sore hari';
        break;

      case 'Maghrib':
        ikon = Icons.brightness_3_rounded;
        warna = const Color(0xff9c77c1);
        latar = const Color(0xfff1e7fa);
        keterangan = 'Matahari terbenam';
        break;

      default:
        ikon = Icons.nights_stay_rounded;
        warna = const Color(0xff496b91);
        latar = const Color(0xffe6edf6);
        keterangan = 'Malam hari';
    }

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 10,
            horizontal: 2,
          ),
          child: Row(
            children: [
              Container(
                width: 43,
                height: 43,
                decoration: BoxDecoration(
                  color: latar,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Icon(
                  ikon,
                  color: warna,
                  size: 24,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      nama,
                      style: const TextStyle(
                        color: ink,
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      keterangan,
                      style: const TextStyle(
                        color: muted,
                        fontSize: 11,
                      ),
                    ),
                  ],
                ),
              ),

              Text(
                waktu,
                style: TextStyle(
                  color: warna,
                  fontSize: 18,
                  fontWeight: FontWeight.w800,
                  fontFeatures: const [
                    FontFeature.tabularFigures(),
                  ],
                ),
              ),

              const SizedBox(width: 9),

              Icon(
                Icons.access_alarm_rounded,
                color: warna.withValues(alpha: 0.8),
                size: 22,
              ),
            ],
          ),
        ),

        if (!terakhir)
          const Divider(
            color: Color(0xffb8e1d7),
            height: 1,
            indent: 55,
          ),
      ],
    );
  }
}