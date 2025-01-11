import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class CardWidget extends StatefulWidget {
  final double? width;
  final double? height;
  const CardWidget({super.key, this.width, this.height});

  @override
  State<CardWidget> createState() => _CardWidgetState();
}

class _CardWidgetState extends State<CardWidget> {
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        width: widget.width ?? 400,
        height: widget.height ?? 200,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 50),
        decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(
                image: const AssetImage("assets/images/bg.png"),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                    Colors.white.withOpacity(.3), BlendMode.srcIn))),
        child: Center(
          child: Container(
            width: 110,
            height: 122,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Container(
                  height: 100,
                  padding: const EdgeInsets.all(8.0),
                  child: PrettyQrView.data(
                    data: 'https://google.com',
                  ),
                ),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.camera_alt_rounded,
                      size: 20,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text("Scanner")
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
