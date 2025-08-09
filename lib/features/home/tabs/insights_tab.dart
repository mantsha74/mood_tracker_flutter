import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/insight_service.dart';
import '../../../state/mood_controller.dart';

class InsightsTab extends StatelessWidget {
  const InsightsTab({super.key});
  @override Widget build(BuildContext context){
    final Insights ins = context.watch<MoodController>().insights;
    String pretty(String m)=>({'happy':'😀 Happy','sad':'😞 Sad','angry':'😡 Angry','neutral':'😐 Neutral','-':'—'})[m] ?? m;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children:[
            const Text('Last 7 days', style: TextStyle(fontWeight: FontWeight.w600)),
            const SizedBox(height:8),
            _row('Most frequent', pretty(ins.mostFrequent)),
            _row('Happy days', '${ins.happyPercent.toStringAsFixed(0)}%'),
            _row('Longest streak', '${ins.longestStreak} day(s)'),
            const SizedBox(height:12),
            FilledButton.icon(onPressed: ()=>context.read<MoodController>().refresh(), icon: const Icon(Icons.refresh), label: const Text('Refresh')),
          ]),
        ),
      ),
    );
  }

  Widget _row(String k, String v)=>Padding(
    padding: const EdgeInsets.symmetric(vertical:6),
    child: Row(children:[Expanded(child: Text(k)), Text(v, style: const TextStyle(fontWeight: FontWeight.w600))]),
  );
}
