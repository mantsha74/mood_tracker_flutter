import 'package:cloud_firestore/cloud_firestore.dart';

class MoodEntry {
  final String id;         // 'YYYY-MM-DD'
  final String mood;       // happy/sad/angry/neutral
  final String? note;
  final DateTime timestamp;

  MoodEntry({required this.id, required this.mood, this.note, required this.timestamp});

  factory MoodEntry.fromDoc(String id, Map<String, dynamic> m) => MoodEntry(
    id: id,
    mood: m['mood'] as String,
    note: m['note'] as String?,
    timestamp: (m['timestamp'] as Timestamp).toDate(),
  );
}
