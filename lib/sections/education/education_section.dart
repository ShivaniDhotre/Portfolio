import 'package:flutter/material.dart';
import 'package:web_app/components/section_title.dart';
import 'package:web_app/constants.dart';

class EducationSection extends StatelessWidget {
  const EducationSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        final hPad = isMobile ? kDefaultPadding : kDefaultPadding * 2;
        return _build(context, isMobile, hPad);
      },
    );
  }

  Widget _build(BuildContext context, bool isMobile, double hPad) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
      padding: EdgeInsets.symmetric(horizontal: isMobile ? kDefaultPadding : 0),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1110),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SectionTitle(
                title: "Education",
                subTitle: "My Academic Background",
                color: kAccentColor,
              ),
              SizedBox(height: kDefaultPadding * 1.5),
              isMobile
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: _cards(),
                    )
                  : IntrinsicHeight(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: _cards()
                            .map((c) => Expanded(child: c))
                            .toList(),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _cards() => [
        _EduCard(
          color: kPrimaryLightColor.withValues(alpha: 0.3),
          icon: Icons.school_outlined,
          iconColor: kPrimaryColor,
          degree: "BE in Computer Science",
          institution: "PVPIT College, Bavdhan, Pune",
          year: "2021",
          grade: "PVPIT",
        ),
        _EduCard(
          color: kAccentColor.withValues(alpha: 0.15),
          icon: Icons.menu_book_outlined,
          iconColor: kAccentColor,
          degree: "Diploma in Computer Science",
          institution: "Eklavya Polytechnic, Kothrud, Pune",
          year: "2018",
          grade: "Eklavya Polytechnic",
        ),
        _EduCard(
          color: kAccentYellow.withValues(alpha: 0.15),
          icon: Icons.auto_stories_outlined,
          iconColor: kAccentYellow,
          degree: "HSC (12th)",
          institution: "HRV Jr. College, Shivaji Nagar, Pune",
          year: "2015",
          grade: "HRV Jr. College",
        ),
      ];
}

class _EduCard extends StatefulWidget {
  final Color color;
  final IconData icon;
  final Color iconColor;
  final String degree;
  final String institution;
  final String year;
  final String grade;

  const _EduCard({
    required this.color,
    required this.icon,
    required this.iconColor,
    required this.degree,
    required this.institution,
    required this.year,
    required this.grade,
  });

  @override
  State<_EduCard> createState() => _EduCardState();
}

class _EduCardState extends State<_EduCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        margin: EdgeInsets.all(kDefaultPadding),
        padding: EdgeInsets.all(kDefaultPadding * 1.5),
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [if (_hovered) kHoverShadow],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon circle
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 4),
                    blurRadius: 12,
                    color: Colors.black.withValues(alpha: 0.06),
                  ),
                ],
              ),
              child: Icon(widget.icon, color: widget.iconColor, size: 26),
            ),
            SizedBox(height: kDefaultPadding),
            Text(
              widget.degree,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A1A2E),
              ),
            ),
            SizedBox(height: kDefaultPadding * 0.4),
            Text(
              "${widget.grade}  —  ${widget.year}",
              style: TextStyle(fontSize: 13, color: kTextColor),
            ),
            SizedBox(height: kDefaultPadding * 0.8),
            Text(
              "Completed my ${widget.degree} from ${widget.institution} in ${widget.year}.",
              style: TextStyle(
                fontSize: 14,
                color: const Color(0xFF1A1A2E),
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
