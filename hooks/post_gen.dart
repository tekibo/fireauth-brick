import 'dart:io';
import 'package:mason/mason.dart';

Future<void> run(HookContext context) async {
  final progress = context.logger.progress('Installing packages');

  final packages = ['firebase_auth'];

  if (context.vars['useCredMgr'] == 'true') {
    packages.add('credential_manager');
  } else {
    packages.add('google_sign_in');
  }

  await Process.run('flutter', ['pub', 'add', ...packages]);

  progress.complete();
}
