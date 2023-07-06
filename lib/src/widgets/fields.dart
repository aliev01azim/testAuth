import 'package:auth/src/helpers/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class UsernameField extends StatelessWidget {
  const UsernameField({
    super.key,
    required this.onSaved,
    required this.enabled,
  });

  final ValueSetter<String?> onSaved;
  final bool enabled;

  @override
  Widget build(BuildContext context) => TextFormField(
        enabled: enabled,
               style: textfieldStyle,
        decoration: _getDecor('Никнейм'),
        onSaved: onSaved,
        validator: _requiredField,
      );
}

class PhoneField extends StatelessWidget {
  const PhoneField({
    super.key,
    required this.onSaved,
    required this.enabled,
  });

  final ValueSetter<String?> onSaved;
  final bool enabled;

  @override
  Widget build(BuildContext context) => TextFormField(
        enabled: enabled,
               style: textfieldStyle,
        decoration: _getDecor('Номер телефона'),
        keyboardType: TextInputType.phone,
        onSaved: onSaved,
        validator: _requiredPhoneField,
      );
}

class EmailField extends StatelessWidget {
  const EmailField({
    super.key,
    required this.onSaved,
    required this.enabled,
  });

  final ValueSetter<String?> onSaved;
  final bool enabled;

  @override
  Widget build(BuildContext context) => TextFormField(
        enabled: enabled,
        style: textfieldStyle,
        decoration: _getDecor('Логин или почта'),
        keyboardType: TextInputType.emailAddress,
        onSaved: onSaved,
        validator: _requiredEmailField,
      );


}

class PasswordField extends StatelessWidget {
  const PasswordField({
    super.key,
    required this.onSaved,
    required this.enabled,
  });

  final ValueSetter<String?> onSaved;
  final bool enabled;

  @override
  Widget build(BuildContext context) => TextFormField(
        enabled: enabled,
        decoration: _getDecor('Пароль'),
        style: textfieldStyle,
        keyboardType: TextInputType.visiblePassword,
        obscureText: true,
        onSaved: onSaved,
        validator: _requiredField,
      );
}

String? _requiredField(String? value) =>
    value?.isEmpty ?? true ? 'Обязательное поле' : null;

String? _requiredEmailField(String? value) {
  return value?.isEmpty ?? true
      ? 'Обязательное поле'
      : !value.isValidEmail
          ? 'Неправильный формат почты'
          : null;
}

String? _requiredPhoneField(String? value) {
  return value?.isEmpty ?? true
      ? 'Обязательное поле'
      : !value.isMobileNumberValid
          ? 'Номер должен состоять из цифр'
          : null;
}
  InputDecoration _getDecor(String hint) {
    return  InputDecoration(
          border: InputBorder.none,
          hintText: hint,
          hintStyle: placeholderStyle,
          isDense: true,
          filled: true,
          contentPadding: const EdgeInsets.symmetric(vertical: 19, horizontal: 16),
          fillColor: Colors.white);
  }