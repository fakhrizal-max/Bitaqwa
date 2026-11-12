import 'package:bitaqwa/data/doa_model.dart';
import 'package:bitaqwa/enum/kategori_doa_enum.dart';

/// =======================================================
/// CARA MENAMBAHKAN DOA
///
/// 1. Tentukan kategorinya
/// 2. Tambahkan Doa(...) pada List kategori tersebut
/// 3. Simpan
///
/// Tidak perlu mengubah Screen maupun Widget.
/// =======================================================

const Map<DoaCategory, List<Doa>> doaData = {
  DoaCategory.makananMinuman: [
    Doa(
      image: 'assets/images/ic_doa_makanan_minuman.png',
      title: 'Do’a Sebelum Makan',
      arabicText: 'بِسْمِ اللَّهِ',
      translation: 'Dengan menyebut nama Allah',
      reference: 'Hadist Riwayat Abu Dawud dan At-Tirmidzi',
    ),
    Doa(
      image: 'assets/images/ic_doa_makanan_minuman.png',
      title: 'Do’a Setelah Makan',
      arabicText:
          'الْحَمْدُ لِلَّهِ الَّذِي أَطْعَمَنِي هَذَا وَرَزَقَنِيهِ مِنْ غَيْرِ حَوْلٍ مِنِّي وَلَا قُوَّةٍ',
      translation:
          'Segala puji bagi Allah yang telah memberiku makanan ini dan rezeki ini dengan tanpa daya dan kekuatan dariku',
      reference: 'Hadist Riwayat Abu Dawud, At-Tirmidzi, dan Ibnu Majah',
    ),
    Doa(
      image: 'assets/images/ic_doa_makanan_minuman.png',
      title: 'Do’a Orang Yang Memberi Minum',
      arabicText: 'اللَّهُمَّ أَطْعِمْ مَنْ أَطْعَمَنِي، وَاسْقِ مَنْ سَقَانِي',
      translation:
          'Ya Allah, berilah makan orang yang memberi makan kepadaku dan berilah minum orang yang memberi minum kepadaku',
      reference: 'HR. Muslim',
    ),
    Doa(
      image: 'assets/images/ic_doa_makanan_minuman.png',
      title: 'Do’a Berbuka Di Rumah Orang Lain',
      arabicText:
          'أَفْطَرَ عِنْدَكُمُ الصَّائِمُونَ، وَأَكَلَ طَعَامَكُمُ الأَبْرَارُ، وَصَلَّتْ عَلَيْكُمُ الْمَلاَئِكَةُ',
      translation:
          'Semoga orang-orang yang berpuasa berbuka di tempat kalian, dan semoga orang-orang baik makan makanan kalian, dan semoga para malaikat mendoakan kalian',
      reference: 'HR. Abu Dawud',
    ),
    Doa(
      image: 'assets/images/ic_doa_makanan_minuman.png',
      title: 'Do’a Berbuka Puasa',
      arabicText:
          'ذَهَبَ الظَّمَأُ، وَابْتَلَّتِ الْعُرُوقُ، وَثَبَتَ الأَجْرُ إِنْ شَاءَ اللَّهُ',
      translation:
          'Telah hilang dahaga, urat-urat telah basah, dan telah ditetapkan pahala insya Allah',
      reference: 'HR. Abu Dawud',
    ),
  ],
  DoaCategory.pagiMalam: [
    Doa(
      image: 'assets/images/ic_doa_pagi_malam.png',
      title: 'Do’a Sebelum Tidur',
      arabicText: 'اللَّهُمَّ بِاسْمِكَ أَمُوتُ وَأَحْيَا',
      translation: 'Ya Allah, dengan nama-Mu aku mati dan aku hidup.',
      reference: 'Hadist Riwayat Bukhari',
    ),
    Doa(
      image: 'assets/images/ic_doa_pagi_malam.png',
      title: 'Do’a Bangun Tidur',
      arabicText:
          'الْحَمْدُ لِلَّهِ الَّذِي أَحْيَانَا بَعْدَ مَا أَمَاتَنَا وَإِلَيْهِ النُّشُورُ',
      translation:
          'Segala puji bagi Allah yang telah menghidupkan kami setelah mematikan kami, dan kepada-Nya kami akan dibangkitkan.',
      reference: 'Hadist Riwayat Bukhari',
    ),
    Doa(
      image: 'assets/images/ic_doa_pagi_malam.png',
      title: 'Do’a Apabila Ada Yang Menakutkan Dalam Tidur',
      arabicText:
          'أَعُوذُ بِكَلِمَاتِ اللَّهِ التَّامَّاتِ مِنْ غَضَبِهِ وَعِقَابِهِ، وَشَرِّ عِبَادِهِ، وَمِنْ هَمَزَاتِ الشَّيَاطِينِ وَأَنْ يَحْضُرُونِ',
      translation:
          'Aku berlindung dengan kalimat-kalimat Allah yang sempurna dari kemurkaan-Nya, hukuman-Nya, kejahatan hamba-hamba-Nya, godaan setan, dan agar mereka tidak mendatangiku.',
      reference: 'Hadist Riwayat Abu Dawud dan Shahih At-Tirmidzi',
    ),
  ],
  DoaCategory.rumah: [
    Doa(
      image: 'assets/images/ic_doa_rumah.png',
      title: 'Do’a Berpakaian',
      arabicText:
          'لْحَمْدُ لِلّهِ الَّذِي كَسَانِي هَذَا (الثَّوْبَ) وَرَزَقَنِيهِ مِنْ غَـيـْرِ حَوْلٍ مِنِّي وَلَا قُـوَّةٍ',
      translation:
          'Segala puji bagi Allah Yang telah memberikan pakaian ini kepadaku sebagai rezeki dari-Nya tanpa daya dan kekuatan dariku.',
      reference: 'Hadist Riwayat Bukhari, Muslim, Ibnu Majah, dan At-Tirmidzi',
    ),
    Doa(
      image: 'assets/images/ic_doa_rumah.png',
      title: 'Do’a Masuk WC',
      arabicText:
          'بِسْمِ اللَّهِ. اللَّهُـمَّ إِنِّي أَعُـوذُ بِـكَ مِـنَ الْخُـبْثِ وَالْخَبَائِثِ',
      translation:
          'Dengan nama Allah. Ya Allah, sesungguhnya aku berlindung kepada-Mu dari godaan setan laki-laki dan perempuan.',
      reference: 'Hadist Riwayat Bukhari dan Fathul Bari',
    ),
    Doa(
      image: 'assets/images/ic_doa_rumah.png',
      title: 'Do’a Keluar WC',
      arabicText: 'غُفْرَانَكَ',
      translation: 'Aku memohon ampun kepada-Mu.',
      reference:
          'Hadist Riwayat Abu Dawud, Ibnu Majah, At-Tirmidzi, An-Nasa\'i, dan Zadul Ma\'ad karya Ibnul Qayyim',
    ),
    Doa(
      image: 'assets/images/ic_doa_rumah.png',
      title: 'Do’a Masuk Rumah',
      arabicText:
          'بِسْـمِ اللّهِ وَلَجْنـَا، وَبِسْـمِ اللّهِ خَـرَجْنـَا، وَعَلَـى رَبِّنـَا تَوَكَّلْـنَا',
      translation:
          'Dengan nama Allah kami masuk, dengan nama Allah kami keluar, dan kepada Rabb kami, kami bertawakal. Kemudian mengucapkan salam kepada keluarga.',
      reference: 'Hadist Riwayat Abu Dawud',
    ),
    Doa(
      image: 'assets/images/ic_doa_rumah.png',
      title: 'Do’a Keluar Rumah',
      arabicText:
          'بِسْمِ اللَّهِ تَوَكَّلْتُ عَلَى اللَّهِ، وَلاَ حَوْلَ وَلاَ قُوَّةَ إِلاَّ بِاللَّهِ',
      translation:
          'Dengan nama Allah (aku keluar). Aku bertawakal kepada-Nya, dan tidak ada daya serta kekuatan kecuali dengan pertolongan Allah.',
      reference:
          'Hadist Riwayat Abu Dawud, At-Tirmidzi, Al-Albani, dan Shahih At-Tirmidzi',
    ),
  ],
  DoaCategory.perjalanan: [
    Doa(
      image: 'assets/images/ic_doa_perjalanan.png',
      title: 'Do’a Naik Kendaraan',
      arabicText:
          'بِسْمِ اللَّهِ وَالْحَمْدُ لِلَّهِ، سُبْحَانَ الَّذِي سَخَّرَ لَنَا هَذَا وَمَا كُنَّا لَهُ مُقْرِنِينَ، وَإِنَّا إِلَى رَبِّنَا لَمُنْقَلِبُونَ، الْحَمْدُ لِلَّهِ، الْحَمْدُ لِلَّهِ، الْحَمْدُ لِلَّهِ، اللَّهُ أَكْبَرُ، اللَّهُ أَكْبَرُ، اللَّهُ أَكْبَرُ، سُبْحَانَكَ اللَّهُمَّ إِنِّي ظَلَمْتُ نَفْسِي فَاغْفِرْ لِي، فَإِنَّهُ لَا يَغْفِرُ الذُّنُوبَ إِلَّا أَنْتَ',
      translation:
          'Dengan nama Allah. Segala puji bagi Allah. Maha Suci Allah yang telah menundukkan kendaraan ini untuk kami, padahal sebelumnya kami tidak mampu menguasainya. Sesungguhnya kami akan kembali kepada Rabb kami. Segala puji bagi Allah (3x). Allah Maha Besar (3x). Maha Suci Engkau, ya Allah. Sesungguhnya aku telah menzalimi diriku sendiri, maka ampunilah aku. Sesungguhnya tidak ada yang dapat mengampuni dosa selain Engkau.',
      reference: 'Hadist Riwayat Abu Dawud dan At-Tirmidzi',
    ),
    Doa(
      image: 'assets/images/ic_doa_perjalanan.png',
      title: 'Do’a Masuk Pasar',
      arabicText:
          'لَا إِلَهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، لَهُ الْمُلْكُ وَلَهُ الْحَمْدُ، يُحْيِي وَيُمِيتُ وَهُوَ حَيٌّ لَا يَمُوتُ، بِيَدِهِ الْخَيْرُ وَهُوَ عَلَى كُلِّ شَيْءٍ قَدِيرٌ',
      translation:
          'Tidak ada Tuhan yang berhak disembah selain Allah Yang Maha Esa, tiada sekutu bagi-Nya. Milik-Nya segala kerajaan dan segala puji. Dia menghidupkan dan mematikan. Dia Maha Hidup dan tidak akan mati. Di tangan-Nya segala kebaikan dan Dia Maha Kuasa atas segala sesuatu.',
      reference: 'Hadist Riwayat At-Tirmidzi dan Al-Hakim',
    ),
    Doa(
      image: 'assets/images/ic_doa_perjalanan.png',
      title: 'Do’a Musafir Kepada Orang Yang Ditinggalkan',
      arabicText: 'أَسْتَوْدِعُكُمُ اللَّهَ الَّذِي لَا تَضِيعُ وَدَائِعُهُ',
      translation:
          'Aku menitipkan kalian kepada Allah yang tidak akan menyia-nyiakan titipan-Nya.',
      reference: 'Hadist Riwayat Ahmad dan Ibnu Majah',
    ),
    Doa(
      image: 'assets/images/ic_doa_perjalanan.png',
      title: 'Do’a Orang Muqim Kepada Musafir',
      arabicText:
          'أَسْتَوْدِعُ اللَّهَ دِينَكَ، وَأَمَانَتَكَ، وَخَوَاتِيمَ عَمَلِكَ',
      translation:
          'Aku menitipkan agama, amanah, dan penutup amalmu kepada Allah.',
      reference: 'Hadist Riwayat Ahmad dan At-Tirmidzi',
    ),
  ],
  DoaCategory.sholat: [
    Doa(
      image: 'assets/images/ic_doa_sholat.png',
      title: 'Do’a Sebelum Wudhu',
      arabicText: 'بِسْمِ اللَّهِ',
      translation: 'Dengan nama Allah (aku berwudhu).',
      reference: 'Hadist Riwayat Abu Dawud, Ibnu Majah, dan Irwa\'ul Ghalil',
    ),
    Doa(
      image: 'assets/images/ic_doa_sholat.png',
      title: 'Do’a Setelah Wudhu',
      arabicText:
          'أَشْهَدُ أَنْ لَا إِلَـهَ إِلَّا اللَّهُ وَحْدَهُ لَا شَرِيكَ لَهُ، وَأَشْهَدُ أَنَّ مُحَمَّدًا عَبْدُهُ وَرَسُولُهُ، اللَّهُمَّ اجْعَلْنِي مِنَ التَّوَّابِينَ وَاجْعَلْنِي مِنَ الْمُتَطَهِّرِينَ',
      translation:
          'Aku bersaksi bahwa tidak ada Tuhan yang berhak disembah selain Allah Yang Maha Esa, tidak ada sekutu bagi-Nya. Aku bersaksi bahwa Muhammad adalah hamba dan utusan-Nya. Ya Allah, jadikanlah aku termasuk orang-orang yang bertaubat dan jadikanlah aku termasuk orang-orang yang bersuci.',
      reference:
          'Hadist Riwayat Muslim, At-Tirmidzi, Al-Albani, dan Shahih At-Tirmidzi',
    ),
    Doa(
      image: 'assets/images/ic_doa_sholat.png',
      title: 'Do’a Masuk Masjid',
      arabicText:
          'أَعُوذُ بِاللَّهِ الْعَظِيمِ، وَبِوَجْهِهِ الْكَرِيمِ، وَسُلْطَانِهِ الْقَدِيمِ، مِنَ الشَّيْطَانِ الرَّجِيمِ، بِسْمِ اللَّهِ، وَالصَّلَاةُ وَالسَّلَامُ عَلَى رَسُولِ اللَّهِ، اللَّهُمَّ افْتَحْ لِي أَبْوَابَ رَحْمَتِكَ',
      translation:
          'Aku berlindung kepada Allah Yang Maha Agung, dengan wajah-Nya Yang Mulia dan kekuasaan-Nya yang abadi, dari setan yang terkutuk. Dengan nama Allah, semoga shalawat dan salam tercurah kepada Rasulullah. Ya Allah, bukakanlah pintu-pintu rahmat-Mu untukku.',
      reference:
          'Hadist Riwayat Abu Dawud, Jami\' As-Saghir, Ibnu As-Sunni, Muslim, dan Ibnu Majah',
    ),
    Doa(
      image: 'assets/images/ic_doa_sholat.png',
      title: 'Do’a Keluar Masjid',
      arabicText:
          'بِسْمِ اللَّهِ، وَالصَّلَاةُ وَالسَّلَامُ عَلَى رَسُولِ اللَّهِ، اللَّهُمَّ إِنِّي أَسْأَلُكَ مِنْ فَضْلِكَ، اللَّهُمَّ اعْصِمْنِي مِنَ الشَّيْطَانِ الرَّجِيمِ',
      translation:
          'Dengan nama Allah. Semoga shalawat dan salam tercurah kepada Rasulullah. Ya Allah, sesungguhnya aku memohon karunia-Mu. Ya Allah, lindungilah aku dari godaan setan yang terkutuk.',
      reference:
          'Hadist Riwayat Abu Dawud, Shahih Al-Jami\', Muslim, dan Shahih Ibnu Majah',
    ),
  ],
  DoaCategory.etikaBaik: [
    Doa(
      image: 'assets/images/ic_doa_etika_baik.png',
      title: 'Do’a Ketika Bersin',
      arabicText:
          '(1) الْحَمْدُ لِلَّهِ\n(2) يَرْحَمُكَ اللَّهُ\n(3) يَهْدِيكُمُ اللَّهُ وَيُصْلِحُ بَالَكُمْ',
      translation:
          'Rasulullah ﷺ bersabda: Apabila salah seorang di antara kalian bersin, hendaklah ia mengucapkan "Alhamdulillah". Kemudian saudaranya mengucapkan "Yarhamukallah". Setelah itu orang yang bersin menjawab "Yahdikumullahu wa yushlihu balakum".',
      reference: 'Hadist Riwayat Bukhari',
    ),
    Doa(
      image: 'assets/images/ic_doa_etika_baik.png',
      title: 'Do’a Ketika Marah',
      arabicText: 'أَعُوذُ بِاللَّهِ مِنَ الشَّيْطَانِ الرَّجِيمِ',
      translation:
          'Aku berlindung kepada Allah dari godaan setan yang terkutuk.',
      reference: 'Hadist Riwayat Bukhari dan Muslim',
    ),
    Doa(
      image: 'assets/images/ic_doa_etika_baik.png',
      title: 'Do’a Dalam Majelis',
      arabicText:
          'رَبِّ اغْفِرْ لِي وَتُبْ عَلَيَّ إِنَّكَ أَنْتَ التَّوَّابُ الْغَفُورُ',
      translation:
          'Ya Rabbku, ampunilah aku dan terimalah taubatku. Sesungguhnya Engkau Maha Penerima Taubat lagi Maha Pengampun. (Dibaca seratus kali sebelum berdiri dari majelis).',
      reference: 'Hadist Riwayat Ibnu Majah dan Shahih At-Tirmidzi',
    ),
    Doa(
      image: 'assets/images/ic_doa_etika_baik.png',
      title: 'Do’a Untuk Orang Yang Berbuat Baik Kepadamu',
      arabicText: 'جَزَاكَ اللَّهُ خَيْرًا',
      translation: 'Semoga Allah membalasmu dengan kebaikan.',
      reference: 'Hadist Riwayat At-Tirmidzi',
    ),
  ],
};
