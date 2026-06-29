import 'package:flutter/material.dart';
import 'package:metal_weight_calculator/core/extensions/context_extensions.dart';

Future<bool> showResetConfirmDialog(BuildContext context) async {
  final l10n = context.l10n;
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.confirmReset),
      content: Text(l10n.resetConfirmMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(ctx).colorScheme.error,
            foregroundColor: Colors.white,
          ),
          child: Text(l10n.confirm),
        ),
      ],
    ),
  );
  return result ?? false;
}

Future<bool> showClearHistoryDialog(BuildContext context) async {
  final l10n = context.l10n;
  final result = await showDialog<bool>(
    context: context,
    barrierDismissible: true,
    builder: (ctx) => AlertDialog(
      title: Text(l10n.confirmClearHistory),
      content: Text(l10n.clearHistoryMessage),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(ctx, false),
          child: Text(l10n.cancel),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(ctx, true),
          style: ElevatedButton.styleFrom(
            backgroundColor: Theme.of(ctx).colorScheme.error,
            foregroundColor: Colors.white,
          ),
          child: Text(l10n.clearAll),
        ),
      ],
    ),
  );
  return result ?? false;
}
