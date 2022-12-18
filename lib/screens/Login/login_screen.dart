import 'package:flutter/material.dart';
import 'package:meu_produto/auth_service.dart';
import 'package:meu_produto/constants.dart';
import 'package:meu_produto/responsive.dart';

import '../../components/background.dart';
import 'components/login_form.dart';
import 'components/login_screen_top_image.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Background(
      child: SingleChildScrollView(
        child: Responsive(
          mobile: const MobileLoginScreen(),
          desktop: Row(
            children: [
              const Expanded(
                child: LoginScreenTopImage(),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    SizedBox(
                      width: 450,
                      child: LoginForm(),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MobileLoginScreen extends StatelessWidget {
  const MobileLoginScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const LoginScreenTopImage(),
        Row(
          children: const [
            Spacer(),
            Expanded(
              flex: 8,
              child: LoginForm(),
            ),
            Spacer(),
          ],
        ),
        Center(
          child: TextButton(
     
        onPressed: () {
         
        },
        style: TextButton.styleFrom(
            
            foregroundColor: kPrimaryColor, textStyle: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
           
            
        ),
        //Contents of the button
        child: const Text("Esqueci minha Senha")),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: <Widget>[
                IconButton(
                  color: Colors.blue,
                  icon: const Icon(FontAwesomeIcons.facebookF),
                  tooltip: 'Faça Login com Facebook',
                  onPressed: () {
                    AuthService().signInWithFacebook();
                  },
                ),
                Text('Facebook'),
              ],
            ),
            Column(
              children: <Widget>[
                IconButton(
                  color: Color.fromARGB(255, 5, 63, 110),
                  icon: const Icon(FontAwesomeIcons.google),
                  tooltip: 'Faça Login com Google',
                  onPressed: () {
                    AuthService().signInWithGoogle();
                  },
                ),
                Text('Google'),
              ],
            ),
            
          ],
        )
      ],
    );
  }
}
