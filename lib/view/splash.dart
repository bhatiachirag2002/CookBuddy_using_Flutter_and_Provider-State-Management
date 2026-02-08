import 'package:cook_buddy/utils/imports.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 3000), () {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.sizeOf(context).width;
    return Scaffold(
      backgroundColor: CustomColors.orange,
      body: SizedBox(
        width: width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Spacer(),
            Image.asset("assets/photos/robot.png", width: width * 0.9),
            Image.asset("assets/photos/name.png", width: width * 0.8),
            Spacer(),
            Text(
              "Developed by Chirag Bhatia",
              style: TextStyle(
                fontSize: width * 0.04,
                fontFamily: "Poppins",
                fontWeight: FontWeight.w600,
                color: CustomColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
