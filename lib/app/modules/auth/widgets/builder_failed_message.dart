import 'package:flutter/material.dart';

class BuilderFailedMessage extends StatelessWidget {
  final String? failedMsg;

  const BuilderFailedMessage({
    super.key,
    required this.failedMsg,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (failedMsg != null) {
      return Text(
        'Username atau password salah',
        style: theme.textTheme.labelLarge?.copyWith(
          color: Colors.red,
        ),
      );
    } else {
      return const SizedBox();
    }
  }
}
