import 'package:auth/src/screens/profile/bloc/profile_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../helpers/helpers.dart';
import '../../widgets/widgets.dart';
import '../home_screen.dart';
import 'bloc/auth_bloc.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  //for info mini button
  final GlobalKey key = GlobalKey();

  //for switching login/resgister поэтому stateful widget,а в блок засовывать это было лень)
  bool login = true;

  //login data
  String _password = '';
  String _email = '';
  void _handlePasswordSaved(String? v) => _password = v ?? '';
  void _handleEmailSaved(String? v) => _email = v ?? '';

  //register data
  String _username = '';
  String _passwordR = '';
  String _emailR = '';
  String _phone = '';
  void _handleUsernameSaved(String? v) => _username = v ?? '';
  void _handlePasswordRSaved(String? v) => _passwordR = v ?? '';
  void _handleEmailRSaved(String? v) => _emailR = v ?? '';
  void _handlePhoneSaved(String? v) => _phone = v ?? '';

  final _formKey = GlobalKey<FormState>();
  void _handleSubmit() {
    final form = _formKey.currentState;
    if (form == null || !form.validate()) return;

    form.save(); //пошел через save,не через onChange или controller-ы
    if (login) {
      context.read<AuthBloc>().add(AuthLoginEvent(
            password: _password,
            email: _email,
          ));
    } else {
      context.read<AuthBloc>().add(AuthRegisterEvent(
            username: _username,
            password: _passwordR,
            email: _emailR,
            phone: _phone,
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final isProcessing = context.watch<AuthBloc>().state is AuthRegistering ||
        context.watch<AuthBloc>().state is AuthLogining;

    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        border: const Border(),
        middle: const Text(
          'Авторизация',
        ),
        trailing: CupertinoButton(
          child: const Icon(Icons.info),
          onPressed: () => showInfo(context, key,
              'Сделал И логин И регистрацию. \n Есть проверка на интернет\n Присутствует обновление токена \n Кэширую токен в хайв \n CupertinoApp:) \n Я бы мог всё сделать на кодогенераторах\n и доработать с валидаторами \n  но было лень)'),
        ),
      ),
      child: BlocListener<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthError) {
            // ошибки c сервака обрабатываю здесь
            showCupertinoSnackBar(context: context, message: state.error);
          }
          if (state is AuthLoaded) {
            context.read<ProfileBloc>().add(ProfileGetEvent(state.user));
            Navigator.of(context).pushAndRemoveUntil(
              CupertinoPageRoute(
                  builder: (context) => HomeScreen(user: state.user)),
              (_) => false,
            );
          }
        },
        child: Material(
          // color: const Color.fromRGBO(243, 244, 246, 1),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (login) ...[
                  EmailField(
                    onSaved: _handleEmailSaved,
                    enabled: !isProcessing,
                  ),
                  const AppDivider(),
                  PasswordField(
                    onSaved: _handlePasswordSaved,
                    enabled: !isProcessing,
                  ),
                ] else ...[
                  UsernameField(
                    onSaved: _handleUsernameSaved,
                    enabled: !isProcessing,
                  ),
                  const AppDivider(),
                  PhoneField(
                    onSaved: _handlePhoneSaved,
                    enabled: !isProcessing,
                  ),
                  const AppDivider(),
                  EmailField(
                    key: const ValueKey(
                        '1'), //тут ключи добавил чтоб при сетстэйте поле емайла и пароля ребилдились
                    onSaved: _handleEmailRSaved,
                    enabled: !isProcessing,
                  ),
                  const AppDivider(),
                  PasswordField(
                    key: const ValueKey('2'),
                    onSaved: _handlePasswordRSaved,
                    enabled: !isProcessing,
                  ),
                ],
                h32,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocSelector<AuthBloc, AuthState, bool>(
                    selector: (state) {
                      return state is AuthLogining;
                    },
                    builder: (context, isLoading) => CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      onPressed: () => login != true
                          ? setState(() => login = true)
                          : _handleSubmit(),
                      child: isLoading
                          ? const CupertinoActivityIndicator()
                          : const Text(
                              'Войти',
                              style: buttonStyle,
                            ),
                    ),
                  ),
                ),
                h19,
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: BlocSelector<AuthBloc, AuthState, bool>(
                    selector: (state) {
                      return state is AuthRegistering;
                    },
                    builder: (context, isLoading) => CupertinoButton.filled(
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      onPressed: () => login != false
                          ? setState(() => login = false)
                          : _handleSubmit(),
                      child: isLoading
                          ? const CupertinoActivityIndicator()
                          : const Text(
                              'Зарегистрироваться',
                              style: buttonStyle,
                            ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
