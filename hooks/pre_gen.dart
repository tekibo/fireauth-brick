import 'package:mason/mason.dart';

void run(HookContext context) {
  context.vars['scopes'].forEach((scope) => scope.replaceAll('^&#x2F;', '/'));
}
