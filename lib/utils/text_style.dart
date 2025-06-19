
import 'imports.dart';

class CustomTextStyle {

  static TextStyle error({required BuildContext context}) {
    return TextStyle(
      color: CustomColors.red,
      fontSize: MediaQuery.sizeOf(context).width * 0.045,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w700,
    );
  }
  static TextStyle heading({required BuildContext context}) {
    return TextStyle(
      color: CustomColors.black,
      fontSize: MediaQuery.sizeOf(context).width * 0.04,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w800,
    );
  }
  static TextStyle title({required BuildContext context}) {
    return TextStyle(
      color: CustomColors.black,
      fontSize: MediaQuery.sizeOf(context).width * 0.035,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle description({required BuildContext context}) {
    return TextStyle(
      color: CustomColors.black,
      fontSize: MediaQuery.sizeOf(context).width * 0.032,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );
  }
  static TextStyle textButton({required BuildContext context}) {
    return TextStyle(
      decoration: TextDecoration.underline,
      color: Colors.black,
      fontSize: MediaQuery.sizeOf(context).width * 0.032,
      fontFamily: 'Poppins',
      fontWeight: FontWeight.w500,
    );
  }
}
