import 'package:flutter/material.dart';
import 'package:custom_onboard/custom_onboard.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Custom Onboard',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomOnboard(
        pages: [
          PageModel(
            title: "Onboarding 1",
            body:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text",
            imagePath: "assets/images/onboard1.png",
          ),
          PageModel(
            title: "Onboarding 2",
            body:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s.",
            imagePath: "assets/images/onboard2.png",
          ),
          PageModel(
            title: "Onboarding 3",
            body:
                "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book.",
            imagePath: "assets/images/onboard3.png",
          ),
        ],

        finishButtonText: "Get Started",
        // showAnimation: false,
        onFinishClick: () {
          debugPrint('Onboarding completed');
          // Navigate to your desired page here.
          // Example: Navigator.pushNamed(context, '/your_desired_page');
        },
        onSkipClick: () {
          debugPrint('Onboarding skipped');
          // Navigate to your desired page here.
          // Example: Navigator.pushNamed(context, '/your_desired_page');
        },
      ),
    );
  }
}
