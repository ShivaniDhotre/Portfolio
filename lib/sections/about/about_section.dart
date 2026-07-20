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
        final isTablet = constraints.maxWidth < 900;

        final hPad = isMobile
            ? kDefaultPadding
            : isTablet
                ? kDefaultPadding * 2
                : kDefaultPadding * 3;

        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
          padding: EdgeInsets.symmetric(horizontal: hPad),
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
                    ExperienceCard(numOfExp: "6+"),
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
                    ExperienceCard(numOfExp: "6+"),
                    Expanded(
                      child: AboutSectionText(
                        text:
                            "Passionate about crafting responsive, scalable, and user-centric applications. Focused on clean architecture, intuitive UI design, and staying current with the latest mobile technologies.",
                      ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
