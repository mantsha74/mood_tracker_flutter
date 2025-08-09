import 'package:cloud_firestore/cloud_firestore.dart';
import '../../core/date.dart';
import '../models/mood_entry.dart';

class MoodRepo {
  final _db = FirebaseFirestore.instance;
  CollectionReference<Map<String, dynamic>> _col(String uid)
  => _db.collection('users').doc(uid).collection('moods');

  Future<void> addToday({required String uid, required String mood, String? note}) async {
    final id = ymdKeyUtc(DateTime.now());
    final ref = _col(uid).doc(id);
    if ((await ref.get()).exists) { throw Exception('Already logged for today'); }
    await ref.set({'mood': mood, 'note': note, 'timestamp': FieldValue.serverTimestamp()});
  }

  Future<void> updateNote({required String uid, required String id, String? note})
  => _col(uid).doc(id).update({'note': note});

  Future<List<MoodEntry>> last7Days(String uid) async {
    final since = DateTime.now().toUtc().subtract(const Duration(days: 7));
    final snap = await _col(uid).where('timestamp', isGreaterThanOrEqualTo: since)
        .orderBy('timestamp', descending: true).limit(7).get();
    return snap.docs.map((d)=>MoodEntry.fromDoc(d.id,d.data())).toList();
  }
}
