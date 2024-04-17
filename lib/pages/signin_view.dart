import 'package:flutter/material.dart';

import 'package:treatlab_new/layouts/auth_layout.dart';
import 'package:treatlab_new/widgets/signin_widget.dart';

class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return const AuthLayout(
      child: SigninWidget(),
    );
  }
}
