import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../state/mood_controller.dart';

class HistoryTab extends StatelessWidget {
  const HistoryTab({super.key});
  @override Widget build(BuildContext context){
    final m=context.watch<MoodController>();
    if(m.loading && m.last7.isEmpty) return const Center(child:CircularProgressIndicator());
    if(m.last7.isEmpty) return const Center(child: Text('No mood logs yet'));
    return ListView.separated(
      padding: const EdgeInsets.all(12), itemCount: m.last7.length,
      separatorBuilder: (_, __)=>const SizedBox(height:8),
      itemBuilder: (_, i){
        final e=m.last7[i];
        final emoji = {'happy':'😀','sad':'😞','angry':'😡','neutral':'😐'}[e.mood] ?? '—';
        return ListTile(
          title: Text(e.id), leading: Text(emoji, style: const TextStyle(fontSize:24)),
          subtitle: Text((e.note??'').isEmpty?'No note':e.note!),
          onTap: ()=>_edit(context, e.id, e.note),
        );
      },
    );
  }

  Future<void> _edit(BuildContext context, String id, String? current) async {
    final ctrl=TextEditingController(text: current??'');
    await showModalBottomSheet(context: context, isScrollControlled:true, builder:(_){
      return Padding(
        padding: EdgeInsets.only(left:16,right:16,top:16,bottom:16+MediaQuery.of(context).viewInsets.bottom),
        child: Column(mainAxisSize: MainAxisSize.min, children:[
          const Text('Edit note', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height:8),
          TextField(controller: ctrl, maxLines:4, decoration: const InputDecoration(border: OutlineInputBorder())),
          const SizedBox(height:8),
          SizedBox(width:double.infinity, child: FilledButton(
              onPressed: () async { await context.read<MoodController>().updateNote(id, ctrl.text.trim().isEmpty?null:ctrl.text.trim()); if(context.mounted) Navigator.pop(context); },
              child: const Text('Save')))
        ]),
      );
    });
  }
}
