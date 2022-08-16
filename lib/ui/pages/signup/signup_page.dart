import 'package:flutter/material.dart';

import '../../components/components.dart';
import '../../helpers/helpers.dart';
import 'components/components.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    void _hideKeyboard() {
      final currentFocus = FocusScope.of(context);
      if (!currentFocus.hasPrimaryFocus) {
        currentFocus.unfocus();
      }
    }

    return Scaffold(
        body: GestureDetector(
      onTap: _hideKeyboard,
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            LoginHeader(),
            Headline1(
              text: 'Login',
            ),
            Padding(
              padding: const EdgeInsets.all(32),
              child: Form(
                child: Column(
                  children: <Widget>[
                    NameInput(),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: EmailInput(),
                    ),
                    PasswordInput(),
                    Padding(
                      padding: const EdgeInsets.only(top: 8, bottom: 32),
                      child: PasswordConfirmationInput(),
                    ),
                    SignUpButton(),
                    FlatButton.icon(
                      onPressed: () {},
                      icon: Icon(Icons.exit_to_app),
                      label: Text(R.strings.login),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
