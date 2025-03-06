import 'dart:ui';

import 'package:flutter/material.dart';

class MainBody extends StatelessWidget {
  const MainBody({
    required this.title,
    required this.child,
    this.fontFamily = 'Cairo',
    this.isScrollable = true,
    super.key,
    this.icon,
    this.onBackPress,
  });

  final Widget child;
  final String title;
  final bool isScrollable;
  final Widget? icon;
  final VoidCallback? onBackPress;

  final String fontFamily;
  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final bool isDarkMode = theme.brightness == Brightness.dark;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      // backgroundColor: getCurruntThemeBrightness(context)
      //     ? const Color.fromARGB(255, 15, 15, 15)
      //     : const Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        toolbarHeight: AppBar().preferredSize.height,
        surfaceTintColor: Colors.transparent,
        backgroundColor:
            isDarkMode
                ? const Color.fromARGB(50, 10, 10, 10)
                : const Color.fromARGB(50, 250, 250, 250),
        shadowColor: Theme.of(
          context,
        ).primaryColor.withOpacity(0.6).withAlpha(5),
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 25, sigmaY: 25),
            child: Container(
              color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.2),
            ),
          ),
        ),
        elevation: 10,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: onBackPress ?? () => Navigator.of(context).pop(),
        ),
        actions: [icon ?? const SizedBox()],
        title: Text(title, style: TextStyle(fontFamily: fontFamily)),
      ),
      body: Stack(
        children: [
          // const AppBackground(),
          if (isScrollable)
            SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.only(
                  top:
                      MediaQuery.of(context).padding.top +
                      AppBar().preferredSize.height +
                      10,
                ),
                child: child,
              ),
            )
          else
            Padding(
              padding: EdgeInsets.only(
                top:
                    MediaQuery.of(context).padding.top +
                    AppBar().preferredSize.height +
                    10,
                //  bottom: getBottomPadding(context),
              ),
              child: child,
            ),
          // Column(
          //   mainAxisAlignment: MainAxisAlignment.end,
          //   children: [
          //     BottomBack(),
          //   ],
          // ),
        ],
      ),
    );
  }
}
