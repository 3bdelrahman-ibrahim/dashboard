// import 'package:restauranttest/app/router.dart';
// import 'package:restauranttest/app/theme.dart';
// import 'package:restauranttest/features/auth/auth_page.dart';
// import 'package:restauranttest/features/settings/bloc.dart';
// import 'package:restauranttest/features/settings/settings_bloc.dart';
// import 'package:restauranttest/generated/l10n.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_localizations/flutter_localizations.dart';
// import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/material.dart';

class SettingCard extends StatelessWidget {
  //   NewWidget(title: "Your Activities", description: "Check your recent activities", icon: Icons.bar_chart, color: Colors.orange),
  // NewWidget(title: "Messages", description: "You have 5 new messages", icon: Icons.message, color: Colors.purple),
  // NewWidget(title: "Settings", description: "Customize your experience", icon: Icons.settings, color: Colors.teal),

  const SettingCard({
    super.key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
  });

  final String title;
  final String description;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          const BoxShadow(
            color: Colors.black12,
            blurRadius: 10,
            offset: Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.2),
          child: Icon(icon, color: color),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(description),
        trailing: const Icon(Icons.arrow_forward_ios, color: Colors.grey),
      ),
    );
  }
}
