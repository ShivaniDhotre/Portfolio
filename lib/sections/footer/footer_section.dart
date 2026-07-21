import 'package:flutter/material.dart';
import 'package:web_app/constants.dart';

class FooterSection extends StatelessWidget {
  const FooterSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: const Color(0xFFCEE4FD).withValues(alpha: 0.4),
      padding: const EdgeInsets.symmetric(
        vertical: kDefaultPadding * 1.5,
        horizontal: kDefaultPadding * 2,
      ),
      child: Column(
        children: [
          Text(
            '© ${DateTime.now().year} Shivani Dhotre. All rights reserved.',
            style: const TextStyle(
              color: kTextLightColor,
              fontSize: 13,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: kDefaultPadding / 2),
          Text(
            'Built with Flutter 💙',
            style: const TextStyle(
              color: kTextColor,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }
}
