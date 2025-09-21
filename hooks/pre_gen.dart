import 'package:mason/mason.dart';

void run(HookContext context) {
  List<String> scopes = context.vars['scopes'];
  scopes.forEach((scope) => scope.replaceAll('^&#x2F;', '/'));
  context.vars['scopes'] = scopes;
}
