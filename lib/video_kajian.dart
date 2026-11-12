import 'package:flutter/material.dart';
import 'detail_video_kajian.dart';

const Color warnaKajian = Color(0xFF167D61);
const Color latarKajian = Color(0xFFF3F8F5);

class VideoKajianPage extends StatelessWidget {
  const VideoKajianPage({super.key});

  static const List<Map<String, String>> videos = [
    {
      'id': 'nFr1Jj1KxVk',
      'judul': 'Tujuan Hidup',
      'channel': 'Kajian Singkat',
      'pembicara': 'Ustadz',
      'deskripsi':
          'Hidup bukan sekadar mengejar kesenangan dunia. '
          'Kajian ini mengajak kita merenungkan tujuan hidup, '
          'mengingat bahwa kita diciptakan untuk beribadah kepada '
          'Allah, serta menggunakan waktu untuk melakukan kebaikan.',
    },
    {
      'id': 'AuWmxjV09WY',
      'judul': 'Mengingat Kematian',
      'channel': 'Yufid.TV',
      'pembicara': 'Pemateri dalam video',
      'deskripsi':
          'Mengingat kematian membantu kita menyadari bahwa '
          'kehidupan di dunia tidak berlangsung selamanya. '
          'Jadikan pengingat ini sebagai motivasi untuk memperbaiki '
          'amal, bertaubat, dan mempersiapkan bekal untuk akhirat.',
    },
    {
      'id': 'sX-kePnlgy4',
      'judul': 'Perbaiki Shalatmu',
      'channel': 'Hidayat Official',
      'pembicara': 'Pemateri dalam video',
      'deskripsi':
          'Shalat merupakan ibadah penting dalam kehidupan seorang '
          'Muslim. Kajian ini mengingatkan kita untuk memperbaiki '
          'shalat, menjaga waktunya, dan berusaha menjalankannya '
          'dengan lebih khusyuk serta sungguh-sungguh.',
    },
    {
      'id': '7lYw7cQAleg',
      'judul': 'Takdirmu Adalah Apa yang Kamu Pikirkan',
      'channel': 'Khalid Basalamah Official',
      'pembicara': 'Ustadz Khalid Basalamah',
      'deskripsi':
          'Kajian ini mengajak kita untuk memperhatikan cara '
          'berpikir dan sikap dalam menghadapi kehidupan. '
          'Tetaplah berprasangka baik kepada Allah, berusaha '
          'melakukan hal yang benar, berdoa, dan bertawakal '
          'kepada-Nya dalam menghadapi ketentuan hidup.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latarKajian,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(8, 8, 18, 16),
              decoration: const BoxDecoration(
                color: warnaKajian,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.maybePop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  const Expanded(
                    child: Text(
                      'Video Kajian',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 21,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // BANNER
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 18, 16, 20),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFDDF2E8),
                      Color(0xFFF5FBF7),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: const Color(0xFFCDE7DA),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF167D61).withValues(alpha: 0.06),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      radius: 26,
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.play_circle_fill_rounded,
                        size: 37,
                        color: warnaKajian,
                      ),
                    ),
                    SizedBox(width: 13),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Luangkan Waktu untuk Belajar',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF24483B),
                            ),
                          ),
                          SizedBox(height: 5),
                          Text(
                            'Tambah ilmu, perbaiki diri, '
                            'dan ambil hikmah dari setiap kajian.',
                            style: TextStyle(
                              fontSize: 12,
                              height: 1.5,
                              color: Color(0xFF71877C),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // JUDUL LIST
            Padding(
              padding: const EdgeInsets.fromLTRB(19, 0, 19, 13),
              child: Row(
                children: [
                  const Text(
                    'Pilihan Kajian',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF203C32),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 11,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFDDF2E8),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      '4 VIDEO',
                      style: TextStyle(
                        color: Color(0xFF12664F),
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // DAFTAR KAJIAN
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 25),
                itemCount: videos.length,
                itemBuilder: (context, index) {
                  final video = videos[index];

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Material(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      clipBehavior: Clip.antiAlias,
                      elevation: 3,
                      shadowColor: const Color(0xFF167D61).withValues(alpha: 0.10),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => DetailVideoKajianPage(
                                videoId: video['id']!,
                                judul: video['judul']!,
                                channel: video['channel']!,
                                pembicara: video['pembicara']!,
                                deskripsi: video['deskripsi']!,
                              ),
                            ),
                          );
                        },
                        child: SizedBox(
                          height: 178,
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                            // THUMBNAIL
                            SizedBox(
                              width: 126,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Positioned.fill(
                                    child: Image.network(
                                      'https://img.youtube.com/vi/'
                                      '${video['id']}/hqdefault.jpg',
                                      fit: BoxFit.cover,
                                      errorBuilder: (_, _, _) {
                                        return Container(
                                          color: const Color(0xFFE5EFE9),
                                          alignment: Alignment.center,
                                          child: const Icon(
                                            Icons.video_library_rounded,
                                            size: 42,
                                            color: warnaKajian,
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    width: 43,
                                    height: 43,
                                    decoration: BoxDecoration(
                                      color: warnaKajian.withValues(alpha: 0.96),
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black.withValues(alpha: 0.18),
                                          blurRadius: 10,
                                        ),
                                      ],
                                    ),
                                    child: const Icon(
                                      Icons.play_arrow_rounded,
                                      color: Colors.white,
                                      size: 33,
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 8,
                                    left: 7,
                                    right: 7,
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 6,
                                        vertical: 5,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.black.withValues(alpha: 0.68),
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      child: const Text(
                                        'PUTAR KAJIAN',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 8,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            // INFORMASI VIDEO
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(12, 13, 12, 12),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.ondemand_video_rounded,
                                          size: 15,
                                          color: warnaKajian,
                                        ),
                                        const SizedBox(width: 5),
                                        Expanded(
                                          child: Text(
                                            video['channel']!,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontSize: 10,
                                              color: Color(0xFF7A8D83),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      video['judul']!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        height: 1.25,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF203C32),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    Text(
                                      video['deskripsi']!,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 10,
                                        height: 1.4,
                                        color: Color(0xFF667B70),
                                      ),
                                    ),
                                    const Spacer(),
                                    const Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            'Baca penjelasan',
                                            overflow: TextOverflow.ellipsis,
                                            style: TextStyle(
                                              color: warnaKajian,
                                              fontSize: 10,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4),
                                        Icon(
                                          Icons.arrow_forward_rounded,
                                          size: 15,
                                          color: warnaKajian,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}