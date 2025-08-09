import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/constants.dart';
import '../../../state/mood_controller.dart';

class AddMoodTab extends StatefulWidget { const AddMoodTab({super.key});
@override State<AddMoodTab> createState()=>_AddMoodTabState(); }

class _AddMoodTabState extends State<AddMoodTab>{
  String? _selected; final note=TextEditingController(); bool saving=false;
  @override void dispose(){ note.dispose(); super.dispose(); }

  Future<void> _save() async {
    if(_selected==null) return;
    setState(()=>saving=true);
    try { await context.read<MoodController>().addToday(_selected!, note.text.trim().isEmpty?null:note.text.trim()); }
    catch(e){ if(mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))); }
    if(mounted){ setState(()=>saving=false); note.clear(); _selected=null; }
  }

  @override Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(children:[
        Wrap(spacing:8, children: moods.map((m)=>ChoiceChip(
          label: Text(moodLabel[m]!), selected: _selected==m,
          onSelected: (_)=>setState(()=>_selected=m),
        )).toList()),
        const SizedBox(height:12),
        TextField(controller:note, maxLines:3, decoration: const InputDecoration(border: OutlineInputBorder(), labelText:'Note (optional)')),
        const Spacer(),
        SizedBox(width:double.infinity, child: FilledButton(
            onPressed: (_selected==null||saving)?null:_save, child: Text(saving?'Saving...':'Save today\'s mood')))
      ]),
    );
  }
}
