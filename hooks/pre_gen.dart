import 'package:mason/mason.dart';

void run(HookContext context) {
  final scopes = context.vars['scopes'];
  final newScopes = [];
  for (var scope in scopes) {
    newScopes.add('${scope}');
  }
  context.vars['scopes'] = newScopes;
}
