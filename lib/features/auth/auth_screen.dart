import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../state/auth_controller.dart';

class AuthScreen extends StatefulWidget { const AuthScreen({super.key});
@override State<AuthScreen> createState()=>_AuthScreenState(); }

class _AuthScreenState extends State<AuthScreen> {
  final e=TextEditingController(), p=TextEditingController(); bool loading=false;

  @override void dispose(){ e.dispose(); p.dispose(); super.dispose(); }

  Future<void> _run(Future<void> Function() op) async {
    setState(()=>loading=true);
    try { await op(); } catch (err){ if(mounted) _snack(err.toString()); }
    if(mounted) setState(()=>loading=false);
  }

  void _snack(String m)=>ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(m)));

  @override Widget build(BuildContext context){
    final auth=context.read<AuthController>();
    return Scaffold(
      appBar: AppBar(title: const Text('Sign in')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(children:[
          TextField(controller:e, decoration: const InputDecoration(labelText:'Email')),
          const SizedBox(height:12),
          TextField(controller:p, decoration: const InputDecoration(labelText:'Password'), obscureText:true),
          const SizedBox(height:20),
          Row(children:[
            Expanded(child: FilledButton(
                onPressed: loading?null:()=>_run(()=>auth.signIn(e.text.trim(), p.text)),
                child: const Text('Sign In'))),
            const SizedBox(width:12),
            Expanded(child: OutlinedButton(
                onPressed: loading?null:()=>_run(()=>auth.signUp(e.text.trim(), p.text)),
                child: const Text('Sign Up')))
          ])
        ]),
      ),
    );
  }
}
