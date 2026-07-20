class RecentWork {
  final int id;
  final String title;
  final String category;
  final String description;
  final List<String> tech;

  RecentWork({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.tech,
  });
}

List<RecentWork> recentWorks = [
  RecentWork(
    id: 1,
    title: "Fort Management App",
    category: "Mobile Application",
    description:
        "An app to manage and explore historical forts with details, navigation, and visit tracking. Built with Flutter and Firebase.",
    tech: ["Flutter", "Dart", "Firebase"],
  ),
  RecentWork(
    id: 2,
    title: "Real-Time POS Business Platform",
    category: "Business Application",
    description:
        "A point-of-sale platform for real-time inventory, billing, and sales reporting. Integrated REST APIs for live data sync.",
    tech: ["Flutter", "GetX", "REST API"],
  ),
  RecentWork(
    id: 3,
    title: "Parenting & Kids Growth Tracker",
    category: "Health & Lifestyle",
    description:
        "An app to track children's growth milestones, health records, and parenting tips with a clean, intuitive UI.",
    tech: ["Flutter", "Dart", "Firebase"],
  ),
];
