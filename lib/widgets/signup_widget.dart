import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';

import 'package:treatlab_new/helper/defines.dart';

class SignupWidget extends StatelessWidget {
  const SignupWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Create Account",
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
          "Full name",
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
            hintText: 'Enter your full name',
          ),
        ),
        const SizedBox(height: 10),
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
        const SizedBox(height: 10),
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
          onPressed: () => onSignUp(),
          child: const Text('Signup'),
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
            Text(" Or signup with Google ",
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
          onPressed: () => onSignUp(),
          child: const Text('Continue with Google'),
        ),
        const SizedBox(height: 20),
        RichText(
            text: TextSpan(
          children: [
            const TextSpan(
                text: 'Already have an account? ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w200,
                )),
            TextSpan(
              text: 'Login',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w200,
                decoration: TextDecoration.underline,
              ),
              recognizer: TapGestureRecognizer()
                ..onTap = () => onLogin(context),
            ),
          ],
        )),
      ],
    );
  }

  onSignUp() {}

  onTermsNConditions() {}

  onLogin(BuildContext context) {
    Navigator.of(context).pushReplacementNamed('/login');
  }
}
