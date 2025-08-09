import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/auth_controller.dart';
import '../../state/mood_controller.dart';
import '../../data/repo/mood_repo.dart';
import 'tabs/add_mood_tab.dart';
import 'tabs/history_tab.dart';
import 'tabs/insights_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override Widget build(BuildContext context) {
    final uid = context.read<AuthController>().user!.uid;
    final repo = context.read<MoodRepo>();
    return ChangeNotifierProvider(
      create: (_) => MoodController(repo: repo, uid: uid)..refresh(),
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            title: const Text('Mood Tracker'),
            bottom: const TabBar(tabs: [Tab(text:'Add'),Tab(text:'History'),Tab(text:'Insights')]),
            actions: [IconButton(onPressed: ()=>context.read<AuthController>().signOut(), icon: const Icon(Icons.logout))],
          ),
          body: const TabBarView(children:[AddMoodTab(),HistoryTab(),InsightsTab()]),
        ),
      ),
    );
  }
}
