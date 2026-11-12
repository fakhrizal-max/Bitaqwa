import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

const Color warnaDetailKajian = Color(0xFF167D61);
const Color latarDetailKajian = Color(0xFFF3F8F5);

class DetailVideoKajianPage extends StatefulWidget {
  final String videoId;
  final String judul;
  final String channel;
  final String pembicara;
  final String deskripsi;

  const DetailVideoKajianPage({
    super.key,
    required this.videoId,
    required this.judul,
    required this.channel,
    required this.pembicara,
    required this.deskripsi,
  });

  @override
  State<DetailVideoKajianPage> createState() =>
      _DetailVideoKajianPageState();
}

class _DetailVideoKajianPageState
    extends State<DetailVideoKajianPage> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.videoId,
      autoPlay: false,
      params: const YoutubePlayerParams(
        showControls: true,
        showFullscreenButton: true,
        strictRelatedVideos: true,
      ),
    );
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  Future<void> bukaYouTube() async {
    final Uri url = Uri.parse(
      'https://www.youtube.com/watch?v=${widget.videoId}',
    );

    final berhasil = await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    );

    if (!berhasil && mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Video tidak dapat dibuka. Coba lagi nanti.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: latarDetailKajian,
      body: SafeArea(
        child: Column(
          children: [
            // HEADER
            Container(
              padding: const EdgeInsets.fromLTRB(8, 9, 18, 15),
              decoration: const BoxDecoration(
                color: warnaDetailKajian,
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(26),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(
                      Icons.arrow_back_ios_new_rounded,
                      color: Colors.white,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      widget.judul,
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // ISI DETAIL
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.only(bottom: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // VIDEO PLAYER
                    Container(
                      margin: const EdgeInsets.fromLTRB(16, 18, 16, 0),
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF167D61).withValues(
                              alpha: 0.14,
                            ),
                            blurRadius: 20,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      clipBehavior: Clip.antiAlias,
                      child: YoutubePlayer(
                        controller: _controller,
                        aspectRatio: 16 / 9,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(18, 22, 18, 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // INFORMASI CHANNEL
                          Container(
                            padding: const EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFE1EEE6),
                              ),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  width: 50,
                                  height: 50,
                                  decoration: BoxDecoration(
                                    gradient: const LinearGradient(
                                      colors: [
                                        Color(0xFFDDF2E8),
                                        Color(0xFFF3FAF6),
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                  child: const Icon(
                                    Icons.menu_book_rounded,
                                    color: warnaDetailKajian,
                                    size: 27,
                                  ),
                                ),
                                const SizedBox(width: 13),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.channel,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Color(0xFF788B81),
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 5),
                                      Text(
                                        widget.pembicara,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: Color(0xFF24483B),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(
                                  Icons.verified_rounded,
                                  color: Color(0xFF7AB99D),
                                  size: 20,
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 25),

                          // JUDUL
                          Text(
                            widget.judul,
                            style: const TextStyle(
                              fontSize: 25,
                              height: 1.28,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF203C32),
                            ),
                          ),

                          const SizedBox(height: 20),

                          // JUDUL DESKRIPSI
                          Row(
                            children: [
                              Container(
                                width: 5,
                                height: 25,
                                decoration: BoxDecoration(
                                  color: warnaDetailKajian,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              const SizedBox(width: 10),
                              const Text(
                                'Tentang Kajian',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF203C32),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 13),

                          // DESKRIPSI VIDEO
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(17),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(18),
                              border: Border.all(
                                color: const Color(0xFFE4EEE8),
                              ),
                            ),
                            child: Text(
                              widget.deskripsi,
                              style: const TextStyle(
                                fontSize: 14,
                                height: 1.85,
                                color: Color(0xFF62776C),
                              ),
                            ),
                          ),

                          const SizedBox(height: 22),

                          // KOTAK PENGINGAT
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(18),
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                colors: [
                                  Color(0xFFDDF2E8),
                                  Color(0xFFF3FAF6),
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(
                                color: const Color(0xFFCDE7DA),
                              ),
                            ),
                            child: const Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.lightbulb_rounded,
                                  color: warnaDetailKajian,
                                  size: 27,
                                ),
                                SizedBox(width: 12),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Catatan Kebaikan',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 15,
                                          color: Color(0xFF24483B),
                                        ),
                                      ),
                                      SizedBox(height: 7),
                                      Text(
                                        'Jangan berhenti pada menonton '
                                        'kajian saja. Ambil pelajaran '
                                        'yang bermanfaat dan usahakan '
                                        'untuk mengamalkannya dalam '
                                        'kehidupan sehari-hari.',
                                        style: TextStyle(
                                          fontSize: 12,
                                          height: 1.8,
                                          color: Color(0xFF62776C),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(height: 22),

                          // TOMBOL BUKA YOUTUBE
                          SizedBox(
                            width: double.infinity,
                            child: ElevatedButton.icon(
                              onPressed: bukaYouTube,
                              icon: const Icon(
                                Icons.open_in_new_rounded,
                                color: Colors.white,
                              ),
                              label: const Text(
                                'Buka di YouTube',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                              ),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: warnaDetailKajian,
                                elevation: 0,
                                padding: const EdgeInsets.symmetric(
                                  vertical: 17,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
