import 'package:bitaqwa/enum/kategori_doa_enum.dart';

extension DoaCategoryExtension on DoaCategory {
  String get title {
    switch (this) {
      case DoaCategory.makananMinuman:
        return "Makanan & Minuman";

      case DoaCategory.pagiMalam:
        return "Pagi & Malam";

      case DoaCategory.rumah:
        return "Rumah";

      case DoaCategory.perjalanan:
        return "Perjalanan";

      case DoaCategory.sholat:
        return "Sholat";

      case DoaCategory.etikaBaik:
        return "Etika Baik";

      default:
        return "";
    }
  }

  String get image {
    switch (this) {
      case DoaCategory.makananMinuman:
        return "assets/images/makan_minum.png";

      case DoaCategory.pagiMalam:
        return "assets/images/pagi_&_malam.png";

      case DoaCategory.rumah:
        return "assets/images/rumah.png";

      case DoaCategory.perjalanan:
        return "assets/images/perjalanan.png";

      case DoaCategory.sholat:
        return "assets/images/sholat.png";

      case DoaCategory.etikaBaik:
        return "assets/images/etika_baik.png";

      default:
        return "";
    }
  }
}
