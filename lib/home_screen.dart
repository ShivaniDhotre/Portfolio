import 'package:flutter/material.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/sections/about/about_section.dart';
import 'package:web_app/sections/contact/contact_section.dart';
import 'package:web_app/sections/skills/skills_section.dart';
import 'package:web_app/sections/recent_work/recent_work_section.dart';
import 'package:web_app/sections/education/education_section.dart';
import 'package:web_app/sections/experience/experience_section.dart';
import 'package:web_app/sections/topSection/top_section.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _scrollController = ScrollController();

  final _aboutKey = GlobalKey();
  final _experienceKey = GlobalKey();
  final _educationKey = GlobalKey();
  final _projectsKey = GlobalKey();
  final _skillsKey = GlobalKey();
  final _contactKey = GlobalKey();

  void _scrollTo(GlobalKey key) {
    final ctx = key.currentContext;
    if (ctx == null) return;
    Scrollable.ensureVisible(
      ctx,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final sectionKeys = [
      _aboutKey,
      _experienceKey,
      _educationKey,
      _projectsKey,
      _skillsKey,
      _contactKey,
    ];

    return Scaffold(
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            TopSection(onNavTap: (i) => _scrollTo(sectionKeys[i])),
            SizedBox(height: kDefaultPadding * 2),
            AboutSection(key: _aboutKey),
            ExperienceSection(key: _experienceKey),
            EducationSection(key: _educationKey),
            RecentWorkSection(key: _projectsKey, onHireMe: () => _scrollTo(_contactKey)),
            SkillsSection(key: _skillsKey),
            SizedBox(height: kDefaultPadding),
            ContactSection(key: _contactKey),
          ],
        ),
      ),
    );
  }
}
