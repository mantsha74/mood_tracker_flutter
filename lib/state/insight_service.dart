import '../data/models/mood_entry.dart';

class Insights {
  final String mostFrequent; final double happyPercent; final int longestStreak;
  Insights(this.mostFrequent,this.happyPercent,this.longestStreak);
}

class InsightsService {
  Insights compute(List<MoodEntry> list){
    if (list.isEmpty) return Insights('-',0,0);
    final counts=<String,int>{};
    for(final e in list){ counts[e.mood]=(counts[e.mood]??0)+1; }
    final most = counts.entries.reduce((a,b)=>a.value>=b.value?a:b).key;
    final happy = (counts['happy']??0) / list.length * 100;

    final sorted=[...list]..sort((a,b)=>a.id.compareTo(b.id));
    int best=1,cur=1;
    for(int i=1;i<sorted.length;i++){
      if(sorted[i].mood==sorted[i-1].mood) cur++; else { if(cur>best) best=cur; cur=1; }
    }
    if(cur>best) best=cur;
    return Insights(most, happy, best);
  }
}
