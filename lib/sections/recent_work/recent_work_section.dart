import 'package:flutter/material.dart';
import 'package:web_app/components/hireme_card.dart';
import 'package:web_app/components/section_title.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/models/RecentWork.dart';

import 'components/recent_work_card.dart';

class RecentWorkSection extends StatelessWidget {
  final VoidCallback? onHireMe;
  const RecentWorkSection({Key? key, this.onHireMe}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: kDefaultPadding * 6),
      width: double.infinity,
      // just for demo
      // height: 600,
      decoration: BoxDecoration(
        color: Color(0xFFF7E8FF).withValues(alpha: 0.3),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/recent_work_bg.png"),
        ),
      ),
      child: Column(
        children: [
          Transform.translate(
            offset: Offset(0, -80),
            child: HireMeCard(onHireMe: onHireMe),
          ),
          SectionTitle(
            title: "Recent Works",
            subTitle: "My Projects",
            color: kAccentYellow,
          ),
          SizedBox(height: kDefaultPadding * 1.5),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: kDefaultPadding),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1110),
              child: Wrap(
                spacing: kDefaultPadding,
                runSpacing: kDefaultPadding * 2,
                children: List.generate(
                  recentWorks.length,
                  (index) => RecentWorkCard(index: index, press: () {}),
                ),
              ),
            ),
          ),
          SizedBox(height: kDefaultPadding * 5),
        ],
      ),
    );
  }
}
