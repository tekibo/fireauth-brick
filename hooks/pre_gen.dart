import 'package:mason/mason.dart';

void run(HookContext context) {
  final scopes = context.vars['scopes'] as List;
  final formattedScopes = scopes.map((s) => "'$s'").join(', ');
  context.vars['scopes'] = formattedScopes;
}
