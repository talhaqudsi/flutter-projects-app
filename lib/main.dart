import 'package:flutter/material.dart';
import 'package:project_app/about.dart';
import 'package:project_app/bmi_calculator.dart';
import 'package:project_app/math_calculator.dart';
import 'package:project_app/word_counter.dart';


void main() {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false,
    theme: ThemeData(colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple)),
    title: "Project App",
    home: ProjectApp(title: "Project App"),
    )
  );
}

class ProjectApp extends StatefulWidget {
  const ProjectApp({super.key, required this.title});
  final String title;

  @override
  State<ProjectApp> createState() => _ProjectAppState();
}

class _ProjectAppState extends State<ProjectApp> {
  int _selectedIndex = 0;
  var pages = <Widget>[
    AppsPage(),
    About(),
  ];

  selectPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        foregroundColor: Colors.white,
        backgroundColor: Colors.deepPurple,
      ),
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        destinations: [
          NavigationDestination(icon: Icon(Icons.apps), label: "Apps"),
          NavigationDestination(icon: Icon(Icons.info), label: "About"),
        ],
        onDestinationSelected: (index) => selectPage(index),
      ),
    );
  }
}

class AppsPage extends StatefulWidget {
  const AppsPage({super.key});

  @override
  State<AppsPage> createState() => _AppsPageState();
}

class _AppsPageState extends State<AppsPage> {
  var tabs = <Widget>[
    MathCalc(),
    BMICalc(),
    WordCounter(),
  ];

  @override
  Widget build(BuildContext context) {
    // Using DefaultTabController to manage the tabs
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          flexibleSpace: TabBar(
            tabs: <Widget>[
              Tab(text: "Math Calculator", icon: Icon(Icons.calculate)),
              Tab(text: "BMI Calculator", icon: Icon(Icons.scale)),
              Tab(text: "Word Counter", icon: Icon(Icons.format_list_numbered)),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[
            // Showing only icons for demonstration purposes.
            // Each entry within the TabBarView is a separate page
            tabs[0],
            tabs[1],
            Icon(Icons.sunny, color: Colors.amber[800], size: 96),
          ],
        ),
      ),
    );
  }
}
