import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taste/theme/style.dart';
import 'package:taste/utils/utils.dart';

const _kTermsOfServiceUrl = 'https://trytaste.app/tos.html';
const _kPrivacyPolicyUrl = 'https://trytaste.app/privacy_policy.html';

class TermsAndPolicyText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      child: RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
              // set the default style for the children TextSpans
              style: const TextStyle(
                color: kDarkGrey,
                fontFamily: 'Quicksand',
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              children: [
                const TextSpan(
                  text: 'By signing in you agree with our ',
                ),
                TextSpan(
                  text: 'Terms of Service',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(_kTermsOfServiceUrl, context),
                ),
                const TextSpan(
                  text: ' and ',
                ),
                TextSpan(
                  text: 'Privacy Policy.',
                  style: const TextStyle(
                    decoration: TextDecoration.underline,
                    fontWeight: FontWeight.bold,
                  ),
                  recognizer: TapGestureRecognizer()
                    ..onTap = () => launchUrl(_kPrivacyPolicyUrl, context),
                ),
              ])),
    );
  }
}
