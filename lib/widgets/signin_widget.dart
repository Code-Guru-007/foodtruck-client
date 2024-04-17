import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:treatlab_new/widgets/check_widget.dart';
import 'package:treatlab_new/helper/defines.dart';

class SigninWidget extends StatelessWidget {
  const SigninWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Hey, Welcome Back!",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: AppColor.woody.color,
              fontSize: 32,
              fontWeight: FontWeight.w400,
            )),
        Text(
          "continue with email",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: AppColor.pinky.color,
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(height: 30),
        const Text(
          "Email",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(height: 10),
        const TextField(
          style: TextStyle(height: 1.2, fontSize: 14),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(horizontal: 16),
            border: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(8))),
            filled: true,
            fillColor: Colors.white,
            hintText: 'Enter your email',
          ),
        ),
        const SizedBox(height: 20),
        const Text(
          "Password",
          textAlign: TextAlign.left,
          style: TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w200,
          ),
        ),
        const SizedBox(height: 10),
        const TextField(
            style: TextStyle(height: 1.2, fontSize: 14),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(horizontal: 16),
              border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(8))),
              filled: true,
              fillColor: Colors.white,
              hintText: 'Enter your password',
            )),
        const SizedBox(height: 10),
        Row(
          children: [
            const CheckWidget(),
            const Text(
              "Remember me",
              textAlign: TextAlign.left,
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
              ),
            ),
            // const FlexibleSpaceBar(),
            const Expanded(child: SizedBox(width: 10)),
            RichText(
                text: TextSpan(
              text: 'Forgot Password?',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => onForgotPassword(),
            ))
          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0xFFD6BD96),
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => onLogin(context),
          child: const Text('Login'),
        ),
        const SizedBox(height: 20),
        RichText(
            text: TextSpan(
          children: [
            const TextSpan(
                text: 'By continuing you are agreeing ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                )),
            TextSpan(
              text: 'our terms and conditions',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => onTermsNConditions(),
            ),
            const TextSpan(
                text: ' and our privacy policies.',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                )),
          ],
        )),
        const SizedBox(height: 20),
        const Row(
          children: [
            Expanded(child: Divider(color: Colors.white, thickness: 0.5)),
            Text(" Or login with Google ",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                )),
            Expanded(child: Divider(color: Colors.white, thickness: 0.5)),
          ],
        ),
        const SizedBox(height: 20),
        TextButton(
          style: TextButton.styleFrom(
            foregroundColor: Colors.black,
            backgroundColor: const Color(0xFFD6BD96),
            minimumSize: const Size.fromHeight(50),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () => onLogin(context),
          child: const Text('Continue with Google'),
        ),
        const SizedBox(height: 20),
        RichText(
            text: TextSpan(
          children: [
            const TextSpan(
                text: 'Don\'t have an account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                )),
            TextSpan(
              text: 'SignUp',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => onSignUp(context),
            ),
          ],
        )),
      ],
    );
  }

  onForgotPassword() {}

  onSignUp(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/signup');
  }

  onTermsNConditions() {}

  onLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/dishes');
  }
}
