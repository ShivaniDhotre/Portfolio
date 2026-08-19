import 'package:flutter/material.dart';
import 'package:web_app/constants.dart';

import 'components/about_section_text.dart';
import 'components/about_text_with_sign.dart';
import 'components/experience_card.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
          padding: EdgeInsets.symmetric(horizontal: isMobile ? kDefaultPadding : 0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1110),
              child: isMobile
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AboutTextWithSign(),
                    SizedBox(height: kDefaultPadding * 1.5),
                    AboutSectionText(
                      text:
                          "Flutter Developer with hands-on experience building feature-rich mobile apps. Delivered impactful projects including a Fort Management app, a Real-Time POS Business platform, and a Parenting & Kids Growth Tracker.",
                    ),
                    SizedBox(height: kDefaultPadding * 1.5),
                    ExperienceCard(numOfExp: "1+"),
                    SizedBox(height: kDefaultPadding * 1.5),
                    AboutSectionText(
                      text:
                          "Passionate about crafting responsive, scalable, and user-centric applications. Focused on clean architecture, intuitive UI design, and staying current with the latest mobile technologies.",
                    ),
                  ],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    AboutTextWithSign(),
                    Expanded(
                      child: AboutSectionText(
                        text:
                            "Flutter Developer with hands-on experience building feature-rich mobile apps. Delivered impactful projects including a Fort Management app, a Real-Time POS Business platform, and a Parenting & Kids Growth Tracker.",
                      ),
                    ),
                    ExperienceCard(numOfExp: "1+"),
                    Expanded(
                      child: AboutSectionText(
                        text:
                            "Passionate about crafting responsive, scalable, and user-centric applications. Focused on clean architecture, intuitive UI design, and staying current with the latest mobile technologies.",
                      ),
                    ),
                  ],
                ),
            ),
          ),
        );
      },
    );
  }
}
