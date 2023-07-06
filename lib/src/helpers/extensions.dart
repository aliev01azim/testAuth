import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

final maskFormatter = MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {"#": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

extension StringExtensions on String? {
  bool get isValidEmail => RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(this!);

  bool get isMobileNumberValid {
    String regexPattern = r"[\d]";
    var regExp = RegExp(regexPattern);
    if (this!.isEmpty) {
      return false;
    } else if (regExp.hasMatch(this!)) {
      return true;
    }
    return false;
  }

  String get phoneFormat => maskFormatter.maskText(this!);
}
