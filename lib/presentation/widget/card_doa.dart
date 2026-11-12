import 'package:flutter/material.dart';

class CardDoa extends StatelessWidget {
  final String image;
  final String title;
  final Function onTap;

  const CardDoa({
  super.key,
  required this.image,
  required this.title,
  required this.onTap,
});

  @override
    Widget build(BuildContext context) {
    return GestureDetector(
  onTap: () => onTap(),
  child: Container(
    decoration: BoxDecoration(
      // Letakkan pengaturan dekorasi di sini
      borderRadius: BorderRadius.circular(12),
      color: Colors.white,
    ),
    padding: const EdgeInsets.all(8.0),
    child: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
              Expanded(child: Image.asset(image, fit: BoxFit.contain)),
              const SizedBox(height: 6),
              Text(
                title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontFamily: "PoppinsMedium"),
              ), // Text
            ],
          ), // Column
        ), // Padding
      ), // Container
    ); // GestureDetector
  }
}