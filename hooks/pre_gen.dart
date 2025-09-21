import 'package:mason/mason.dart';

void run(HookContext context) {
  final scopes = context.vars['scopes'];
  scopes.forEach(
    (scope) => scope.toString().replaceAll('^&#x2F;', '\/').toString(),
  );
  context.vars['scopes'] = scopes;
}
