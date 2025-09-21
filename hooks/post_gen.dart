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

  final result = await Process.run('flutter', [
    'pub',
    'add',
    ...packages,
  ], runInShell: true);

  if (result.exitCode != 0) {
    context.logger.err('Failed to install packages:\n${result.stderr}');
  } else {
    context.logger.info(result.stdout);
  }

  progress.complete();
}
