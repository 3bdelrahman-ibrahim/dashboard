import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

void showMyAlertDialog(
  BuildContext context,
  String title,
  String message, {
  String action1Label = 'موافق',
  VoidCallback? onAction2,
  String? action2Label,
}) {
  showDialog(
    context: context,
    builder: (_) => AlertDialog(
      insetPadding: const EdgeInsets.all(30),
      title: Text(
        title,
        style: const TextStyle(fontSize: 20),
      ),
      titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      content: Text(message),
      contentPadding: const EdgeInsets.all(20),
      actions: [
        TextButton(
          onPressed: () {
            try {
              context.pop();
            } catch (e) {
              log('Error: $e');
            }
          },
          child: Text(action1Label), // First Action
        ),
        if (onAction2 != null && action2Label != null)
          TextButton(
            onPressed: () {
              try {
                context.pop();
              } catch (e) {
                log('Error: $e');
              }
              //   onAction2(); // Trigger the second action callback
            },
            child: Text(action2Label), // Second Action
          ),
      ],
    ),
  );
}

void showMyAlertDialog2(
  BuildContext context,
  String title,
  String message, {
  String action1Label = 'موافق',
  VoidCallback? onAction2,
  String? action2Label,
}) {
  showModalBottomSheet(
    context: context,
    constraints: const BoxConstraints(
      minHeight: 300,
      maxHeight: 300,
    ),
    builder: (_) => Container(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(message),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                try {
                  launchUrl(
                    Uri.parse(
                      'https://play.google.com/store/apps/details?id=com.restauranttest.egypt',
                    ),
                  );
                } catch (e) {
                  log('Error: $e');
                }
              },
              child: const Text("تقييم من هنا"), // First Action
            )
          ],
        ),
      ),
    ),
  );
}
