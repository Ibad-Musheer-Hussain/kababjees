import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:kababjees/HomeScreen.dart';
import 'package:lottie/lottie.dart';

class Introduction extends StatefulWidget {
  const Introduction({super.key});

  @override
  State<Introduction> createState() => _IntroductionState();
}

void onIntroEnd(BuildContext context) {
  Navigator.pushNamed(context, '/MainScreen');
}

class _IntroductionState extends State<Introduction> {
  final introKey = GlobalKey<IntroductionScreenState>();

  @override
  void initState() {
    super.initState();
  }

  void _onIntroEnd(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => const Homescreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      key: introKey,
      animationDuration: 750,
      globalBackgroundColor: Colors.white,
      autoScrollDuration: 5000,
      showDoneButton: true,
      infiniteAutoScroll: true,
      pages: [
        PageViewModel(
          title: "Order Kababjees Online",
          body:
              "Experience the convenience of ordering from Kababjees online. Enjoy a range of high-quality dishes delivered fresh to your home, perfect for any occasion.",
          image: Padding(
            padding: const EdgeInsets.only(top: 52.0),
            child: LottieBuilder.asset('lib/assets/ordering.json'),
          ),
        ),
        PageViewModel(
          title: "Carefully Prepared",
          body:
              "Meticulously crafted with attention to every flavor and ingredient, ensuring exceptional quality and precision in every dish",
          image: Padding(
            padding: const EdgeInsets.only(top: 52.0),
            child: LottieBuilder.asset('lib/assets/cooking.json'),
          ),
        ),
        PageViewModel(
          title: "Fast Delivery",
          body:
              "With Kababjees' fast delivery, your meals arrive quickly and with the quality you expect. Order now and experience prompt service with every delivery",
          image: Padding(
            padding: const EdgeInsets.only(top: 52.0),
            child: LottieBuilder.asset('lib/assets/delivery.json'),
          ),
        ),
      ],
      onDone: () => _onIntroEnd(context),
      onSkip: () => _onIntroEnd(context),
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      back: const Icon(Icons.arrow_back),
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
      next: const Icon(Icons.arrow_forward),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
      curve: Curves.ease,
      controlsMargin: const EdgeInsets.all(32),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.black87,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(14.0)),
        ),
      ),
    );
  }
}
