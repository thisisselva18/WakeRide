import 'package:bus_app/pages/bus_metro.dart';
import 'package:bus_app/pages/cab_auto.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:animate_do/animate_do.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("WakeRide"),
        surfaceTintColor: Colors.purple,
        elevation: 5.0,
        shadowColor: Colors.white,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(25.0, 0.0, 25.0, 10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              FadeInDown(
                duration: Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 400),
                child: Container(
                  margin: const EdgeInsets.only(top: 10, left: 5, right: 5),
                  width: size.width / 1.5,
                  height: size.height / 3,
                  child: Lottie.asset("assets/Bell_anim.json", animate: true),
                ),
              ),
              const SizedBox(height: 5.0),
              FadeInDown(
                duration: Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 600),
                child: const Text(
                  "Choose your Mode of Transport",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 15.0),
              FadeInDown(
                duration: Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 800),
                child: SButton(
                  size: size,
                  borderColor: Colors.grey,
                  color: Colors.white,
                  img: 'assets/bus.png',
                  text: "Bus/Metro",
                  fontWeight: FontWeight.w700,
                  textStyle: null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => BusmetroPage()),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              FadeInDown(
                duration: Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 800),
                child: SButton(
                  size: size,
                  borderColor: Colors.grey,
                  color: Colors.white,
                  img: 'assets/taxi.png',
                  text: "Cab/Auto Rickshaw",
                  fontWeight: FontWeight.w700,
                  textStyle: null,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => CabautoPage()),
                    );
                  },
                ),
              ),
              Expanded(child: Container()),
              FadeInUp(
                duration: Duration(milliseconds: 1000),
                delay: const Duration(milliseconds: 400),
                child: const Text(
                  "© 2025 BuStop",
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class SButton extends StatelessWidget {
  const SButton({
    Key? key,
    required this.size,
    required this.color,
    required this.borderColor,
    required this.img,
    required this.text,
    required this.fontWeight,
    required this.textStyle,
    required this.onTap,
  }) : super(key: key);

  final Size size;
  final Color color;
  final Color borderColor;
  final String img;
  final String text;
  final FontWeight fontWeight;
  final TextStyle? textStyle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size.width / 1.2,
        height: size.height / 15,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: borderColor, width: 1),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(img, height: 40),
            const SizedBox(width: 10),
            Text(text, style: textStyle),
          ],
        ),
      ),
    );
  }
}
