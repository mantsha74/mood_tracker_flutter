import 'package:flutter/foundation.dart';
import '../data/repo/mood_repo.dart';
import '../data/models/mood_entry.dart';
import 'insight_service.dart';

class MoodController extends ChangeNotifier {
  final MoodRepo repo; final String uid;
  List<MoodEntry> last7=[]; Insights insights=Insights('-',0,0);
  bool loading=false; String? error;
  MoodController({required this.repo, required this.uid});

  Future<void> refresh() async {
    loading=true; error=null; notifyListeners();
    try { last7 = await repo.last7Days(uid); insights = InsightsService().compute(last7); }
    catch(e){ error=e.toString(); }
    loading=false; notifyListeners();
  }

  Future<void> addToday(String mood, String? note) async { await repo.addToday(uid:uid,mood:mood,note:note); await refresh(); }
  Future<void> updateNote(String id, String? note) async { await repo.updateNote(uid:uid,id:id,note:note); await refresh(); }
}
