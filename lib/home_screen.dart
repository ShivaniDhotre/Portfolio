import 'package:flutter/material.dart';
import 'package:web_app/constants.dart';
import 'package:web_app/sections/about/about_section.dart';
import 'package:web_app/sections/contact/contact_section.dart';
import 'package:web_app/sections/skills/skills_section.dart';
import 'package:web_app/sections/recent_work/recent_work_section.dart';
import 'package:web_app/sections/education/education_section.dart';
import 'package:web_app/sections/experience/experience_section.dart';
import 'package:web_app/sections/topSection/top_section.dart';
import 'package:web_app/sections/footer/footer_section.dart';
import 'package:web_app/sections/topSection/components/nav_bar.dart';

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

  // Lazy loading state
  bool _showExperience = false;
  bool _showEducation = false;
  bool _showProjects = false;
  bool _showSkills = false;
  bool _showContact = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    
    // Load first sections after initial render
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(const Duration(milliseconds: 100), () {
        if (mounted) {
          setState(() {
            _showExperience = true;
            _showEducation = true;
          });
        }
      });
    });
  }

  void _onScroll() {
    final offset = _scrollController.offset;
    
    // Progressively load sections as user scrolls
    if (offset > 300 && !_showProjects) {
      setState(() => _showProjects = true);
    }
    if (offset > 800 && !_showSkills) {
      setState(() => _showSkills = true);
    }
    if (offset > 1200 && !_showContact) {
      setState(() => _showContact = true);
    }
  }

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
      body: Stack(
        children: [
          SingleChildScrollView(
            controller: _scrollController,
            child: Column(
              children: [
                TopSection(onNavTap: (i) => _scrollTo(sectionKeys[i])),
                SizedBox(height: kDefaultPadding * 2),
                AboutSection(key: _aboutKey),
                if (_showExperience)
                  ExperienceSection(key: _experienceKey)
                else
                  const SizedBox(height: 400),
                if (_showEducation)
                  EducationSection(key: _educationKey)
                else
                  const SizedBox(height: 400),
                if (_showProjects)
                  RecentWorkSection(key: _projectsKey, onHireMe: () => _scrollTo(_contactKey))
                else
                  const SizedBox(height: 600),
                if (_showSkills)
                  SkillsSection(key: _skillsKey)
                else
                  const SizedBox(height: 300),
                SizedBox(height: kDefaultPadding),
                if (_showContact)
                  ContactSection(key: _contactKey)
                else
                  const SizedBox(height: 500),
                if (_showContact) FooterSection(),
              ],
            ),
          ),
          // Sticky navbar pinned at top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: NavBar(onNavTap: (i) => _scrollTo(sectionKeys[i])),
          ),
        ],
      ),
    );
  }
}
