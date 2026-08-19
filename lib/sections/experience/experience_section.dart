import 'package:flutter/material.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/components/section_title.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;
        return Container(
          width: double.infinity,
          margin: EdgeInsets.symmetric(vertical: kDefaultPadding * 2),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: isMobile ? kDefaultPadding : 0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1110),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SectionTitle(
                    color: kPrimaryColor,
                    title: "Experience",
                    subTitle: "My Work Journey",
                  ),
                  SizedBox(height: kDefaultPadding * 1.5),
                  _ExperienceCard(isMobile: isMobile),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class _ExperienceCard extends StatelessWidget {
  final bool isMobile;
  const _ExperienceCard({required this.isMobile});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [kDefaultCardShadow],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: IntrinsicHeight(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Left accent bar
              Container(
                width: 4,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [kPrimaryColor, kPrimaryColor.withValues(alpha: 0.7)],
                  ),
                ),
              ),
              Expanded(
                child: isMobile
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _headerSection(),
                          const Divider(height: 1, thickness: 1, color: Color(0xFFF0F4FF)),
                          _detailsSection(),
                        ],
                      )
                    : Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 3,
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [Color(0xFFF5F9FF), Colors.white],
                                ),
                              ),
                              child: _headerSection(),
                            ),
                          ),
                          Container(width: 1, color: const Color(0xFFF0F4FF)),
                          Expanded(
                            flex: 5,
                            child: _detailsSection(),
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

  Widget _headerSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: kPrimaryColor,
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              "Current",
              style: TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.w700,
                letterSpacing: 0.5,
              ),
            ),
          ),
          const SizedBox(height: 14),
          const Text(
            "Brilliantech Software",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: Color(0xFF0D1B2A),
              letterSpacing: -0.3,
            ),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: kPrimaryLightColor.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Icon(Icons.work_outline_rounded, size: 13, color: kPrimaryColor),
              ),
              const SizedBox(width: 8),
              const Text(
                "Flutter Developer",
                style: TextStyle(
                  fontSize: 14,
                  color: kPrimaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          _infoRow(Icons.calendar_today_outlined, "Jan 2025 – Present  ·  1+ Year"),
          const SizedBox(height: 6),
          _infoRow(Icons.location_on_outlined, "On-site"),
        ],
      ),
    );
  }

  Widget _infoRow(IconData icon, String text) {
    return Row(
      children: [
        Icon(icon, size: 13, color: Colors.grey[400]),
        const SizedBox(width: 7),
        Text(
          text,
          style: TextStyle(fontSize: 13, color: Colors.grey[500], height: 1.4),
        ),
      ],
    );
  }

  Widget _detailsSection() {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _sectionLabel("Responsibilities"),
          const SizedBox(height: 12),
          ...[
            "Developed and maintained internal company applications using Flutter.",
            "Implemented state management with GetX for scalable and clean architecture.",
            "Built responsive UI components following design specifications.",
            "Collaborated with the backend team to integrate REST APIs.",
            "Ensured app performance optimization and smooth user experience.",
          ].map((point) => _bullet(point)),
          const SizedBox(height: 20),
          _sectionLabel("Tech Stack"),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: const [
              "Flutter", "Dart", "GetX", "REST API", "Git",
            ].map((t) => _Tag(label: t)).toList(),
          ),
        ],
      ),
    );
  }

  Widget _sectionLabel(String text) {
    return Row(
      children: [
        Container(
          width: 3,
          height: 16,
          decoration: BoxDecoration(
            color: kPrimaryColor,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: kTextDarkColor,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _bullet(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 9),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: const EdgeInsets.only(top: 7),
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: kPrimaryColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 13.5,
                color: Colors.grey[700],
                height: 1.65,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String label;
  const _Tag({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: kPrimaryLightColor.withValues(alpha: 0.4),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: kPrimaryLightColor),
      ),
      child: Text(
        label,
        style: const TextStyle(
          fontSize: 13,
          color: kPrimaryColor,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
